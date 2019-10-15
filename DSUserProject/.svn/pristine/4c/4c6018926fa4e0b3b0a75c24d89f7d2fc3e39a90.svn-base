//
//  ShopOrderListViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/27.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "ShopOrderListViewController.h"
#import "OrderCell.h"
#import "ShopOrderDetailViewController.h"
#import "LogisticsViewController.h"

@interface ShopOrderListViewController ()<UITableViewDataSource,UITableViewDelegate,OrderCellDelegate>
@property (weak, nonatomic) IBOutlet UIView *noDataView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tableData;

@property (strong, nonatomic) JMRefreshTool *refreshTool;
@end

@implementation ShopOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initControl{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 240;
}

-(void)initData{
    [self requestOrderList];
}

-(void)checkDataEmpty{
    if(self.tableData.count == 0){
        self.tableView.hidden = YES;
        self.noDataView.hidden = NO;
    }else{
        self.tableView.hidden = NO;
        self.noDataView.hidden = YES;
    }
}

#pragma mark - UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCell"];
    cell.shopOrderData = self.tableData[indexPath.row];
    cell.delegate = self;
    cell.index = indexPath.row;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderModel *order = self.tableData[indexPath.row];
    [self goDetailVC:order.orderId];
}

#pragma mark - OrderCellDelegate
-(void)clickOperationButton:(NSInteger)index title:(NSString *)buttonTitle{
    if([buttonTitle isEqualToString:@"查看物流"]){
        OrderModel *order = self.tableData[index];
        [self goLogisticsVC:order.orderNo];
    }
}

-(void)goDetailVC:(NSString *)orderId{
    ShopOrderDetailViewController *detailVC = [[ShopOrderDetailViewController alloc] initWithStoryboardName:@"ShopOrder"];
    detailVC.orderId = orderId;
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(void)goLogisticsVC:(NSString *)orderNo{
    LogisticsViewController *logisticsVC = [[LogisticsViewController alloc] initWithStoryboardName:@"Logistics"];
    logisticsVC.orderNo = orderNo;
    [self.navigationController pushViewController:logisticsVC animated:YES];
}

#pragma mark - 网络
-(void)requestOrderList{
    //订单列表
    if(self.refreshTool == nil){
        JMWeak(self);
        self.refreshTool = [[JMRefreshTool alloc] initWithScrollView:self.tableView dataAnalysisBlock:^NSArray *(NSDictionary *responseData) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            NSDictionary *dataDic = responseData[@"data"];
            NSArray *listArray = dataDic[@"list"];
            for(NSDictionary *dic in listArray){
                OrderModel *model = [[OrderModel alloc] initWithOrderListDictionary:dic];
                [array addObject:model];
            }
            if([weakself.refreshTool isAddData] == YES){
                [weakself.tableData addObjectsFromArray:array];
            }else{
                weakself.tableData = array;
            }
            
            [weakself.tableView reloadData];
            return array;
        }];
        self.refreshTool.requestUrl = kUrlMyShopOrderList;
        NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
        NSString *state;
        switch (self.type) {
            case 0:
                state = @"-1";
                break;
            case 1:
                state = @"0";
                break;
            case 2:
                state = @"2";
                break;
            case 3:
                state = @"7";
                break;
            case 4:
                state = @"8";
                break;
            default:
                break;
        }
        [params setJsonValue:state key:@"state"];
        self.refreshTool.requestParams = params;
    }
    [self.refreshTool loadMore:NO];
}
@end
