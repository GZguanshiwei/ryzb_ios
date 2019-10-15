//
//  MyBargainingViewController.m
//  JMBaseProject
//
//  Created by 潘传标 on 2019/9/6.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "MyBargainingViewController.h"
#import "MyBargaingListCell.h"
#import "MyBargaingDetailController.h"
#import "BargainModel.h"
#import "MakeOrderViewController.h"

@interface MyBargainingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableData;
@property (strong, nonatomic) JMRefreshTool *refreshTool;

@property (nonatomic, strong) NSTimer *timer;
@end

@implementation MyBargainingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)dealloc{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)initControl
{
    self.title = @"我的砍价";
}

- (void)initData {
    [self requestBargainList];
}

- (void)startTimer
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeCount:) userInfo:nil repeats:YES];
        
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)timeCount:(NSTimer *)timer
{
    @synchronized(self) {
        [[self.tableView visibleCells] enumerateObjectsUsingBlock:^(__kindof UITableViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MyBargaingListCell *cell = (MyBargaingListCell *)obj;
            cell.cellData = cell.cellData;
        }];
    }
}

#pragma mark - UITableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 162;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyBargaingListCell *cell = [tableView dequeueReusableCellWithIdentifier:myBargaingListCellID forIndexPath:indexPath];
    cell.cellData = self.tableData[indexPath.row];
    cell.buttonActionBlock = ^(NSInteger index) {
        switch (index) {
            case 0:
            {
                //直接购买
                BargainModel *model = self.tableData[index];
                [self goMakeOrder:model];
                break;
            }
            case 1:
                //继续邀请好友
                [self yaoQingActionBlock:index];
                break;
                
            default:
                break;
        }
    };
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BargainModel *model = self.tableData[indexPath.row];
    MyBargaingDetailController *detailVc = [[MyBargaingDetailController alloc] initWithStoryboardName:@"Mine"];
    detailVc.bargainId = model.bargainId;
    [self.navigationController pushViewController:detailVc animated:YES];
}

-(void)yaoQingActionBlock:(NSInteger)index{
    BargainModel *model = self.tableData[index];
    ShareTipView *shareTipView = [[ShareTipView alloc] initWithXib];
    [shareTipView showShareWithType:Share_Bargain requestIds:model.bargainId];
}

#pragma mark - 网络
-(void)requestBargainList{
    if(self.refreshTool == nil){
        MJWeakSelf;
        self.refreshTool = [[JMRefreshTool alloc] initWithScrollView:self.tableView dataAnalysisBlock:^NSArray *(NSDictionary *responseData) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            NSArray *listArray = responseData[@"data"];
            for(NSDictionary *dic in listArray){
                BargainModel *model = [[BargainModel alloc] initWithDictionary:dic];
                [array addObject:model];
            }
            if([weakSelf.refreshTool isAddData]){
                [weakSelf.tableData addObjectsFromArray:array];
            }else{
                weakSelf.tableData = array;
            }
            
            [weakSelf.tableView reloadData];
            return array;
        }];
        
        self.refreshTool.requestUrl = kUrlBargainList;
        NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
        self.refreshTool.requestParams = params;
    }
    [self.tableView.mj_header beginRefreshing];
    [self startTimer];
}

-(void)goMakeOrder:(BargainModel *)bargainInfo{
    //下单
    NSMutableDictionary *parames = [JMCommonMethod baseRequestParams];
    [parames setJsonValue:bargainInfo.goodId key:@"goodsId"];
    [[JMRequestManager sharedManager] GET:kUrlOrdergoodsCanPay parameters:parames completion:^(JMBaseResponse *response) {
        if (response.error) {
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            NSString *canBuyStr  = response.responseObject[@"data"];
            if (canBuyStr.integerValue == 1) {
                //购买
                MakeOrderViewController *makeOrderVC = [[MakeOrderViewController alloc] initWithStoryboardName:@"GoodDetail"];
                GoodModel *good = [[GoodModel alloc] init];
                good.goodId = bargainInfo.goodId;
                good.title = bargainInfo.name;
                good.price = bargainInfo.goodPrice;
                good.coverImage = bargainInfo.coverImage;
                makeOrderVC.good = good;
                [self.navigationController pushViewController:makeOrderVC animated:YES];
            }else{
                [JMProgressHelper toastInWindowWithMessage:@"此商品正在结缘中"];
            }
        }
    }];
}
@end
