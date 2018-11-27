//
//  HLFirstViewController.m
//  HLCustomTransitions_Example
//
//  Created by Harlan on 2018/11/27.
//  Copyright © 2018 2461414445@qq.com. All rights reserved.
//

#import "HLFirstViewController.h"
#import "MineViewController.h"
#import "HLCustomPresentationController.h"


@interface HLFirstViewController ()

@end

@implementation HLFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)presentLeftVc:(id)sender
{
    MineViewController *mineVC = [[MineViewController alloc]init];
    HLCustomPresentationController *presentationController = [[HLCustomPresentationController alloc]initWithPresentedViewController:mineVC presentingViewController:self presentedDirection:UIPresentationControllerDirectionFromLeft];
    mineVC.transitioningDelegate = presentationController;
    [self presentViewController:mineVC animated:YES completion:NULL];
}
- (IBAction)presentRightVc:(id)sender
{
    MineViewController *mineVC = [[MineViewController alloc]init];
    HLCustomPresentationController *presentationController = [[HLCustomPresentationController alloc]initWithPresentedViewController:mineVC presentingViewController:self presentedDirection:UIPresentationControllerDirectionFromRight];
    mineVC.transitioningDelegate = presentationController;
    [self presentViewController:mineVC animated:YES completion:NULL];
}
- (IBAction)presentTopVc:(id)sender
{
    MineViewController *mineVC = [[MineViewController alloc]init];
    HLCustomPresentationController *presentationController = [[HLCustomPresentationController alloc]initWithPresentedViewController:mineVC presentingViewController:self presentedDirection:UIPresentationControllerDirectionFromTop];
    mineVC.transitioningDelegate = presentationController;
    [self presentViewController:mineVC animated:YES completion:NULL];
}
- (IBAction)presentBottomVc:(id)sender
{
    MineViewController *mineVC = [[MineViewController alloc]init];
    HLCustomPresentationController *presentationController = [[HLCustomPresentationController alloc]initWithPresentedViewController:mineVC presentingViewController:self presentedDirection:UIPresentationControllerDirectionFromBottom];
    mineVC.transitioningDelegate = presentationController;
    [self presentViewController:mineVC animated:YES completion:NULL];
}


@end
