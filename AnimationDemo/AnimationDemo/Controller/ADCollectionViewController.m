//
//  ADCollectionViewController.m
//  AnimationDemo
//
//  Created by 赖显波 on 15/12/25.
//  Copyright © 2015年 Leckie. All rights reserved.
//

#import "ADCollectionViewController.h"
#import "ADDetailViewController.h"
#import "ADMagicMoveTransition.h"
#import "ADMainViewController.h"
#import "ADNavigationBackTransition.h"

#define kItemWidth ([UIScreen mainScreen].bounds.size.width / 2 - 15)
#define kItemHeight (kItemWidth / 2 * 3)

static NSString *const kCellIdentifier = @"CollectionViewCellIdentifier";

@interface ADCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate>

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentDrivenTransition;

@end

@implementation ADCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self viewsInit];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.delegate = nil;
}

- (void)viewsInit {
    UICollectionViewLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    
    UIScreenEdgePanGestureRecognizer *gesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    gesture.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:gesture];
}

- (void)handleGesture:(UIPanGestureRecognizer *)recognizer {
    UIView *view = self.view;
    CGPoint offset = [recognizer translationInView:view];
    CGFloat progress = offset.x / (view.bounds.size.width * 1.0);
    progress = MIN(1.0, MAX(progress, 0.0));
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case UIGestureRecognizerStateChanged:
            [self.percentDrivenTransition updateInteractiveTransition:progress];
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            if (progress < 0.3) {
                [self.percentDrivenTransition cancelInteractiveTransition];
            } else {
                [self.percentDrivenTransition finishInteractiveTransition];
            }
            break;
        default:
            break;
    }
}


#pragma mark - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kItemWidth, kItemHeight)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", @(indexPath.row % 5)]];
    [cell.contentView addSubview:imageView];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kItemWidth, kItemHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ADDetailViewController *viewController = [[ADDetailViewController alloc] init];
    viewController.index = indexPath.row;
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if ([toVC isKindOfClass:[ADDetailViewController class]]) {
        ADMagicMoveTransition *transition = [[ADMagicMoveTransition alloc] init];
        return transition;
    }
    if ([toVC isKindOfClass:[ADMainViewController class]]) {
        ADNavigationBackTransition *transition = [[ADNavigationBackTransition alloc] init];
        return transition;
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    if ([animationController isKindOfClass:[ADNavigationBackTransition class]]) {
        return self.percentDrivenTransition;
    }
    return nil;
}

@end
