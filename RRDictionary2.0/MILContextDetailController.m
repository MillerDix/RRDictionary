//
//  MILContextDetailController.m
//  RRDictionary2.0
//
//  Created by MillerD on 5/7/16.
//  Copyright © 2016 millerd. All rights reserved.
//

#import "MILContextDetailController.h"

@interface MILContextDetailController ()

@end

@implementation MILContextDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 取消导航栏和tabbar
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    
    // 返回按钮
    UIButton *popButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [popButton setBackgroundColor:[UIColor redColor]];
    [popButton addTarget:self action:@selector(didClickBackButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:popButton];
    
    [self.navigationItem hidesBackButton];
}

-(void)didClickBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end