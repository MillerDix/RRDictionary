//
//  MILHomeCell.m
//  RRDictionary2.0
//
//  Created by MillerD on 3/21/16.
//  Copyright © 2016 millerd. All rights reserved.
//

#import "MILHomeCell.h"
#import "MILWords.h"
#import <UIImageView+WebCache.h>
#import <SDImageCache.h>
#import "NSString+HTML.h"
#import <AVFoundation/AVFoundation.h>
#import "MILArchiveTool.h"

@interface MILHomeCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblFilmname;
@property (weak, nonatomic) IBOutlet UILabel *lblSubcn;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *keyword;
@property (weak, nonatomic) IBOutlet UIButton *audioButton;
@property (weak, nonatomic) IBOutlet UILabel *lblExplain;
@property (weak, nonatomic) IBOutlet UILabel *lblYinBiao;
@property (weak, nonatomic) IBOutlet UILabel *lblSuben;

// 音频播放器
@property (nonatomic, strong) AVPlayer *player;
//
@property (nonatomic, strong) AVPlayerItem *item;
// 音频播放状态维护
@property (nonatomic, assign) BOOL isPlaying;
// 归档数组
@property (nonatomic, strong) NSMutableArray *savedArray;
// 收藏按钮
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end
//http://pic-91dict.oss-cn-qingdao.aliyuncs.com/mp3/0250913e4cc08c141643904c31778253/0250913e4cc08c141643904c31778253-55.mp3
@implementation MILHomeCell

-(NSMutableArray *)savedArray
{
    if (_savedArray == nil) {
        _savedArray = [NSMutableArray array];
    }
    return _savedArray;
}

// 生词保存
- (IBAction)didClickAddToUnknown:(UIButton *)sender {

    // 判断数据是否生成
    if (self.word == nil) {

    }else if (self.saveButton.selected == YES){
        NSLog(@"已经收藏");

    }
    else{
        [MILArchiveTool collect:self.word];
        self.saveButton.selected = YES;
    }
}
// 点击播放音频
- (IBAction)didClickAudioButton:(UIButton *)sender {
    
    // 判断是否正在播放
    if (self.isPlaying) {
        return;
    }
    
    // 将播放状态修改为正在播放
    self.isPlaying = 1;
    
    //监听播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishPlay) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    // 取得音频地址
    NSString *urlString = [self.word.subaudio stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 创建播放器并播放
    // 创建播放器需要强引用？否则播放之前就被销毁?
    self.item = [[AVPlayerItem alloc] initWithURL:url];
    self.player = [[AVPlayer alloc] initWithPlayerItem:self.item];
    [self.player play];
    
}

-(void)dealloc
{
    
}

// 播放完成
-(void)didFinishPlay
{
    self.isPlaying = 0;
    
    // 移除通知监听
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

// 模型setter方法
-(void)setWord:(MILWords *)word
{
    //_yinbiao	__NSCFString *	@"\n ['h&#230;nd&#643;eik] "	0x00007fb78b82f510
    
    _word = word;
    self.lblFilmname.text = [word.filmname stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.lblSubcn.text = [word.subcn stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.keyword.text = [word.keyword stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.lblExplain.text = [word.explain stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    // 音标的特殊转码处理
    NSString *tempString = [word.yinbiao stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    self.lblYinBiao.text = [tempString stringByConvertingHTMLToPlainText];
    self.lblSuben.text = [word.suben stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    //去掉两端的\n和空格
    NSURL *url = [NSURL URLWithString:[word.subimg stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    
    [self.imageView sd_setImageWithURL:url];
    //[[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    
    //NSLog(@"-------------%@",self.lblSuben.text);
    
    // 设置收藏状态
    self.saveButton.selected = [MILArchiveTool isCollected:self.word];
    
}
//-(instancetype)init
//{
//    if (self = [super init]) {
//        NSLog(@"创建");
//    }
//    return self;
//}

// 子控件适应内容
- (void)awakeFromNib {
    [self.lblExplain sizeToFit];
    [self.lblFilmname sizeToFit];
    [self.lblSuben sizeToFit];
    [self.lblYinBiao sizeToFit];
    [self.lblSubcn sizeToFit];
    [self.keyword sizeToFit];
}


@end
