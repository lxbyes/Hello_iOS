//
//  TweetsViewController.m
//  iosapp
//
//  Created by chenhaoxiang on 14-10-14.
//  Copyright (c) 2014年 oschina. All rights reserved.
//

#import "TweetsViewController.h"
#import "TweetDetailsViewController.h"
#import "TweetDetailsWithBottomBarViewController.h"
#import "UserDetailsViewController.h"
#import "ImageViewerController.h"
#import "TweetCell.h"
#import "OSCTweet.h"
#import "Config.h"
#import "Utils.h"
#import "TweetsLikeListViewController.h"
#import "OSCUser.h"
#import "TweetEditingVC.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import <MBProgressHUD.h>

static NSString * const kTweetCellID = @"TweetCell";


@interface TweetsViewController ()

@property (nonatomic, assign) int64_t uid;
@property (nonatomic, copy) NSString *topic;

@end


@implementation TweetsViewController


#pragma mark - init method

- (instancetype)initWithTweetsType:(TweetsType)type
{
    self = [super init];
    if (self) {
        switch (type) {
            case TweetsTypeAllTweets:
                _uid = 0; break;
            case TweetsTypeHotestTweets:
                _uid = -1; break;
            case TweetsTypeOwnTweets:
                _uid = [Config getOwnID];
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userRefreshHandler:)  name:@"userRefresh" object:nil];
                if (_uid == 0) {
                    // 显示提示页面
                }
                break;
            default:
                break;
        }
        
        self.needAutoRefresh = type != TweetsTypeOwnTweets;
        self.refreshInterval = 3600;
        self.kLastRefreshTime = [NSString stringWithFormat:@"TweetsRefreshInterval-%ld", type];
        
        [self setBlockAndClass];
    }
    
    return self;
}

- (instancetype)initWithUserID:(int64_t)userID
{
    self = [super init];
    if (!self) {return nil;}
    
    _uid = userID;
    [self setBlockAndClass];
    
    return self;
}

- (instancetype)initWithSoftwareID:(int64_t)softwareID
{
    self = [super init];
    if (self) {
        self.generateURL = ^NSString * (NSUInteger page) {
            return [NSString stringWithFormat:@"%@%@?project=%lld&pageIndex=%lu&%@", OSCAPI_PREFIX, OSCAPI_SOFTWARE_TWEET_LIST, softwareID, (unsigned long)page, OSCAPI_SUFFIX];
        };
        
        self.objClass = [OSCTweet class];
    }
    
    return self;
}

- (instancetype)initWithTopic:(NSString *)topic
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        
        _topic = topic;
        
        self.generateURL = ^NSString * (NSUInteger page) {
            NSString *URL = [NSString stringWithFormat:@"%@%@?title=%@&pageIndex=%lu&%@", OSCAPI_PREFIX, OSCAPI_TWEET_TOPIC_LIST, topic, (unsigned long)page, OSCAPI_SUFFIX];
            return [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        };
        
        self.objClass = [OSCTweet class];
        
        self.navigationItem.title = topic;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(topicEditing)];
    }
    
    return self;
    
}



- (void)setBlockAndClass
{
    __weak TweetsViewController *weakSelf = self;
    self.tableWillReload = ^(NSUInteger responseObjectsCount) {
        if (weakSelf.uid == -1) {weakSelf.lastCell.status = LastCellStatusFinished;}
        else {responseObjectsCount < 20? (weakSelf.lastCell.status = LastCellStatusFinished) :
                                         (weakSelf.lastCell.status = LastCellStatusMore);}
    };
    
    self.generateURL = ^NSString * (NSUInteger page) {
        return [NSString stringWithFormat:@"%@%@?uid=%lld&pageIndex=%lu&%@", OSCAPI_PREFIX, OSCAPI_TWEETS_LIST, weakSelf.uid, (unsigned long)page, OSCAPI_SUFFIX];
    };
    
    self.objClass = [OSCTweet class];
}


- (NSArray *)parseXML:(ONOXMLDocument *)xml
{
    return [[xml.rootElement firstChildWithTag:@"tweets"] childrenWithTag:@"tweet"];
}

#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[TweetCell class] forCellReuseIdentifier:kTweetCellID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Table view data source

// 图片的高度计算方法参考 http://blog.cocoabit.com/blog/2013/10/31/guan-yu-uitableview-zhong-cell-zi-gua-ying-gao-du-de-wen-ti/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    OSCTweet *tweet = self.objects[row];
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:kTweetCellID forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor themeColor];
    
    [self setBlockForCommentCell:cell];
    [cell setContentWithTweet:tweet];
    
    if (tweet.hasAnImage) {
        cell.thumbnail.hidden = NO;
        
#if 0
        UIImage *image = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:tweet.smallImgURL.absoluteString];
        
        // 有图就加载，无图则下载并reload tableview
        if (!image) {
            [cell.thumbnail setImage:[UIImage imageNamed:@"loading"]];
            [self downloadImageThenReload:tweet.smallImgURL];
        } else {
            [cell.thumbnail setImage:image];
        }
