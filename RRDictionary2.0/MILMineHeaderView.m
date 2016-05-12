//
//  MILMineHeaderView.m
//  RRDictionary2.0
//
//  Created by MillerD on 5/7/16.
//  Copyright © 2016 millerd. All rights reserved.
//

#import "MILMineHeaderView.h"
#import <Masonry.h>

@interface MILMineHeaderView ()

// 头像
@property (nonatomic, strong) UIButton *headButton;
// 用户名
@property (nonatomic, strong) UILabel *userName;
// 竖向分隔
@property (nonatomic, strong) UIView *marginVer;
// 横向分隔
@property (nonatomic, strong) UIView *marginHori;
// 生词本
@property (nonatomic, strong) UIButton *unknownWord;
// 翻译
@property (nonatomic, strong) UIButton *translate;

@end

@implementation MILMineHeaderView

#pragma - mark - 初始化

-(instancetype)init
{
    if (self = [super init]) {
        
        // 背景
        self.backgroundColor = [UIColor lightGrayColor];
        
        // 横向分隔
        self.marginHori = [[UIView alloc] init];
        [self addSubview:self.marginHori];
        self.marginHori.backgroundColor = [UIColor whiteColor];
        

        [self.marginHori mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(20);
            make.right.equalTo(self.mas_right).offset(-20);
            make.bottom.equalTo(self.mas_bottom).offset(-64);
            make.height.equalTo(@2);
        }];
        
        // 纵向分隔
        self.marginVer = [[UIView alloc] init];
        [self addSubview:self.marginVer];
        self.marginVer.backgroundColor = [UIColor whiteColor];
        
        [self.marginVer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.width.equalTo(@2);
            make.top.equalTo(self.marginHori.mas_bottom).offset(10);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
        }];
        
        // 用户名
        self.userName = [[UILabel alloc] init];
        self.userName.font = [UIFont systemFontOfSize:14];
        self.userName.text = @"MillerD";
        self.userName.textColor = [UIColor blackColor];
        self.userName.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.userName];
        
        [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.bottom.equalTo(self.marginHori.mas_top).offset(-20);
        }];
        [self.userName sizeToFit];
        
        // 头像
        // 图片、frame等设置
        self.headButton = [[UIButton alloc] init];
        [self addSubview:self.headButton];
        // 取得本地路径
        NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
        // 取得本地头像图片
        UIImage *savedImage = [UIImage imageWithContentsOfFile:fullPath];
        // 设置已选头像或默认头像
        if (!savedImage) {
            [self.headButton setBackgroundImage:[UIImage imageNamed:@"mt"] forState:UIControlStateNormal];
        }else
        {
            [self.headButton setBackgroundImage:savedImage forState:UIControlStateNormal];
        }
        
        [self.headButton addTarget:self action:@selector(didClickHeadButton:) forControlEvents:UIControlEventTouchUpInside];
        
        // 圆角
        self.headButton.layer.cornerRadius = 25;
        self.headButton.clipsToBounds = YES;
        
        [self.headButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(self.userName.mas_top).offset(-20);
            make.width.equalTo(@50);
            make.height.equalTo(@50);
        }];
        
        // 生词本
        self.unknownWord = [[UIButton alloc] init];
        [self addSubview:self.unknownWord];
        [self.unknownWord setTitle:@"生词本" forState:UIControlStateNormal];
        [self.unknownWord addTarget:self action:@selector(didClickUnknownWordButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.unknownWord mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.marginVer.mas_centerY);
//            make.right.equalTo(self.marginVer.mas_left).offset(-30);
            make.centerX.equalTo(@(-kScreen_width/4));
        }];
        
        // 翻译
        self.translate = [[UIButton alloc] init];
        [self addSubview:self.translate];
        [self.translate setTitle:@"翻译" forState:UIControlStateNormal];
        [self.translate addTarget:self action:@selector(didClickTranslateButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.translate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.marginVer.mas_centerY);
            make.centerX.equalTo(@(kScreen_width/4));
        }];

    }
    
    return self;
}

// 点击头像
-(void)didClickHeadButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(didClickHeadButton:)]) {
        [self.delegate didClickHeadButton:button];
    }
    
}

// 点击生词本
-(void)didClickUnknownWordButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(didClickUnknownWordButton:)]) {
        [self.delegate didClickUnknownWordButton:button];
    }
}

// 点击翻译
-(void)didClickTranslateButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(didClickTranslateButton:)]) {
        [self.delegate didClickTranslateButton:button];
    }
}

@end
