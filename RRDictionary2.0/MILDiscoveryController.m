//
//  MILDiscoveryController.m
//  RRDictionary2.0
//
//  Created by MillerD on 3/21/16.
//  Copyright © 2016 millerd. All rights reserved.
//

// 四级:http://www.91dict.com/discover/cet4gp.htm
// 六级:http://www.91dict.com/discover/cet6gp.htm
// 美剧新闻:http://reader.91dict.com/
// 常见词根:http://www.91dict.com/discover/cg.htm


#import "MILDiscoveryController.h"
#import <Masonry.h>
#import "MILDetailController.h"

@interface MILDiscoveryController ()

@property (nonatomic, strong) UIButton *lastButton;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *urlArray;

@end

@implementation MILDiscoveryController

#pragma mark - 懒加载
-(NSArray *)titleArray
{
    if (_titleArray == nil) {
        _titleArray = @[@"四级高频词汇", @"六级高频词汇", @"美剧新闻", @"常见词根"];
    }
    return _titleArray;
}

-(NSArray *)urlArray
{
    if (_urlArray == nil) {
        _urlArray = @[@"http://www.91dict.com/discover/cet4gp.htm",
                      @"http://www.91dict.com/discover/cet6gp.htm",
                      @"http://reader.91dict.com/",
                      @"http://www.91dict.com/discover/cg.htm"];
    }
    return _urlArray;
}

#pragma mark - 生命周期

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MILRandom;
    
    //循环创建button
    for (int i = 0; i < 4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.view addSubview:button];
        
        // tag值
        button.tag = i;
        
        // 设置颜色/圆角/标题
        button.backgroundColor = MILRandom;
        button.layer.cornerRadius = 10;
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];

        // 设置frame
        [self setupButtonFrame:button];
        
        // 监听事件
        [button addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

#pragma mark - 详细设置
// 触发事件
-(void)didClickButton:(UIButton *)button
{
    // 创建详细控制器
    MILDetailController *vc = [[MILDetailController alloc] init];
    vc.urlString = self.urlArray[button.tag];
    
    [self.navigationController pushViewController:vc animated:YES];
}

// 设置约束
-(void)setupButtonFrame:(UIButton *)button
{
    
    CGFloat margin = 10;
    // 第一个button
    if (button.tag == 0) {
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).with.offset(70);
            make.left.equalTo(self.view.mas_left).with.offset(20);
            make.right.equalTo(self.view.mas_right).with.offset(-20);
            make.height.mas_equalTo(@40);
        }];
        // 保存button、设置间隔
        self.lastButton = button;
    }
    else
    {
    // 其他所有的button
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lastButton.mas_bottom).with.offset(margin);
        make.left.equalTo(self.view.mas_left).with.offset(20);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
        make.height.mas_equalTo(@40);
    }];
    // 保存button、设置间隔
    self.lastButton = button;
    }
   
}


@end
