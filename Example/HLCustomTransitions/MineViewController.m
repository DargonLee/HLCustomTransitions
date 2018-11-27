//
//  MineViewController.m
//  SwipeViewController
//
//  Created by Harlan on 2018/11/26.
//  Copyright © 2018 Harlan. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewWillLayoutSubviews
{
    //设置控制器显示的尺寸
    self.view.frame = CGRectMake(0, 100, self.view.bounds.size.width, 500);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((self.view.bounds.size.width-200) * 0.5, (self.view.bounds.size.height-200) * 0.5, 200, 200);
    button.backgroundColor = [UIColor greenColor];
    [self.view addSubview:button];
}

@end
