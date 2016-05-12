//
//  TranslateTaskCell.m
//  RRDictionary2.0
//
//  Created by MillerD on 5/3/16.
//  Copyright © 2016 millerd. All rights reserved.
//

#import "TranslateTaskCell.h"
#import <UIImageView+WebCache.h>
#import "TranslateTask.h"

@interface TranslateTaskCell ()

// 图片
@property (weak, nonatomic) IBOutlet UIImageView *imgEpisode;
// 剧集
@property (weak, nonatomic) IBOutlet UILabel *lblEpisode;
// 字幕
@property (weak, nonatomic) IBOutlet UILabel *lblSubtitle;
// 加入人数
@property (weak, nonatomic) IBOutlet UILabel *lblJoinnum;

@end

@implementation TranslateTaskCell

// 模型setter方法
-(void)setTask:(TranslateTask *)task
{
    _task = task;
    
    // 设置图片
    [self.imgEpisode sd_setImageWithURL:[NSURL URLWithString:task.subimg]];
    // 设置剧集
    self.lblEpisode.text = task.vname;
    // 设置字幕
    self.lblSubtitle.text = task.suben;
    // 设置加入人数
    self.lblJoinnum.text = [NSString stringWithFormat:@"%d", task.joinnum];
    
}

// 设置适应内容
- (void)awakeFromNib {
    [self.lblEpisode sizeToFit];
    [self.lblSubtitle sizeToFit];
    [self.lblJoinnum sizeToFit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
