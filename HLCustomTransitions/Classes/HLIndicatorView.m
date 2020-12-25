//
//  HLIndicatorView.m
//  HLCustomTransitions
//
//  Created by Harlans on 2020/12/25.
//

#import "HLIndicatorView.h"

@implementation HLIndicatorView

+ (HLIndicatorView *)indicatorView
{
    HLIndicatorView *view = [[HLIndicatorView alloc] init];
    [view setNeedsLayout];
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.792 green:0.788 blue:0.812 alpha:1.00];
        self.layer.cornerRadius = 1.5;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat w = 36;
    CGFloat x = self.superview.center.x - w * 0.5;
    CGFloat y = 8;
    CGFloat h = 4;
    self.frame = CGRectMake(x, y, w, h);
}

@end
