//
//  GoodEvalutionCell.m
//  JMBaseProject
//
//  Created by Liuny on 2018/12/27.
//  Copyright © 2018 liuny. All rights reserved.
//

#import "GoodEvalutionCell.h"
#import "EvalutionItemCell.h"
#import "LEEStarRating.h"

@interface GoodEvalutionCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *starView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *specLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeightConstraint;
@property (strong, nonatomic) NSMutableArray *collectionData;

@property (nonatomic, strong) LEEStarRating *starDetailView;

@end

@implementation GoodEvalutionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initControl];
    [self initData];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initControl{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.headImageView.layer.cornerRadius = self.headImageView.mj_h/2.0;
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.headImageView.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.scrollEnabled = NO;
    
    [self initStarDetailView];
}

- (void)initStarDetailView{
    self.starDetailView = [[LEEStarRating alloc] initWithFrame:CGRectMake(0, 0, self.starView.mj_w, self.starView.mj_h) Count:5];
    self.starDetailView.spacing = 7.0f; //间距
    self.starDetailView.checkedImage = [UIImage imageNamed:@"home_b20"]; //选中图片
    self.starDetailView.uncheckedImage = [UIImage imageNamed:@"home_b21"]; //未选中图片
    self.starDetailView.type = RatingTypeWhole; //评分类型
    self.starDetailView.touchEnabled = NO; //是否启用点击评分 如果纯为展示则不需要设置
    self.starDetailView.slideEnabled = NO;
    self.starDetailView.maximumScore = 5.0f; //最大分数
    self.starDetailView.minimumScore = 1.0f; //最小分数
    self.starDetailView.currentScore = 5;
    
    [self.starView addSubview:self.starDetailView];
}

-(void)initData{
    
}

-(void)setCellData:(GoodEvalutionModel *)cellData{
    _cellData = cellData;
    self.contentLabel.text = self.cellData.content;
    self.timeLabel.text = self.cellData.time;
    self.starDetailView.currentScore = self.cellData.starLevel.integerValue;
    [self.headImageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:self.cellData.userHeadUrl]];
    self.nameLabel.text = self.cellData.userName;
    self.specLabel.text = self.cellData.spec;
    
    self.collectionData = self.cellData.pictureArray;
    if(self.collectionData.count == 0){
        self.collectionViewHeightConstraint.constant = 0;
    }else{
        CGFloat width = (kScreenWidth - 15.0*2 - 12.0*2)/3.0;
        NSInteger row = ceil(self.collectionData.count/3.0);
        CGFloat needHeight = width*row + 12*(row-1) + 15.0;
        self.collectionViewHeightConstraint.constant = needHeight;
    }
    [self.collectionView reloadData];
}

#pragma mark - UICollectionView
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.collectionData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    EvalutionItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EvalutionItemCell" forIndexPath:indexPath];
    [cell.pictureImageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:self.collectionData[indexPath.row]]];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (kScreenWidth - 15.0*2 - 12.0*2)/3.0;
    return CGSizeMake(width, width);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(15, 15, 0, 15);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10.0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 12.0;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for(NSString *imageUrl in self.cellData.pictureArray){
        [array addObject:[JMCommonMethod pinImagePath:imageUrl]];
    }
    [JMCommonMethod largeImagePreview:array currentIndex:indexPath.row];
}

@end
