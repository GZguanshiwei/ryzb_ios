//
//  LogisticsViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/7/16.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "LogisticsViewController.h"
#import "LogisticsCell.h"
#import "LogisticsModel.h"

@interface LogisticsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tableData;
@property (strong, nonatomic) NSDictionary *logisticsNameAndCode;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@end

@implementation LogisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initControl{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60.0;
}

-(void)initData{
    self.title = @"物流详情";
    
    self.logisticsNameAndCode = @{@"SF":@"顺丰速运",
                                  @"HTKY":@"百世快递",
                                  @"ZTO":@"中通快递",
                                  @"STO":@"申通快递",
                                  @"YTO":@"圆通速递",
                                  @"YD":@"韵达速递",
                                  @"YZPY":@"邮政快递包裹",
                                  @"EMS":@"EMS",
                                  @"HHTT":@"天天快递",
                                  @"JD":@"京东物流",
                                  @"QFKD":@"全峰快递",
                                  @"GTO":@"国通快递",
                                  @"UC":@"优速快递",
                                  @"DBL":@"德邦",
                                  @"FAST":@"快捷快递",
                                  @"ZJS":@"宅急送",
                                  };
    if(self.orderNo.length > 0){
        //使用订单号查询
        [self requestLogisticsList];
    }else{
        //使用物流号查询
        [self requestLogisticsListWithLogisticsNo];
    }
    
}

#pragma mark - UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LogisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LogisticsCell"];
    cell.cellData = self.tableData[indexPath.row];
    return cell;
}

#pragma mark - 网络
-(void)requestLogisticsList{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.orderNo key:@"orderNo"];
    [self showLoading];
    [[JMRequestManager sharedManager] POST:kUrlLogistics parameters:params completion:^(JMBaseResponse *response) {
        [self dismissLoading];
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            NSDictionary *dataDic = response.responseObject[@"data"];
            NSString *code = [dataDic getJsonValue:@"ShipperCode"];
            NSString *name = [self.logisticsNameAndCode getJsonValue:code];
            self.nameLabel.text = name;
            self.numberLabel.text = [NSString stringWithFormat:@"物流单号：%@",[dataDic getJsonValue:@"LogisticCode"]];
            //物流状态
            //0:无轨迹 1:已揽收 2:在途中 3:签收 4:问题件
            NSString *state = [dataDic getJsonValue:@"State"];
            NSArray *tracesArray = dataDic[@"Traces"];
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for(NSDictionary *dic in tracesArray){
                LogisticsModel *model = [[LogisticsModel alloc] initWithDictionary:dic state:state];
                [array addObject:model];
            }
            LogisticsModel *first = array.firstObject;
            first.isFirstOne = YES;
            LogisticsModel *last = array.lastObject;
            last.isLastOne = YES;
            self.tableData = array;
            [self.tableView reloadData];
        }
    }];
}

-(void)requestLogisticsListWithLogisticsNo{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.logisticsNo key:@"logisticsNo"];
    [self showLoading];
    [[JMRequestManager sharedManager] POST:kUrlLogisticsWithLogisticsNo parameters:params completion:^(JMBaseResponse *response) {
        [self dismissLoading];
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            NSDictionary *dataDic = response.responseObject[@"data"];
            NSString *code = [dataDic getJsonValue:@"ShipperCode"];
            NSString *name = [self.logisticsNameAndCode getJsonValue:code];
            self.nameLabel.text = name;
            self.numberLabel.text = [NSString stringWithFormat:@"物流单号：%@",[dataDic getJsonValue:@"LogisticCode"]];
            //物流状态
            //0:无轨迹 1:已揽收 2:在途中 3:签收 4:问题件
            NSString *state = [dataDic getJsonValue:@"State"];
            NSArray *tracesArray = dataDic[@"Traces"];
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for(NSDictionary *dic in tracesArray){
                LogisticsModel *model = [[LogisticsModel alloc] initWithDictionary:dic state:state];
                [array addObject:model];
            }
            LogisticsModel *first = array.firstObject;
            first.isFirstOne = YES;
            LogisticsModel *last = array.lastObject;
            last.isLastOne = YES;
            self.tableData = array;
            [self.tableView reloadData];
        }
    }];
}

@end
