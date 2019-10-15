//
//  GoodEvaluateViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2018/12/27.
//  Copyright © 2018 liuny. All rights reserved.
//

#import "GoodEvaluateViewController.h"
#import "GoodEvalutionCell.h"

@interface GoodEvaluateViewController()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *noDataView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tableData;

@property (strong, nonatomic) JMRefreshTool *refreshTool;
@end

@implementation GoodEvaluateViewController

-(void)initControl{
    self.title = @"商品评价";
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.tableFooterView = [UIView new];
}

-(void)initData{
    if(kUseTestData){
        self.tableData = [[NSMutableArray alloc] init];
        GoodEvalutionModel *model1 = [[GoodEvalutionModel alloc] init];
        model1.content = @"等发售等了好久了！！抢到了第一批货！！真的太好看了！！金色的真的超级酷！";
        model1.pictureArray = [@[@"1",@"1",@"1",@"1"] mutableCopy];
        model1.starLevel = @"4";
        model1.userName = @"手镯456";
        model1.time = @"2018-05-20 12:20";
        [self.tableData addObject:model1];
        GoodEvalutionModel *model2 = [[GoodEvalutionModel alloc] init];
        model2.content = @"出国前抢到的，太好了";
        model2.starLevel = @"5";
        model2.userName = @"手镯456";
        model2.time = @"2018-05-20 12:20";
        [self.tableData addObject:model2];
    }else{
        [self requestEvaluateList];
    }
}

-(void)updateShow{
    if(self.tableData.count == 0){
        [self.view bringSubviewToFront:self.noDataView];
    }else{
        [self.view bringSubviewToFront:self.tableView];
    }
    [self.tableView reloadData];
}

#pragma mark - UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodEvalutionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodEvalutionCell"];
    cell.cellData = self.tableData[indexPath.row];
    return cell;
}

#pragma mark - 网络
-(void)requestEvaluateList{
    JMWeak(self);
    if(self.refreshTool == nil){
        self.refreshTool = [[JMRefreshTool alloc] initWithScrollView:self.tableView dataAnalysisBlock:^NSArray *(NSDictionary *responseData) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            NSArray *list = responseData[@"data"][@"list"];
            for(NSDictionary *dic in list){
                GoodEvalutionModel *model = [[GoodEvalutionModel alloc] initWithEvalutionListDictionary:dic];
                [array addObject:model];
            }
            if([weakself.refreshTool isAddData]){
                [weakself.tableData addObjectsFromArray:array];
            }else{
                weakself.tableData = array;
            }
            [weakself updateShow];
            return array;
        }];
    }
    
    self.refreshTool.requestUrl = kUrlGoodEvaluateList;
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.goodId key:@"goodsId"];
    self.refreshTool.requestParams = params;
    [self.tableView.mj_header beginRefreshing];
}
@end