#else
        [cell.thumbnail sd_setImageWithURL:tweet.smallImgURL placeholderImage:[UIImage imageNamed:@"loading"]];
#endif
    } else {cell.thumbnail.hidden = YES;}
    
    cell.portrait.tag = row;
    cell.authorLabel.tag = row;
    cell.thumbnail.tag = row;
    cell.likeButton.tag = row;
    cell.likeListLabel.tag = row;
    cell.contentLabel.textColor = [UIColor contentTextColor];
    cell.authorLabel.textColor = [UIColor nameColor];
    
    [cell.portrait addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushUserDetailsView:)]];
    [cell.thumbnail addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadLargeImage:)]];
    [cell.likeButton addTarget:self action:@selector(togglePraise:) forControlEvents:UIControlEventTouchUpInside];
    [cell.likeListLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PushToLikeList:)]];
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor selectCellSColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OSCTweet *tweet = self.objects[indexPath.row];
    
    if (tweet.cellHeight) {return tweet.cellHeight;}
    
    self.label.font = [UIFont boldSystemFontOfSize:14];
    [self.label setText:tweet.author];
    CGFloat height = [self.label sizeThatFits:CGSizeMake(tableView.frame.size.width - 60, MAXFLOAT)].height;
    
    self.label.font = [UIFont boldSystemFontOfSize:15];
    [self.label setAttributedText:[Utils emojiStringFromRawString:tweet.body]];
    height += [self.label sizeThatFits:CGSizeMake(tableView.frame.size.width - 60, MAXFLOAT)].height;
    
    if (tweet.likeCount) {
        [self.label setAttributedText:tweet.likersString];
        self.label.font = [UIFont systemFontOfSize:12];
        height += [self.label sizeThatFits:CGSizeMake(tableView.frame.size.width - 60, MAXFLOAT)].height + 6;
    }
    
    if (tweet.hasAnImage) {
#if 0
        UIImage *image = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:tweet.smallImgURL.absoluteString];
        if (!image) {image = [UIImage imageNamed:@"loading"];}
        height += image.size.height + 5;
#else
        height += 86;
#endif
    }
    tweet.cellHeight = height + 39;
    
    return tweet.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    OSCTweet *tweet = self.objects[indexPath.row];
    TweetDetailsWithBottomBarViewController *tweetDetailsBVC = [[TweetDetailsWithBottomBarViewController alloc] initWithTweetID:tweet.tweetID];
    [self.navigationController pushViewController:tweetDetailsBVC animated:YES];
}


- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    return action == @selector(copyText:);
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    // required
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_didScroll) {_didScroll();}
}

- (void)setBlockForCommentCell:(TweetCell *)cell
{
    cell.canPerformAction = ^ BOOL (UITableViewCell *cell, SEL action) {
        if (action == @selector(copyText:)) {
            return YES;
        } else if (action == @selector(deleteObject:)) {
            NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
            
            OSCTweet *tweet = self.objects[indexPath.row];
            
            return tweet.authorID == [Config getOwnID];
        }
        
        return NO;
    };
    
    cell.deleteObject = ^ (UITableViewCell *cell) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        OSCTweet *tweet = self.objects[indexPath.row];
        
        MBProgressHUD *HUD = [Utils createHUD];
        HUD.labelText = @"正在删除动弹";
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager OSCManager];
        
        [manager POST:[NSString stringWithFormat:@"%@%@", OSCAPI_PREFIX, OSCAPI_TWEET_DELETE]
           parameters:@{
                        @"uid": @([Config getOwnID]),
                        @"tweetid": @(tweet.tweetID)
                        }
              success:^(AFHTTPRequestOperation *operation, ONOXMLDocument *responseObject) {
                  ONOXMLElement *resultXML = [responseObject.rootElement firstChildWithTag:@"result"];
                  int errorCode = [[[resultXML firstChildWithTag: @"errorCode"] numberValue] intValue];
                  NSString *errorMessage = [[resultXML firstChildWithTag:@"errorMessage"] stringValue];
                  
                  HUD.mode = MBProgressHUDModeCustomView;
                  
                  if (errorCode == 1) {
                      HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-done"]];
                      HUD.labelText = @"动弹删除成功";
                      
                      [self.objects removeObjectAtIndex:indexPath.row];
                      self.allCount--;
                      if (self.objects.count > 0) {
                          [self.tableView beginUpdates];
                          [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
                          [self.tableView endUpdates];
                      }
                      dispatch_async(dispatch_get_main_queue(), ^{
                          [self.tableView reloadData];
                      });
                  } else {
                      HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
                      HUD.labelText = [NSString stringWithFormat:@"错误：%@", errorMessage];
                  }
                  
                  [HUD hide:YES afterDelay:1];
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  HUD.mode = MBProgressHUDModeCustomView;
                  HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
                  HUD.detailsLabelText = error.userInfo[NSLocalizedDescriptionKey];
                  
                  [HUD hide:YES afterDelay:1];
              }];
    };
}



#pragma mark - 下载图片

