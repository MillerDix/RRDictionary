//
//  MILMineController.m
//  RRDictionary2.0
//
//  Created by MillerD on 3/21/16.
//  Copyright © 2016 millerd. All rights reserved.
//

#import "MILMineController.h"
#import "MILMineHeaderView.h"

@interface MILMineController ()<MILMineHeaderViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

// headerView
@property (nonatomic, strong) MILMineHeaderView *headerView;
// cell数组
@property (nonatomic, strong) NSArray *cellArray;
// 临时存储头像
@property (nonatomic, strong) UIButton *headButton;

@end

@implementation MILMineController

#pragma mark - 组头代理
// 点击头像
-(void)didClickHeadButton:(UIButton *)button
{
    
    self.headButton = button;
    // 创建actionSheetController
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择文件来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    // 检测摄像头是否可用
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        
        // 创建action
        // 照相机
        UIAlertAction *camera = [UIAlertAction actionWithTitle:@"照相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"拍照");
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
            picker.delegate = self;
            picker.allowsEditing = YES;//设置可编辑
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:nil];
        }];
        
        // 本地相册
        UIAlertAction *localAlbum = [UIAlertAction actionWithTitle:@"本地相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           
            NSLog(@"从手机相册选择");
            UIImagePickerController *picker =[[UIImagePickerController alloc]init];
            picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            picker.delegate = self;
            picker.allowsEditing=YES;
            [self presentViewController:picker animated:YES completion:nil];
            
        }];
        
        // 取消
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"取消");
        }];
        
        [alertController addAction:camera];
        [alertController addAction:localAlbum];
        [alertController addAction:cancel];
        
//    }
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    // 判断获取类型：图片
    //if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        UIImage *theImage = nil;
        // 判断，图片是否允许修改
        if ([picker allowsEditing]){
            //获取用户编辑之后的图像
            theImage = [info objectForKey:UIImagePickerControllerEditedImage];
        } else {
            // 照片的元数据参数
            theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
            
        }
    
    //
    NSData *imageData = UIImageJPEGRepresentation(theImage, 0.8);
    // 关闭控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    // 保存头像
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    NSLog(@"%@",fullPath);
    [imageData writeToFile:fullPath atomically:YES];
    // 给设置头像
    [self.headButton setBackgroundImage:theImage forState:UIControlStateNormal];
    //}
}

// 点击生词本
-(void)didClickUnknownWordButton:(UIButton *)button
{
    
}

// 点击翻译
-(void)didClickTranslateButton:(UIButton *)button
{
    
}

#pragma mark - 懒加载

-(NSArray *)cellArray
{
    if (_cellArray == nil) {
        _cellArray = [NSArray array];
        _cellArray = @[@"我的剧本", @"我的录音", @"我的等级", @"设置"];
    }
    return _cellArray;
}

-(MILMineHeaderView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[MILMineHeaderView alloc] init];
        _headerView.delegate = self;
    }
    return _headerView;
}



#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 取消cell分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 隐藏导航栏
    self.navigationController.navigationBarHidden = YES;
    
    // 隐藏状态栏
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
    {
        // iOS 7
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
}

- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
}


#pragma mark - 数据源和代理

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"mineCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.textLabel.text = self.cellArray[indexPath.row];
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 250;
}



@end
