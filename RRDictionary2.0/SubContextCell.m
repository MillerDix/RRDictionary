//
//  SubContextCell.m
//  RRDictionary2.0
//
//  Created by MillerD on 5/6/16.
//  Copyright © 2016 millerd. All rights reserved.
//

#import "SubContextCell.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>

@interface SubContextCell ()

@property (nonatomic, strong) UIImageView *subImage;
@property (nonatomic, strong) UILabel *subcn;
@property (nonatomic, strong) UILabel  *suben;
@property (nonatomic, strong) UIImageView *marginImage;

@property (nonatomic, strong) UIButton *coverButton;

// 标记coverButton的隐藏状态
@property (nonatomic, assign) BOOL isHiddenButton;

@end

@implementation SubContextCell

#pragma mark - 懒加载控件

// 初始化
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
    }
    return self;
}


// 模型setter
-(void)setModel:(Mysub *)model
{
    _model = model;
    
    // 图片显示
    NSURL *url = [NSURL URLWithString:self.model.subimg];
    [self.subImage sd_setImageWithURL:url];
    
    // 中文字幕
    self.subcn.text = self.model.subcn;
    
    // 英文字母
    self.suben.text = self.model.suben;
    
    //遮盖button
    if (self.model.sid == self.mysid) {
        self.coverButton = [[UIButton alloc] init];
        [self addSubview:self.coverButton];
        
        [self.coverButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(20);
            make.right.equalTo(self.mas_right).offset(-20);
            make.bottom.equalTo(self.suben.mas_top).offset(-5);
        }];
        
        [self.coverButton setBackgroundColor:[UIColor lightGrayColor]];
        [self.coverButton setTitle:@"点击显示原文翻译" forState:UIControlStateNormal];
        self.coverButton.titleLabel.font = [UIFont systemFontOfSize:15];
        
        // 添加事件
        [self.coverButton addTarget:self action:@selector(didClickCoverButton) forControlEvents:UIControlEventTouchUpInside];
        self.coverButton.hidden = self.isHiddenButton;
        
        return;
        
    }
    
    [self.coverButton removeFromSuperview];
    
}

-(void)didClickCoverButton
{
    self.isHiddenButton = YES;
    self.coverButton.hidden = YES;
}

// 设置子控件
-(void)setupSubviews
{
    // 底部分隔图片
    self.marginImage = [[UIImageView alloc] init];
    [self addSubview:self.marginImage];
    
    [self.marginImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(@10);
    }];
    
    self.marginImage.backgroundColor = [UIColor redColor];
    
    // 背景图片
    self.subImage = [[UIImageView alloc] init];
    [self addSubview:self.subImage];
    
    [self.subImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.marginImage.mas_top);
    }];
    
    // 英文字幕
    self.suben = [[UILabel alloc] init];
    [self addSubview:self.suben];
    
    [self.suben mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.bottom.equalTo(self.marginImage.mas_top).offset(-10);
    }];
    
    self.suben.textAlignment = NSTextAlignmentCenter;
    self.suben.font = [UIFont systemFontOfSize:13];
    self.suben.textColor = [UIColor whiteColor];
    [self.suben setNumberOfLines:0];
    [self.suben sizeToFit];
    
    // 中文字幕
    self.subcn = [[UILabel alloc] init];
    [self addSubview:self.subcn];
    
    [self.subcn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.bottom.equalTo(self.suben.mas_top).offset(-5);
    }];
    
    self.subcn.textAlignment = NSTextAlignmentCenter;
    self.subcn.font = [UIFont systemFontOfSize:13];
    self.subcn.textColor = [UIColor whiteColor];
    [self.subcn setNumberOfLines:0];
    [self.subcn sizeToFit];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


@end
