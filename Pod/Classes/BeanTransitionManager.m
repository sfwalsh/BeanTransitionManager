//
//  BeanTransitionManager.m
//  Pods
//
//  Created by Stephen Walsh on 23/04/2015.
//
//

#import "BeanTransitionManager.h"

static float kDefaultTransitionLength   = 0.5;

@interface BeanTransitionManager()

@property (nonatomic, strong) UIImageView *expandingImageView;
@property (nonatomic, assign) NSTimeInterval transitionDuration;
@property (nonatomic, assign) BOOL isPresenting;
@property (nonatomic, strong) UIImageView *transitionImageView;

@end


@implementation BeanTransitionManager


#pragma mark - setup
- (instancetype)initWithExpandingImageView:(UIImageView *)expandingImageView
                     andTransitionDuration:(NSTimeInterval)duration
{
    
    self = [super init];
    if (self) {
        self.expandingImageView = expandingImageView;
        self.transitionDuration = duration;
    }
    
    return self;
}

- (instancetype)init
{
    return [self initWithExpandingImageView:[UIImageView new] andTransitionDuration:kDefaultTransitionLength];
}

- (instancetype)initWithExpandingImageView:(UIImageView *)expandingImageView
{
    return [self initWithExpandingImageView:expandingImageView andTransitionDuration:kDefaultTransitionLength];
}

- (instancetype)initWithTransitionDuration:(NSTimeInterval)duration
{
    return [self initWithExpandingImageView:[UIImageView new] andTransitionDuration:duration];
}


#pragma mark - actions
- (void)updateExpandingImageView:(UIImageView *)expandingImageView
{
    self.expandingImageView = expandingImageView;
}

- (void)updateExpandingImageViewWithCell:(id<BeanTransitionManagerCellExpanding>)cell
                             atIndexPath:(NSIndexPath *)indexPath
                        inCollectionView:(UICollectionView *)collectionView
                                  onView:(UIView *)view
                             andDuration:(NSTimeInterval)duration
{
    self.transitionImageView = [[UIImageView alloc] initWithImage:cell.cellImageView.image];
    self.transitionImageView.clipsToBounds = YES;
    CGPoint origin_point  =  [collectionView cellForItemAtIndexPath:indexPath].frame.origin;
    CGSize  size_of_view  =  cell.cellImageView.frame.size;
    CGRect  view_rect     =  CGRectMake(origin_point.x, origin_point.y, size_of_view.width, size_of_view.height);
    
    self.transitionImageView.frame = [collectionView convertRect:view_rect toView:view];
    [view addSubview:self.transitionImageView];
    self.expandingImageView = self.transitionImageView;
}

#pragma mark - setters
- (void)setDelegate:(id<BeanTransitionManagerDelegate>)delegate
{
    _delegate = delegate;
    _delegate.delegateContentImageView.image = _expandingImageView.image;
}


#pragma mark UIViewControllerAnimatedTransitioning
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.isPresenting = NO;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.isPresenting = YES;
    return self;
}


#pragma mark UIViewControllerTransitioningDelegate
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *container = [transitionContext containerView];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    
    if(self.isPresenting){
        [container addSubview:fromViewController.view];
        [container addSubview:toViewController.view];
        [self createSnapshotViewWithViewController:fromViewController toViewController:toViewController transitionContext:transitionContext andBack:YES];
        self.delegate = (id<BeanTransitionManagerDelegate>) toViewController;
        [self animateApparitionWithContainerView:container toView:toViewController.view fromView:fromViewController.view andTransitionContext:transitionContext];
        if (self.transitionImageView) {
            [self.transitionImageView removeFromSuperview];
        }
    }
    else{
        [self createSnapshotViewWithViewController:fromViewController toViewController:toViewController transitionContext:transitionContext andBack:NO];
        [transitionContext completeTransition:YES];
    }
}

- (void)animateApparitionWithContainerView:(UIView*)containerView
                                    toView:(UIView*)toView
                                  fromView:(UIView*)fromView
                      andTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    [transitionContext completeTransition:YES];
    [self.delegate.delegateContentImageView destroyAllConstraintsAndAlignToView:self.expandingImageView];
    [self.delegate.delegateContentImageView expandToFullscreenWithDuration:self.transitionDuration];
}

- (void)createSnapshotViewWithViewController:(UIViewController*)fromViewController
                            toViewController:(UIViewController*)toViewController
                           transitionContext:(id<UIViewControllerContextTransitioning>)transitionContext
                                     andBack:(BOOL)back
{
    
    UIView *snapshotView = [fromViewController.view snapshotViewAfterScreenUpdates:NO];
    
    [toViewController.view addSubview:snapshotView];
    
    if(back){
        [toViewController.view sendSubviewToBack:snapshotView];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        snapshotView.alpha = 0;
    } completion:^(BOOL finished) {
        [snapshotView removeFromSuperview];
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.transitionDuration;
}

@end


