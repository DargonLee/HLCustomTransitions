//
//  CustomPresentationController.h
//  SwipeViewController
//
//  Created by Harlan on 2018/11/26.
//  Copyright © 2018 Harlan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, UIPresentationControllerDirection) {
    UIPresentationControllerDirectionFromLeft, //从屏幕左边弹出
    UIPresentationControllerDirectionFromRight, //从屏幕右边弹出
    UIPresentationControllerDirectionFromBottom, //从屏幕底部弹出
    UIPresentationControllerDirectionFromTop, //从屏幕顶部弹出
};

@interface HLCustomPresentationController : UIPresentationController <UIViewControllerTransitioningDelegate>

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController presentedDirection:(UIPresentationControllerDirection)direction;

@end

NS_ASSUME_NONNULL_END
