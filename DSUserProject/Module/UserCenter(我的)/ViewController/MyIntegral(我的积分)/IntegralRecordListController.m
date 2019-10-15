//
//  IntegralRecordListController.m
//  JMBaseProject
//
//  Created by 潘传标 on 2019/9/6.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "IntegralRecordListController.h"
#import "LiveIronRecordListCell.h"
#import "LevelRecordModel.h"

@interface IntegralRecordListController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tableData;
@property (strong, nonatomic) JMRefreshTool *refreshTool;
@end

@implementation IntegralRecordListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initControl
{
    self.title = @"积分记录";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = 55.0;
}

-(void)initData{
    [self requestRecordList];
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LiveIronRecordListCell *listCell = [tableView dequeueReusableCellWithIdentifier:@"LiveIronRecordListCell"];
    listCell.ucLevelData = self.tableData[indexPath.row];
    return listCell;
}

#pragma mark - 网络
-(void)requestRecordList{
    if(self.refreshTool == nil){
        JMWeak(self);
        self.refreshTool = [[JMRefreshTool alloc] initWithScrollView:self.tableView dataAnalysisBlock:^NSArray *(NSDictionary *responseData) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            NSArray *dataArray = responseData[@"data"][@"list"];
            for(NSDictionary *dic in dataArray){
                LevelRecordModel *model = [[LevelRecordModel alloc] initWithDictionary:dic];
                [array addObject:model];
            }
            if([weakself.refreshTool isAddData]){
                [weakself.tableData addObjectsFromArray:array];
            }else{
                weakself.tableData = array;
            }
            [weakself.tableView reloadData];
            return array;
        }];
        self.refreshTool.requestUrl = kUrlVipLevelRecord;
        NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
        self.refreshTool.requestParams = params;
    }
    
    [self.tableView.mj_header beginRefreshing];
}
@end
