//
//  UnknownWordController.m
//  RRDictionary2.0
//
//  Created by MillerD on 5/8/16.
//  Copyright © 2016 millerd. All rights reserved.
//

#import "UnknownWordController.h"
#import "MILArchiveTool.h"
#import "MILWords.h"

@interface UnknownWordController ()

@property (nonatomic, strong) NSMutableArray *words;

@end

@implementation UnknownWordController

#pragma mark - 懒加载
-(NSMutableArray *)words
{
    if (_words == nil) {
        _words = [MILArchiveTool alreadyInCollection];
    }
    return _words;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - 数据源和代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.words.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"savedWord";
    
    // 取出模型
    MILWords *model = self.words[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    cell.textLabel.text = model.keyword;
    cell.detailTextLabel.text = model.explain;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MILWords *word = self.words[indexPath.row];
    [MILArchiveTool uncollect:word];
    
    NSIndexPath *index1 = indexPath;
    NSArray *array = @[index1];
    
    [tableView deleteRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end