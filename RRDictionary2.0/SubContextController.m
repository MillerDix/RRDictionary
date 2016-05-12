//
//  SubContextController.m
//  RRDictionary2.0
//
//  Created by MillerD on 5/6/16.
//  Copyright © 2016 millerd. All rights reserved.
//

//http://91dict.com/rr/subcontext_word.php?id=1989032

#import "SubContextController.h"
#import "MILNetworkManager.h"
#import "SubContext.h"
#import "Mysub.h"
#import "SubContextCell.h"

@interface SubContextController () <NSXMLParserDelegate>

@property (nonatomic, copy) NSMutableString *mString;
@property (nonatomic, strong) SubContext *subContext;
@property (nonatomic, strong) Mysub *mysub;
@property (nonatomic, strong) NSMutableArray *mArray;

@end

@implementation SubContextController

#pragma mark - 懒加载
-(NSMutableArray *)mArray
{
    if (_mArray == nil) {
        _mArray = [NSMutableArray array];
    }
    return _mArray;
}

-(NSMutableString *)mString
{
    if (_mString == nil) {
        _mString = [NSMutableString string];
    }
    return _mString;
}


#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 取消分隔线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = self.task.subid;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    //设定返回类型为text/xml
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    //发送请求
    [manager GET:@"http://91dict.com/rr/subcontext_word.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSXMLParser *responseObject) {

        // 设置的代理并开始解析
        responseObject.delegate = self;
        [responseObject parse];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

}

#pragma mark - xml解析代理
// 开始解析文档
-(void)parserDidStartDocument:(NSXMLParser *)parser
{
    
}

// 开始解析标签
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    if ([elementName isEqualToString:@"subcontext"]) {
        // 创建整体模型
        self.subContext = [[SubContext alloc] init];
    }else if ([elementName isEqualToString:@"sub"]){
        // 创建内部数组模型并保存
        self.mysub = [[Mysub alloc] init];
        [self.mArray addObject:self.mysub];
    }
}

// 找到字符串
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [self.mString appendString:string];
    //NSLog(@"%@",string);
}

// 找到CDATA块
-(void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{
    NSString *string = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
    
    [self.mString appendString:string];
}

// 标签结束
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    NSString *resultString = [self.mString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([elementName isEqualToString:@"mysid"]) {
        self.subContext.mysid = resultString.intValue;
    }else if ([elementName isEqualToString:@"subimg"]){
        self.mysub.subimg = resultString;
    }else if ([elementName isEqualToString:@"subaudio"]){
        self.mysub.subaudio = resultString;
    }else if ([elementName isEqualToString:@"suben"]){
        self.mysub.suben = resultString;
    }else if ([elementName isEqualToString:@"subcn"]){
        self.mysub.subcn = resultString;
    }else if ([elementName isEqualToString:@"sudid"]){
        self.mysub.sudid = resultString.intValue;
    }else if ([elementName isEqualToString:@"sid"]){
        self.mysub.sid = resultString.intValue;
    }
    
    // 清空字符串
    [self.mString setString:@""];
}

// 文档解析完毕
-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    self.subContext.mysub = self.mArray.copy;
    [self.tableView reloadData];
    //Mysub *sub = self.subContext.mysub[0];
    //NSLog(@"%@", sub.subimg);
}


#pragma mark - 数据源和代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.subContext.mysub.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"subContextCell";
    
    // 取得模型
    Mysub *model = self.subContext.mysub[indexPath.row];
    
    // 创建cell
    SubContextCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SubContextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.mysid = self.subContext.mysid;
    cell.model = model;
    
    return cell;
}


// 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 240;
}



@end