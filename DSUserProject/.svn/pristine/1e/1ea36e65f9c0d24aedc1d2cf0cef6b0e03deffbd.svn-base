//
//  GroupChildrenListViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/7/18.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "GroupChildrenListViewController.h"
#import "MarketShopCell.h"
#import "ResaleTipView.h"
#import "ResaleSuccessTipView.h"
#import "LiveRoomModel.h"
#import "SearchLiveCell.h"
#import "GoodDetailViewController.h"
#import "ShareImageViewController.h"

@interface GroupChildrenListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,MarketShopCellDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *collectionData;
@property (strong, nonatomic) JMRefreshTool *refreshTool;
@end

@implementation GroupChildrenListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initControl{
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
}

-(void)initData{
    [self requestGroupList];
}

#pragma mark - UICollectionView
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.collectionData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    id object = self.collectionData[indexPath.row];
    if([object isKindOfClass:[GoodModel class]]){
        MarketShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MarketShopCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.index = indexPath.row;
        cell.cellData = object;
        return cell;
    }else{
        SearchLiveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SearchLiveCell" forIndexPath:indexPath];
        cell.cellData = object;
        return cell;
    }
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(15, 15, 15, 15);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize rtn = CGSizeZero;
    rtn.width = (kScreenWidth-15*2-5)/2.0;
    rtn.height = rtn.width + 75;
    return rtn;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5.0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5.0;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    id object = self.collectionData[indexPath.row];
    if([object isKindOfClass:[GoodModel class]]){
        GoodModel *good = (GoodModel *)object;
        [self goGoodDetailVC:good.goodId];
    }else{
        LiveRoomModel *room = (LiveRoomModel *)object;
        [self enterLiveRoom:room.roomId];
    }
}

#pragma mark - MarketShopCellDelegate
-(void)didStore:(NSInteger)index{
    [self requestCollectionAtIndex:index];
}

-(void)didResale:(NSInteger)index{
    ResaleTipView *resaleView = [[ResaleTipView alloc] initWithXib];
    GoodModel *good = self.collectionData[index];
    resaleView.good = good;
    [resaleView showViewWithDoneBlock:^(NSDictionary * _Nonnull params) {
        NSString *buttonIndex = [params getJsonValue:@"ButtonIndex"];
        switch (buttonIndex.integerValue) {
            case 0://购买帮助
                [self goBuyHelpHtmlVC];
                break;
            case 1://转售
                [self requestResaleWithGood:good.goodId content:[params getJsonValue:@"Content"] index:index];
                break;
            default:
                break;
        }
    }];
}

-(void)showResaleSuccess:(GoodModel *)good{
    ResaleSuccessTipView *successView = [[ResaleSuccessTipView alloc] initWithXib];
    [successView showViewWithDoneBlock:^(NSDictionary * _Nonnull params) {
        NSString *buttonIndex = [params getJsonValue:@"ButtonIndex"];
        switch (buttonIndex.integerValue) {
            case 0://购买帮助
                [self goBuyHelpHtmlVC];
                break;
            case 1://分享朋友圈
            {
                ShareImageViewController *shareVC = [[ShareImageViewController alloc] initWithStoryboardName:@"Market"];
                shareVC.good = good;
                [self.view insertSubview:shareVC.view atIndex:0];
            }
                break;
            default:
                break;
        }
    }];
}


-(void)goBuyHelpHtmlVC{
    HtmlViewController *htmlVC = [[HtmlViewController alloc] init];
    htmlVC.type = Html_Buy;
    [self.navigationController pushViewController:htmlVC animated:YES];
}

#pragma mark - 跳转
-(void)goGoodDetailVC:(NSString *)goodId{
    GoodDetailViewController *detailVC = [[GoodDetailViewController alloc] initWithStoryboardName:@"GoodDetail"];
    detailVC.goodId = goodId;
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(void)enterLiveRoom:(NSString *)roomId{
    [[JMProjectManager sharedJMProjectManager] enterRoom:roomId];
}

#pragma mark - 网络
-(void)requestGroupList{
    if(self.refreshTool == nil){
        JMWeak(self);
        self.refreshTool = [[JMRefreshTool alloc] initWithScrollView:self.collectionView dataAnalysisBlock:^NSArray *(NSDictionary *responseData) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            NSDictionary *dataDic = responseData[@"data"];
            NSArray *listArray = dataDic[@"list"];
            for(NSDictionary *dic in listArray){
                NSString *roomId = [dic getJsonValue:@"roomId"];
                if(roomId.length > 0){
                    //直播间
                    LiveRoomModel *model = [[LiveRoomModel alloc] initWithDictionary:dic[@"room"]];
                    [array addObject:model];
                }else{
                    //商品
                    GoodModel *good = [[GoodModel alloc] initWithDictionary:dic];
                    [array addObject:good];
                }
            }
            if([weakself.refreshTool isAddData] == YES){
                [weakself.collectionData addObjectsFromArray:array];
            }else{
                weakself.collectionData = array;
            }
            [weakself.collectionView reloadData];
            return array;
        }];
        self.refreshTool.requestUrl = kUrlRecommendList;
        NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
        [params setJsonValue:self.typeId key:@"labelId"];
        NSString *isRoomGoods = self.type == 1?@"0":@"-1";
        [params setJsonValue:isRoomGoods key:@"isRoomGoods"];
        self.refreshTool.requestParams = params;
    }
    [self.collectionView.mj_header beginRefreshing];
}

-(void)requestResaleWithGood:(NSString *)goodId content:(NSString *)content index:(NSInteger)index{
    //转售
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:goodId key:@"goodsId"];
    [params setJsonValue:content key:@"describe"];
    [[JMRequestManager sharedManager] POST:kUrlResaleGood parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            GoodModel *good = self.collectionData[index];
            good.resaleContent = content;
            good.goodsResaleId = response.responseObject[@"data"];
            [self showResaleSuccess:good];
            [self refreshGoodAtIndex:index];
        }
    }];
}

-(void)requestCollectionAtIndex:(NSInteger)index{
    //收藏、取消收藏
    GoodModel *good = self.collectionData[index];
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:good.goodId key:@"goodsId"];
    [[JMRequestManager sharedManager] POST:kUrlCollectionGood parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            [JMProgressHelper toastInWindowWithMessage:response.responseObject[@"desc"]];
            [self refreshGoodAtIndex:index];
        }
    }];
}

-(void)refreshGoodAtIndex:(NSInteger)index{
    GoodModel *good = self.collectionData[index];
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:good.goodId key:@"goodsId"];
    [[JMRequestManager sharedManager] POST:kUrlGoodDetail parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            NSDictionary *dataDic = response.responseObject[@"data"];
            good.isCollected = [dataDic getJsonValue:@"isCollected"].boolValue;
            good.collectedNum = [dataDic getJsonValue:@"collectedNum"];
            good.resaleNum = [dataDic getJsonValue:@"resaleNum"];
            NSIndexPath *row = [NSIndexPath indexPathForItem:index inSection:0];
            [self.collectionView reloadItemsAtIndexPaths:@[row]];
        }
    }];
}
@end
