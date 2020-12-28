//
//  CustomPresentationController.m
//  SwipeViewController
//
//  Created by Harlan on 2018/11/26.
//  Copyright © 2018 Harlan. All rights reserved.
//

#import "HLCustomPresentationController.h"
#import "HLIndicatorView.h"

#define CORNER_RADIUS   16.f

@interface HLCustomPresentationController () <UIViewControllerAnimatedTransitioning>
{
    CGRect originFrame;
}
//半透明view
@property (nonatomic, strong) UIView *dimmingView;

@property (nonatomic,assign) UIPresentationControllerDirection direction;


@end

@implementation HLCustomPresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController presentedDirection:(UIPresentationControllerDirection)direction
{
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self) {
        presentedViewController.modalPresentationStyle = UIModalPresentationCustom;
        self.direction = direction;
    }
    return self;
    
}

- (void)presentationTransitionWillBegin
{
    UIView *dimmingView = [[UIView alloc] initWithFrame:self.containerView.bounds];
    dimmingView.backgroundColor = [UIColor blackColor];
    dimmingView.opaque = NO;
    dimmingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [dimmingView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dimmingViewTapped:)]];
    self.dimmingView = dimmingView;
    [self.containerView addSubview:dimmingView];
    
    self.presentedViewController.view.layer.cornerRadius = 10.0f;
    
    if (self.direction == UIPresentationControllerDirectionFromBottom) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)];
        [self.containerView addGestureRecognizer:pan];
        
        HLIndicatorView *indicatorView = [HLIndicatorView indicatorView];
        [self.presentedViewController.view addSubview:indicatorView];
    }
    
    // Get the transition coordinator for the presentation so we can
    // fade in the dimmingView alongside the presentation animation.
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    
    self.dimmingView.alpha = 0.f;
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.alpha = 0.5f;
    } completion:NULL];
}

- (void)presentationTransitionDidEnd:(BOOL)completed
{
    if (completed == NO) {
        self.dimmingView = nil;
    }
}

- (void)dismissalTransitionWillBegin
{
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 0.f;
    } completion:NULL];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed
{
    if (completed == NO) {
        self.dimmingView = nil;
    }
}

//调整子视图控制器的大小或位置。
- (void)preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container
{
    [super preferredContentSizeDidChangeForChildContentContainer:container];
    if (container == self.presentedViewController) {
        [self.containerView setNeedsLayout];
    }
}

//返回显示子视图的尺寸
- (CGSize)sizeForChildContentContainer:(id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize
{
    if (container == self.presentedViewController) {
        return ((UIViewController*)container).preferredContentSize;
    }else{
        return [super sizeForChildContentContainer:container withParentContainerSize:parentSize];
    }
}

//返回控制器view最终显示的大小
- (CGRect)frameOfPresentedViewInContainerView
{
    CGRect containerViewBounds = self.containerView.bounds;
    CGSize presentedViewContentSize = [self sizeForChildContentContainer:self.presentedViewController withParentContainerSize:containerViewBounds.size];
    CGRect presentedViewControllerFrame = containerViewBounds;
    presentedViewControllerFrame.size.height = presentedViewContentSize.height;
    presentedViewControllerFrame.origin.y = CGRectGetMaxY(containerViewBounds) - presentedViewContentSize.height;
    
    return presentedViewControllerFrame;
}

- (void)containerViewWillLayoutSubviews
{
    [super containerViewWillLayoutSubviews];
    self.dimmingView.frame = self.containerView.bounds;
}

- (void)dimmingViewTapped:(UITapGestureRecognizer *)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

//返回动画时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return [transitionContext isAnimated] ? 0.35 : 0;
}

