//
//  GiftCollectionViewFlowLayout.m
//  JMBaseProject
//
//  Created by liuny on 2018/6/26.
//  Copyright © 2018年 liuny. All rights reserved.
//

#import "GiftCollectionViewFlowLayout.h"

@interface GiftCollectionViewFlowLayout()<UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) NSMutableArray *allAttributes;
@end

@implementation GiftCollectionViewFlowLayout
#pragma mark - Public
- (void)setColumnSpacing:(CGFloat)columnSpacing rowSpacing:(CGFloat)rowSpacing edgeInsets:(UIEdgeInsets)edgeInsets
{
    self.columnSpacing = columnSpacing;
    self.rowSpacing = rowSpacing;
    self.edgeInsets = edgeInsets;
}

- (void)setRowCount:(NSInteger)rowCount itemCountPerRow:(NSInteger)itemCountPerRow
{
    self.rowCount = rowCount;
    self.itemCountPerRow = itemCountPerRow;
}

#pragma mark - 构造方法
+ (instancetype)horizontalPageFlowlayoutWithRowCount:(NSInteger)rowCount itemCountPerRow:(NSInteger)itemCountPerRow
{
    return [[self alloc] initWithRowCount:rowCount itemCountPerRow:itemCountPerRow];
}

- (instancetype)initWithRowCount:(NSInteger)rowCount itemCountPerRow:(NSInteger)itemCountPerRow
{
    self = [super init];
    if (self) {
        self.rowCount = rowCount;
        self.itemCountPerRow = itemCountPerRow;
    }
    return self;
}


#pragma mark - 重写父类方法
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setColumnSpacing:0 rowSpacing:0 edgeInsets:UIEdgeInsetsZero];
    }
    return self;
}

/** 布局前做一些准备工作 */
- (void)prepareLayout
{
    [super prepareLayout];
    
    // 从collectionView中获取到有多少个item
    NSInteger itemTotalCount = [self.collectionView numberOfItemsInSection:0];
    
    // 遍历出item的attributes,把它添加到管理它的属性数组中去
    for (int i = 0; i < itemTotalCount; i++) {
        NSIndexPath *indexpath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexpath];
        [self.attributesArrayM addObject:attributes];
    }
}

/** 计算collectionView的滚动范围 */
- (CGSize)collectionViewContentSize
{
    CGFloat collectionWidth = self.collectionView.frame.size.width;
    NSInteger itemTotalCount = [self.collectionView numberOfItemsInSection:0];
    // 理论上每页展示的item数目
    NSInteger itemCount = self.rowCount * self.itemCountPerRow;
    NSInteger pageCount = ceil((float)itemTotalCount/(float)itemCount);
    CGFloat width = pageCount * collectionWidth;
    CGFloat height = self.collectionView.frame.size.height;
    return CGSizeMake(width, height);
}

/** 设置每个item的属性(主要是frame) */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // item的宽高由行列间距和collectionView的内边距决定
    CGFloat itemWidth = (self.collectionView.frame.size.width - self.edgeInsets.left - self.edgeInsets.right - (self.itemCountPerRow - 1) * self.columnSpacing) / (float)self.itemCountPerRow;
    CGFloat itemHeight = (self.collectionView.frame.size.height - self.edgeInsets.top - self.edgeInsets.bottom - (self.rowCount - 1) * self.rowSpacing) / (float)self.rowCount;
    
    NSInteger item = indexPath.item;
    NSInteger itemCount = self.rowCount * self.itemCountPerRow;
    // 当前item所在的页
    NSInteger pageNumber = floor((float)item/(float)itemCount);
    NSInteger x = item%self.itemCountPerRow;
    NSInteger y = (item-pageNumber*itemCount)/self.itemCountPerRow;
    // 计算出item的坐标
    CGFloat itemX = pageNumber * self.collectionView.frame.size.width + self.edgeInsets.left + x*(itemWidth + self.columnSpacing);
    CGFloat itemY = self.edgeInsets.top + (itemHeight + self.rowSpacing) * y;
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    // 每个item的frame
    attributes.frame = CGRectMake(itemX, itemY, itemWidth, itemHeight);
    
    return attributes;
}

/** 返回collectionView视图中所有视图的属性数组 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    return self.attributesArrayM;
}


#pragma mark - Lazy
- (NSMutableArray *)attributesArrayM
{
    if (!_attributesArrayM) {
        _attributesArrayM = [NSMutableArray array];
    }
    return _attributesArrayM;
}
@end
