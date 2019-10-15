//
//  LiveLevelRecordViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/9/16.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "LiveLevelRecordViewController.h"
#import "LiveIronRecordListCell.h"

@interface LiveLevelRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tableData;
@property (strong, nonatomic) JMRefreshTool *refreshTool;
@end

@implementation LiveLevelRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initControl{
    self.view.backgroundColor = [UIColor clearColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 55.0;
}

-(void)initData{
    [self requestRecord];
}

#pragma mark - UINavigation
-(BOOL)navUIBaseViewControllerIsNeedNavBar:(JMNavUIBaseViewController *)navUIBaseViewController{
    return NO;
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LiveIronRecordListCell *listCell = [tableView dequeueReusableCellWithIdentifier:@"LiveIronRecordListCell" forIndexPath:indexPath];
    listCell.cellData = self.tableData[indexPath.row];
    return listCell;
}

#pragma mark - Actions
- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - 网络
-(void)requestRecord{
    if(self.refreshTool == nil){
        JMWeak(self);
        self.refreshTool = [[JMRefreshTool alloc] initWithScrollView:self.tableView dataAnalysisBlock:^NSArray *(NSDictionary *responseData) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            NSArray *listArray = responseData[@"data"][@"list"];
            for(NSDictionary *dic in listArray){
                LiveLevelRecordModel *model = [[LiveLevelRecordModel alloc] initWithDictionary:dic];
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
        NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
        self.refreshTool.requestUrl = kUrlLiveLevelRecord;
        self.refreshTool.requestParams = params;
    }
    [self.tableView.mj_header beginRefreshing];
}
@end
