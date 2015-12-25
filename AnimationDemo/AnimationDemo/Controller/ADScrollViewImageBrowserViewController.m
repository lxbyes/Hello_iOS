//
//  ADScrollViewImageBrowserViewController.m
//  AnimationDemo
//
//  Created by 赖显波 on 15/12/24.
//  Copyright © 2015年 Leckie. All rights reserved.
//

#import "ADScrollViewImageBrowserViewController.h"

#define kContentWidth [UIScreen mainScreen].bounds.size.width
#define kContentHeight ([UIScreen mainScreen].bounds.size.height - 64)
#define kImageCount 5

@interface ADScrollViewImageBrowserViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *centerImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, assign) NSUInteger currentIndex;

@end

@implementation ADScrollViewImageBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self viewsInit];
}

- (void)viewsInit {
    // 不自动调节ScrollView 的 contentInsets
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kContentWidth, kContentHeight)];
    _scrollView.backgroundColor = [UIColor blackColor];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(kContentWidth * 3, kContentHeight);
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    
    _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kContentWidth, kContentHeight)];
    _centerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kContentWidth, 0, kContentWidth, kContentHeight)];
    _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2 * kContentWidth, 0, kContentWidth, kContentHeight)];
    
    _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    _centerImageView.contentMode = UIViewContentModeScaleAspectFit;
    _rightImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [_scrollView addSubview:_leftImageView];
    [_scrollView addSubview:_centerImageView];
    [_scrollView addSubview:_rightImageView];
    
    _pageControl = [[UIPageControl alloc] init];
    CGSize size = [_pageControl sizeForNumberOfPages:5];
    _pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
    _pageControl.center = CGPointMake(kContentWidth * 0.5, kContentHeight); //
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor yellowColor];
    _pageControl.numberOfPages = 5;
    [self.view addSubview:_pageControl];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 84, kContentWidth, 30)];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.textColor = [UIColor colorWithRed:0 green:150.0 / 255.0 blue:1 alpha:1];
    
    [self.view addSubview:_label];
    
    // init data
    _leftImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", @(kImageCount - 1)]];
    _centerImageView.image = [UIImage imageNamed:@"0.jpg"];
    _rightImageView.image = [UIImage imageNamed:@"1.jpg"];
    [_scrollView setContentOffset:CGPointMake(kContentWidth, 0) animated:NO];
    _currentIndex = 0;
    _pageControl.currentPage = _currentIndex;
    _label.text = [NSString stringWithFormat:@"%@", @(_currentIndex)];
}

#pragma mark - ScrollView delegate
// scroll stop
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self reloadImage];
    [_scrollView setContentOffset:CGPointMake(kContentWidth, 0) animated:NO];
    _pageControl.currentPage = _currentIndex;
    _label.text = [NSString stringWithFormat:@"%@", @(_currentIndex)];
}

- (void)reloadImage {
    CGPoint offset = _scrollView.contentOffset;
    if (offset.x > kContentWidth) {
        // next
        _currentIndex = (_currentIndex + 1) % kImageCount;
        _leftImageView.image = _centerImageView.image;
        _centerImageView.image = _rightImageView.image;
        _rightImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", @((_currentIndex + 1) % kImageCount)]];
    } else {
        _currentIndex = (_currentIndex + kImageCount - 1) % kImageCount;
        _rightImageView.image = _centerImageView.image;
        _centerImageView.image = _leftImageView.image;
        _leftImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", @((_currentIndex - 1 + kImageCount) % kImageCount)]];
    }
}
@end