- (void)downloadImageThenReload:(NSURL *)imageURL
{
    [SDWebImageDownloader.sharedDownloader downloadImageWithURL:imageURL
                                                        options:SDWebImageDownloaderUseNSURLCache
                                                       progress:nil
                                                      completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                                                          [[SDImageCache sharedImageCache] storeImage:image forKey:imageURL.absoluteString toDisk:NO];
                                                        
                                                          // 单独刷新某一行会有闪烁，全部reload反而较为顺畅
                                                          dispatch_async(dispatch_get_main_queue(), ^{
                                                              [self.tableView reloadData];
                                                          });
                                                      }];
}




#pragma mark - 跳转到用户详情页

- (void)pushUserDetailsView:(UITapGestureRecognizer *)recognizer
{
    OSCTweet *tweet = self.objects[recognizer.view.tag];
    UserDetailsViewController *userDetailsVC = [[UserDetailsViewController alloc] initWithUserID:tweet.authorID];
    [self.navigationController pushViewController:userDetailsVC animated:YES];
}

#pragma mark - 跳转到点赞列表

- (void)PushToLikeList:(UITapGestureRecognizer *)tap
{
    OSCTweet *tweet = self.objects[tap.view.tag];
    TweetsLikeListViewController *likeListCtl = [[TweetsLikeListViewController alloc] initWithtweetID:tweet.tweetID];
    [self.navigationController pushViewController:likeListCtl animated:YES];
}


#pragma mark - 编辑话题动弹

- (void)topicEditing
{
    TweetEditingVC *tweetEditingVC = [[TweetEditingVC alloc] initWithTopic:_topic];
    UINavigationController *tweetEditingNav = [[UINavigationController alloc] initWithRootViewController:tweetEditingVC];
    [self.navigationController presentViewController:tweetEditingNav animated:NO completion:nil];
    
}


#pragma mark - 加载大图

- (void)loadLargeImage:(UITapGestureRecognizer *)recognizer
{
    OSCTweet *tweet = self.objects[recognizer.view.tag];
    ImageViewerController *imageViewerVC = [[ImageViewerController alloc] initWithImageURL:tweet.bigImgURL];
    
    [self presentViewController:imageViewerVC animated:YES completion:nil];
}


#pragma mark - 处理消息通知

- (void)userRefreshHandler:(NSNotification *)notification
{
    _uid = [Config getOwnID];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self refresh];
    });
}

#pragma mark - 点赞功能
- (void)togglePraise:(UIButton *)button
{
    OSCTweet *tweet = self.objects[button.tag];
    [self toPraise:tweet];
}

- (void)toPraise:(OSCTweet *)tweet
{
    
    NSString *postUrl;
    if (tweet.isLike) {
        postUrl = [NSString stringWithFormat:@"%@%@", OSCAPI_PREFIX, OSCAPI_TWEET_UNLIKE];
    } else {
        postUrl = [NSString stringWithFormat:@"%@%@", OSCAPI_PREFIX, OSCAPI_TWEET_LIKE];
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager OSCManager];
    
    [manager POST:postUrl
       parameters:@{
                    @"uid": @([Config getOwnID]),
                    @"tweetid": @(tweet.tweetID),
                    @"ownerOfTweet": @( tweet.authorID)
                    }
          success:^(AFHTTPRequestOperation *operation, ONOXMLDocument *responseObject) {
              ONOXMLElement *resultXML = [responseObject.rootElement firstChildWithTag:@"result"];
              int errorCode = [[[resultXML firstChildWithTag: @"errorCode"] numberValue] intValue];
              NSString *errorMessage = [[resultXML firstChildWithTag:@"errorMessage"] stringValue];

              if (errorCode == 1) {
                  if (tweet.isLike) {
                      //取消点赞
                      for (OSCUser *user in tweet.likeList) {
                          if ([user.name isEqualToString:[Config getOwnUserName]]) {
                              [tweet.likeList removeObject:user];
                              break;
                          }
                      }
                      tweet.likeCount--;
                  } else {
                      //点赞
                      OSCUser *user = [OSCUser new];
                      user.userID = [Config getOwnID];
                      user.name = [Config getOwnUserName];
                      user.portraitURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", [Config getPortrait]]];
                      [tweet.likeList insertObject:user atIndex:0];
                      tweet.likeCount++;
                  }
                  tweet.isLike = !tweet.isLike;
                  tweet.likersString = nil;
                  tweet.cellHeight = 0;

                  dispatch_async(dispatch_get_main_queue(), ^{
                      [self.tableView reloadData];
                  });

              } else {
                  MBProgressHUD *HUD = [Utils createHUD];
                  HUD.mode = MBProgressHUDModeCustomView;
                  
                  HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
                  HUD.labelText = [NSString stringWithFormat:@"错误：%@", errorMessage];
                  
                  [HUD hide:YES afterDelay:1];
              }
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              MBProgressHUD *HUD = [Utils createHUD];
              HUD.mode = MBProgressHUDModeCustomView;
              
              HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
              HUD.detailsLabelText = error.userInfo[NSLocalizedDescriptionKey];
              
              [HUD hide:YES afterDelay:1];
          }];
}



@end
