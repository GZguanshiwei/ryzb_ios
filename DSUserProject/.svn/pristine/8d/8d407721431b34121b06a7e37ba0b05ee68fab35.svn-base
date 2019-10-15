//
//  LiveCommentViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/28.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "LiveCommentViewController.h"
#import "GoodEvalutionCell.h"

@interface LiveCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tableData;

@property (strong, nonatomic) JMRefreshTool *refreshTool;
@end

@implementation LiveCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initControl{
    self.view.backgroundColor = [UIColor clearColor];
    
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

#pragma mark - UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodEvalutionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodEvalutionCell"];
    cell.cellData = self.tableData[indexPath.row];
    return cell;
}

#pragma mark - Actions
- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 网络
-(void)requestEvaluateList{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.roomId key:@"roomId"];
    [[JMRequestManager sharedManager] POST:kUrlLiveGoodComment parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            NSMutableArray *array = [[NSMutableArray alloc] init];
            NSArray *dataArray = response.responseObject[@"data"];
            for(NSDictionary *dic in dataArray){
                GoodEvalutionModel *model = [[GoodEvalutionModel alloc] initWithEvalutionListDictionary:dic];
                model.userHeadUrl = [dic getJsonValue:@"head"];
                model.userName = [dic getJsonValue:@"nick"];
                [array addObject:model];
            }
            self.tableData = array;
            [self.tableView reloadData];
            self.numLabel.text = [NSString stringWithFormat:@"买家评价（%d）",(int)self.tableData.count];
        }
    }];
}
@end
