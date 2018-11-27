//
//  HLViewController.m
//  HLCustomTransitions
//
//  Created by 2461414445@qq.com on 11/27/2018.
//  Copyright (c) 2018 2461414445@qq.com. All rights reserved.
//

#import "HLViewController.h"

@interface HLViewController ()

@property (nonatomic,strong) NSArray *dataSourceArray;

@end

@implementation HLViewController

static NSString * const cellId = @"cellid";

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"自定义转场动画";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    NSString *string = self.dataSourceArray[indexPath.row];
    cell.textLabel.text = string;
    
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if (indexPath.row == 0) {
        UIViewController *firstViewController = [storyboard instantiateViewControllerWithIdentifier:@"FirstViewController"];
        [self.navigationController pushViewController:firstViewController animated:YES];
    }
}

- (NSArray *)dataSourceArray
{
    if (!_dataSourceArray) {
        _dataSourceArray = @[
                             @"自定义model转场动画"
                             ];
    }
    return _dataSourceArray;
}

@end
