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

@property (nonatomic, weak) UIImageView *expandingImageView;
@property (nonatomic, assign) NSTimeInterval transitionDuration;
@property (nonatomic, assign) BOOL isPresenting;

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
- (void)setExpandingImageView:(UIImageView *)expandingImageView
{
    _expandingImageView = expandingImageView;
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