//专场动画核心代码
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //容器view
    UIView *containerView = transitionContext.containerView;
    
    // For a Presentation:
    //      fromView = The presenting view.
    //      toView   = The presented view.
    // For a Dismissal:
    //      fromView = The presented view.
    //      toView   = The presenting view.
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    BOOL isPresenting = (fromViewController == self.presentingViewController);
    
    //获取from控制器的frame
    CGRect __unused fromViewInitialFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect fromViewFinalFrame = [transitionContext finalFrameForViewController:fromViewController];
    //获取to控制器的frame
    CGRect toViewInitialFrame = [transitionContext initialFrameForViewController:toViewController];
    CGRect toViewFinalFrame = [transitionContext finalFrameForViewController:toViewController];
    
    [containerView addSubview:toView];
    
    if (isPresenting) {
        toViewInitialFrame.origin = [self getToViewInitialFrameWith:containerView.bounds];
        toViewInitialFrame.size = toViewFinalFrame.size;
        toView.frame = toViewInitialFrame;
    }else {
        fromViewFinalFrame = [self getFromViewFinalFrameWith:fromView.frame];
    }
    
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:transitionDuration animations:^{
        if (isPresenting) {
            toView.frame = toViewFinalFrame;
        }else {
            fromView.frame = fromViewFinalFrame;
        }
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];
}


//设置专场代理为你当前动画代理
- (UIPresentationController*)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    NSAssert(self.presentedViewController == presented, @"You didn't initialize %@ with the correct presentedViewController.  Expected %@, got %@.",
             self, presented, self.presentedViewController);
    
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self;
}

- (CGPoint)getToViewInitialFrameWith:(CGRect)frame
{
    CGRect containerViewBounds = self.containerView.bounds;
    CGSize presentedViewContentSize = [self sizeForChildContentContainer:self.presentedViewController withParentContainerSize:containerViewBounds.size];
    CGFloat y = CGRectGetMaxY(containerViewBounds) - presentedViewContentSize.height;
    
    CGPoint toViewPoint;
    if (self.direction == UIPresentationControllerDirectionFromRight) {
        toViewPoint = CGPointMake(CGRectGetWidth(frame), y);
    }else if (self.direction == UIPresentationControllerDirectionFromBottom) {
        toViewPoint = CGPointMake(CGRectGetMinX(frame), CGRectGetMaxY(frame)+CGRectGetHeight(frame));
    }else if (self.direction == UIPresentationControllerDirectionFromTop) {
        toViewPoint = CGPointMake(0, -CGRectGetMaxY(frame));
    }else {
        toViewPoint = CGPointMake(-CGRectGetMaxX(frame), y);
    }
    return toViewPoint;
}

- (CGRect)getFromViewFinalFrameWith:(CGRect)frame
{
    CGRect fromViewOffSet;
    if (self.direction == UIPresentationControllerDirectionFromRight) {
        fromViewOffSet = CGRectOffset(frame,CGRectGetWidth(frame) ,0);
    }else if (self.direction == UIPresentationControllerDirectionFromBottom) {
        fromViewOffSet = CGRectOffset(frame,0 ,CGRectGetHeight(frame));
    }else if (self.direction == UIPresentationControllerDirectionFromTop) {
        fromViewOffSet = CGRectOffset(frame,0 ,-CGRectGetHeight(frame));
    }else {
        fromViewOffSet = CGRectOffset(frame,-CGRectGetWidth(frame), 0);
    }
    
    return fromViewOffSet;
}

- (void)panGestureRecognizer:(UIPanGestureRecognizer *)pan
{
    NSLog(@"panGestureRecognizer");
    CGPoint point = [pan translationInView:pan.view];
    CGRect frame = self.presentedView.frame;
    NSLog(@"point - %f frame - %@", point.y, NSStringFromCGRect(frame));
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: {
            originFrame = self.presentedView.frame;
        }
            break;
        case UIGestureRecognizerStateChanged: {
            if (point.y > originFrame.origin.y) {
                frame.origin.y = point.y;
                self.presentedView.frame = frame;
            }
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed: {
            if (point.y > 230) {
                [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
            }else {
                [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:5.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    self.presentedView.frame = self->originFrame;
                } completion:nil];
            }
        }
            break;
        default: break;
    }
}

@end
