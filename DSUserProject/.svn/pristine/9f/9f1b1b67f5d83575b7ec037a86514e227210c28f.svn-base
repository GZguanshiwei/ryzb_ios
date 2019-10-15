//
//  WalletDetailsViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/26.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "WalletDetailsViewController.h"
#import "DetailsCell.h"
#import "DetailsStatusCell.h"
#import "TypeView.h"
#import "DateView.h"
#import "WalletRecordModel.h"

@interface WalletDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UIButton *startDateButton;
@property (weak, nonatomic) IBOutlet UIButton *endDateButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tableData;

@property (strong, nonatomic) JMRefreshTool *refreshTool;
@property (strong, nonatomic) NSString *selectType;
@end

@implementation WalletDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initControl{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 60;
    self.tableView.tableFooterView = [UIView new];
}

-(void)initData{
    self.title = @"钱包明细";
    
    self.selectType = @"-1";
    NSDate *currDate = [NSDate date];
    NSString *currDay = [currDate stringWithFormat:@"yyyy-MM-dd"];
    [self.startDateButton setTitle:[NSString stringWithFormat:@"  %@",currDay] forState:UIControlStateNormal];
    [self.endDateButton setTitle:[NSString stringWithFormat:@"  %@",currDay] forState:UIControlStateNormal];
    
    [self requestList];
}

#pragma mark - UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WalletRecordModel *record = self.tableData[indexPath.row];
    if(record.type.intValue == 2 && record.withdrawState.intValue == 0){
        //提现审核中
        DetailsStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailsStatusCell"];
        cell.cellData = self.tableData[indexPath.row];
        return cell;
    }else{
        DetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailsCell"];
        cell.cellData = self.tableData[indexPath.row];
        return cell;
    }
}

#pragma mark - Actions
- (IBAction)typeAction:(id)sender {
    TypeView *typeView = [[TypeView alloc] initWithXib];
    [typeView showViewWithDoneBlock:^(NSDictionary *params) {
        NSString *buttonIndex = [params getJsonValue:@"ButtonIndex"];
        switch (buttonIndex.intValue) {
            case 0:
                self.typeLabel.text = @"全部";
                self.selectType = @"-1";
                break;
            case 1:
                self.typeLabel.text = @"收入";
                self.selectType = @"1";
                break;
            case 2:
                self.typeLabel.text = @"支出";
                self.selectType = @"0";
                break;
            default:
                break;
        }
        [self requestList];
    }];
}

- (IBAction)dateAction:(id)sender {
    DateView *dateView = [[DateView alloc] initWithXib];
    [dateView showViewWithDoneBlock:^(NSDictionary *params) {
        NSDate *date = params[@"Date"];
        NSString *title = [date stringWithFormat:@"yyyy-MM-dd"];
        UIButton *button = (UIButton *)sender;
        switch (button.tag) {
            case 0:
                [self.startDateButton setTitle:[NSString stringWithFormat:@"  %@",title] forState:UIControlStateNormal];
                break;
            case 1:
                [self.endDateButton setTitle:[NSString stringWithFormat:@"  %@",title] forState:UIControlStateNormal];
                break;
            default:
                break;
        }
        [self requestList];
    }];
    
}

#pragma mark - 网络
-(void)requestList{
    if(self.refreshTool == nil){
        JMWeak(self);
        self.refreshTool = [[JMRefreshTool alloc] initWithScrollView:self.tableView dataAnalysisBlock:^NSArray *(NSDictionary *responseData) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            NSDictionary *dataDic = responseData[@"data"];
            NSArray *listArray = dataDic[@"list"];
            for(NSDictionary *dic in listArray){
                WalletRecordModel *model = [[WalletRecordModel alloc] initWithDictionary:dic];
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
        self.refreshTool.requestUrl = kUrlWithdrawRecord;
    }
    
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    NSString *startDate = [self.startDateButton.currentTitle stringByTrim];
    NSString *endDate = [self.endDateButton.currentTitle stringByTrim];
    [params setJsonValue:startDate key:@"startTime"];
    [params setJsonValue:endDate key:@"endTime"];
    [params setJsonValue:self.selectType key:@"type"];
    self.refreshTool.requestParams = params;
    
    [self.tableView.mj_header beginRefreshing];
}

@end
