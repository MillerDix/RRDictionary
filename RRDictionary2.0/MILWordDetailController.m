//
//  MILWordDetailController.m
//  RRDictionary2.0
//
//  Created by MillerD on 5/1/16.
//  Copyright © 2016 millerd. All rights reserved.
//

#import "MILWordDetailController.h"
#import <AFNetworking.h>
#import "MILNetworkManager.h"
#import "MILWordDetail.h"
#import "NSString+Base64Decode.h"

// GET
//http://91dict.com/rr/seek_word.php?keyword=con&type=json

@interface MILWordDetailController ()<UIWebViewDelegate>

@property (nonatomic, strong) MILWordDetail *detailModel;
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation MILWordDetailController


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    // 关闭自动调整scrollViewInsets
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = MILRandom;
    
    // 请求参数拼接
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"keyword"] = self.word;
    params[@"type"] = @"json";
    
    // 发送GET请求
    [[MILNetworkManager sharedManager] GET:@"/rr/seek_word.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@", responseObject);
        
        // 数据转模型
        MILWordDetail *model = [MILWordDetail initWithDict:responseObject];
        self.detailModel = model;
        
        // 回到主线程设置UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setupWebView];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
    
    // 设置webView
    //[self setupWebView];
    
}


// 设置webView
-(void)setupWebView
{
    // 创建webview
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, kNaviBar_maxY, kScreen_width, kScreen_height - 44 - 50)];
    
    webView.delegate = self;
    
    // 创建header
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, 100)];
    header.backgroundColor = [UIColor redColor];
    
    // 修改html显示的frame
    UIView *webBrowserView = webView.scrollView.subviews[0];
    CGRect htmlFrame = webBrowserView.frame;
    htmlFrame.origin.y = CGRectGetMaxY(header.frame);
    webBrowserView.frame = htmlFrame;
    
    
    // 创建footer
    //        UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(webBrowserView.frame), kScreen_width, 100)];
    //        footer.backgroundColor = [UIColor blueColor];
    //
    // 添加子控件
    [webView.scrollView addSubview:header];
    //[webView.scrollView addSubview:footer];
    [self.view addSubview:webView];
    
    if (self.detailModel.detail.length > 0 && self.detailModel.detail != nil)
        [webView loadHTMLString:self.detailModel.detail baseURL:nil];
}

#pragma mark - webView代理
// 加载完成后自适应内容大小
//-(void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    // 实际尺寸
//    CGSize actualSize = [webView sizeThatFits:CGSizeZero];
//    
//    // 修改
//    CGRect newFrame = webView.frame;
//    newFrame.size.height = actualSize.height;
//    webView.frame = newFrame;
//}


@end
