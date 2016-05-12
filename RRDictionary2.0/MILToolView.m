//
//  MILToolView.m
//  RRDictionary2.0
//
//  Created by MillerD on 3/21/16.
//  Copyright © 2016 millerd. All rights reserved.
//

#import "MILToolView.h"
#import "UIButton+Custom.h"
#import <Masonry.h>
#import "TranslateTaskController.h"
#import "UnknownWordController.h"

@interface MILToolView ()

// 生词
@property (nonatomic, strong) UIButton *unknownWord;
// 翻译
@property (nonatomic, strong) UIButton *translate;
// 剧本
@property (nonatomic, strong) UIButton *script;
// 录音
@property (nonatomic, strong) UIButton *record;

@end

@implementation MILToolView
-(UIButton *)unknownWord
{
    if (_unknownWord == nil) {
        _unknownWord = [[UIButton alloc] initWithTitle:@"生词" normalColor:[UIColor whiteColor] highlightColor:[UIColor lightGrayColor]];
        _unknownWord.tag = 0;
        [self addSubview:_unknownWord];
        
        
        // 1.生词本
        [_unknownWord mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
            make.left.equalTo(self.mas_left);
        }];
    }
    return _unknownWord;
}
-(UIButton *)translate
{
    if (_translate == nil) {
        _translate = [[UIButton alloc] initWithTitle:@"翻译" normalColor:[UIColor whiteColor] highlightColor:[UIColor lightGrayColor]];
        _translate.tag = 1;
        [self addSubview:_translate];
        
        // 2.翻译
        [_translate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
            make.left.equalTo(self.unknownWord.mas_right);
            make.width.equalTo(self.unknownWord.mas_width);
        }];
    }
    return _translate;
}
-(UIButton *)script
{
    if (_script == nil) {
        _script = [[UIButton alloc] initWithTitle:@"生词" normalColor:[UIColor whiteColor] highlightColor:[UIColor lightGrayColor]];
        _script.tag = 2;
        [self addSubview:_script];
        
        // 3.剧本
        [_script mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
            make.left.equalTo(self.translate.mas_right);
            make.width.equalTo(self.translate.mas_width);
        }];
    }
    return _script;
}
-(UIButton *)record
{
    if (_record == nil) {
        _record = [[UIButton alloc] initWithTitle:@"生词" normalColor:[UIColor whiteColor] highlightColor:[UIColor lightGrayColor]];
        _record.tag = 3;
        [self addSubview:_record];
        
        // 4.录音
        [_record mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
            make.left.equalTo(self.script.mas_right);
            make.right.equalTo(self.mas_right);
            make.width.equalTo(self.script.mas_width);
        }];
    }
    return _record;
}

#pragma mark - 绘制子控件时创建button

-(void)layoutSubviews
{
    
    // 创建并添加到父视图
    //[self createButtons];
    
    // 设置约束
    //[self setupContraints];
    
    // 监听方法
    [self listenToButtons];
}

// 监听点击事件
-(void)listenToButtons
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self.unknownWord addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.translate addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.script addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.record addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
    });
}


// 创建button
-(void)createButtons
{
//    self.unknownWord = [[UIButton alloc] initWithTitle:@"生词" normalColor:[UIColor whiteColor] highlightColor:[UIColor   lightGrayColor]];
//    self.translate= [[UIButton alloc] initWithTitle:@"翻译" normalColor:[UIColor whiteColor] highlightColor:[UIColor   lightGrayColor]];
//    self.script = [[UIButton alloc] initWithTitle:@"剧本" normalColor:[UIColor whiteColor] highlightColor:[UIColor   lightGrayColor]];
//    self.record = [[UIButton alloc] initWithTitle:@"录音" normalColor:[UIColor whiteColor] highlightColor:[UIColor   lightGrayColor]];
//    
//    
    // 添加到父视图
//    [self addSubview:self.unknownWord];
//    [self addSubview:self.translate];
//    [self addSubview:self.script];
//    [self addSubview:self.record];
}

// 设置约束
-(void)setupContraints
{
    
//    // 1.生词本
//    [self.unknownWord mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top);
//        make.bottom.equalTo(self.mas_bottom);
//        make.left.equalTo(self.mas_left);
//    }];
//    
//    // 2.翻译
//    [self.translate mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top);
//        make.bottom.equalTo(self.mas_bottom);
//        make.left.equalTo(self.unknownWord.mas_right);
//        make.width.equalTo(self.unknownWord.mas_width);
//    }];
//    
//    // 3.剧本
//    [self.script mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top);
//        make.bottom.equalTo(self.mas_bottom);
//        make.left.equalTo(self.translate.mas_right);
//        make.width.equalTo(self.translate.mas_width);
//    }];
//    
//    // 4.录音
//    [self.record mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top);
//        make.bottom.equalTo(self.mas_bottom);
//        make.left.equalTo(self.script.mas_right);
//        make.right.equalTo(self.mas_right);
//        make.width.equalTo(self.script.mas_width);
//    }];
}


// 点击事件处理
-(void)didClickButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(pushToController:byButton:)]) {
        
        
        switch (button.tag) {
            case 0:
            {
                UnknownWordController *target = [[UnknownWordController alloc] init];
                target.title = button.titleLabel.text;
                [self.delegate pushToController:target byButton:button];
            }
                break;
            case 1:
            {
                // 创建跳转控制器
                TranslateTaskController *target = [[TranslateTaskController alloc] init];
                target.title = button.titleLabel.text;
                [self.delegate pushToController:target byButton:button];
            }
                break;
                
            default:
                break;
        }
    }
}

@end
