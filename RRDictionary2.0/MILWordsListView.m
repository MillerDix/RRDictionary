//
//  MILWordsListView.m
//  RRDictionary2.0
//
//  Created by MillerD on 3/29/16.
//  Copyright © 2016 millerd. All rights reserved.
//

#import "MILWordsListView.h"
#import "MILHomeCell.h"


@interface MILWordsListView ()

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end
@implementation MILWordsListView

-(instancetype)init
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, 200);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    return [super initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
}

-(void)setWords:(NSArray *)words
{
    _words = words;
    [self reloadData];
}

static NSString *ID = @"homeCell";

#pragma mark - collectionView的数据源
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.words.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MILHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[MILHomeCell alloc] init];
    }
    
    cell.word = self.words[indexPath.item];
    
    return cell;
}











@end

