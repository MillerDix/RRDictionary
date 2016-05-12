//
//  MILDetailController.m
//  RRDictionary2.0
//
//  Created by MillerD on 5/2/16.
//  Copyright © 2016 millerd. All rights reserved.
//

#import "MILDetailController.h"

@interface MILDetailController ()<UIWebViewDelegate>

@end

@implementation MILDetailController

// 生命周期
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    
    // 设置背景颜色/取消自动调整边距
    self.view.backgroundColor = MILRandom;
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 创建webView
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, kNaviBar_maxY, kScreen_width, kScreen_height)];
    [self.view addSubview:webView];
    
    webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 110, 0);
    NSURL *url = [NSURL URLWithString:self.urlString];
    
    // 加载网页
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
}

#pragma mark - webView代理
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

@end
