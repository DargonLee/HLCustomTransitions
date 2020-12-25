//
//  HLIndicatorView.h
//  HLCustomTransitions
//
//  Created by Harlans on 2020/12/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HLIndicatorView : UIView

/// 快速创建一个View
/// 当前会在superView的中间 即centerX = superView.centerX  y = 8
+ (HLIndicatorView *)indicatorView;

- (instancetype)initWithFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
