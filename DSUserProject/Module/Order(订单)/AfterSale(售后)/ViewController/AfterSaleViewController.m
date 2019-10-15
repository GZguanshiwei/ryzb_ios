//
//  AfterSaleViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/27.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "AfterSaleViewController.h"
#import "AfterSaleCell.h"
#import "AfterSaleDetailViewController.h"
#import "AfterSaleModel.h"

@interface AfterSaleViewController ()<UITableViewDataSource,UITableViewDelegate,AfterSaleCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tableData;

@property (strong, nonatomic) JMRefreshTool *refreshTool;
@end

@implementation AfterSaleViewController
-(void)initControl{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 240;
}

-(void)initData{
    self.title = @"退款";
    [self requestAfterSaleList];
}

#pragma mark - UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AfterSaleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AfterSaleCell"];
    cell.delegate = self;
    cell.index = indexPath.row;
    cell.cellData = self.tableData[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self goDetailVC:indexPath.row];
}

#pragma mark - AfterSaleCellDelegate
-(void)clickOperationButton:(NSInteger)index title:(NSString *)buttonTitle{
    if([buttonTitle isEqualToString:@"查看详情"]){
        [self goDetailVC:index];
    }
}

#pragma mark - 跳转
-(void)goDetailVC:(NSInteger)index{
    AfterSaleModel *model = self.tableData[index];
    AfterSaleDetailViewController *detailVC = [[AfterSaleDetailViewController alloc] initWithStoryboardName:@"AfterSale"];
    detailVC.afterSaleId = model.afterSaleId;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - 网络
-(void)requestAfterSaleList{
    if(self.refreshTool == nil){
        JMWeak(self);
        self.refreshTool = [[JMRefreshTool alloc] initWithScrollView:self.tableView dataAnalysisBlock:^NSArray *(NSDictionary *responseData) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            NSDictionary *dataDic = responseData[@"data"];
            NSArray *listArray = dataDic[@"list"];
            for(NSDictionary *dic in listArray){
                AfterSaleModel *model = [[AfterSaleModel alloc] initWithDictionary:dic];
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
        self.refreshTool.requestUrl = kUrlRefundList;
        NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
        [params setJsonValue:@"-1" key:@"state"];
        [params setJsonValue:@"-1" key:@"type"];
        self.refreshTool.requestParams = params;
    }
    [self.tableView.mj_header beginRefreshing];
}
@end
