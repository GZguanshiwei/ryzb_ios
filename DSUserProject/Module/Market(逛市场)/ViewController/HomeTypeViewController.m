//
//  HomeTypeViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/21.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "HomeTypeViewController.h"
#import "HXTagCollectionViewFlowLayout.h"
#import "TagModel.h"
#import "TypeCell.h"

@interface HomeTypeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *collectionData;
@property (strong, nonatomic) HXTagCollectionViewFlowLayout *tagLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagHeightConstraint;
@property (strong, nonatomic) TagModel *selectTag;
@property (assign, nonatomic) NSInteger selectIndex;
@end

@implementation HomeTypeViewController
-(void)initControl{
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.tagLayout = [[HXTagCollectionViewFlowLayout alloc] init];
    JMWeak(self);
    self.tagLayout.completeLayout = ^(CGFloat contentHeight) {
        weakself.tagHeightConstraint.constant = contentHeight;
    };
    self.collectionView.collectionViewLayout = self.tagLayout;
}

-(void)initData{
    /*
    self.collectionData = [[NSMutableArray alloc] init];
    NSArray *array = @[@"手镯",@"翡翠",@"精选",@"精选",@"扳指",@"扳指",@"每日必看",@"翡翠",@"精选"];
    for(int i=0;i<array.count;i++){
        TagModel *model = [[TagModel alloc] initWithTagText:array[i]];
        [self.collectionData addObject:model];
    }
     */
    
    
}

-(void)setTypesArray:(NSMutableArray *)typesArray{
    _typesArray = typesArray;
    for(TagModel *model in self.typesArray){
        if(model.isSelect){
            self.selectTag =  model;
            break;
        }
    }
    self.collectionData = self.typesArray;
    [self.collectionView reloadData];
}

-(void)setSelectTag:(TagModel *)selectTag{
    if(self.selectTag){
        self.selectTag.isSelect = NO;
    }
    _selectTag = selectTag;
    self.selectTag.isSelect = YES;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionView
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger rtn = 0;
    rtn = self.collectionData.count;
    return rtn;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TypeCell" forIndexPath:indexPath];
    TagModel *model = self.collectionData[indexPath.row];
    [cell updateWithTitle:model.tagText isSelect:model.isSelect];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    TagModel *model = self.collectionData[indexPath.row];
    NSString *text = model.tagText;
    UIFont *font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
    //没有考虑多行（单行）
    CGFloat width = [text widthForFont:font];
    //向上取整，解决图片边框拉伸问题
    return CGSizeMake(ceilf(width)+13*2, 30);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //单选
    TagModel *model = self.collectionData[indexPath.row];
    self.selectTag = model;
    self.selectIndex = indexPath.row;
}

#pragma mark - Actions

- (IBAction)closeAction:(id)sender {
    if(self.selectBlock){
        self.selectBlock(self.selectIndex);
    }
    [self.view removeFromSuperview];
}
@end
