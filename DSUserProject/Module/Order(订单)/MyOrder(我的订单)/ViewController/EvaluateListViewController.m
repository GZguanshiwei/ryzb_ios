//
//  EvaluateListViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/7/1.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "EvaluateListViewController.h"
#import "GoodEvalutionCell.h"
#import "OrderDetailViewController.h"
#import "OrderViewController.h"

@interface EvaluateListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tableData;
//商品信息
@property (weak, nonatomic) IBOutlet UIImageView *goodCoverImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end

@implementation EvaluateListViewController

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
    self.title = @"我的评价";
    [self requestMyEvaluate];
}

#pragma mark - Navigation
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(JMNavigationBar *)navigationBar{
    NSArray *vcArray = self.navigationController.viewControllers;
    UIViewController *backVC;
    for(UIViewController *vc in vcArray){
        if([vc isKindOfClass:[OrderDetailViewController class]]){
            backVC = vc;
            break;
        }
        if([vc isKindOfClass:[OrderViewController class]]){
            backVC = vc;
            break;
        }
    }
    if(backVC){
        [self.navigationController popToViewController:backVC animated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
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

#pragma mark - 网络
-(void)requestMyEvaluate{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.orderId key:@"orderId"];
    [self showLoading];
    [[JMRequestManager sharedManager] POST:kUrlMyEvaluateWithOrder parameters:params completion:^(JMBaseResponse *response) {
        [self dismissLoading];
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
//            NSDictionary *dataDic = response.responseObject[@"data"];
            

            NSArray *dicArray = response.responseObject[@"data"];
            NSDictionary *dataDic = dicArray.firstObject;
            NSString *goodCover = [dataDic valueForKey:@"thumbnail"];
            [self.goodCoverImageView sd_setImageWithURL:[NSURL URLWithString:goodCover]];
            NSString *goodName = [dataDic getJsonValue:@"goodsName"];
            self.goodNameLabel.text = goodName;
            NSString *price = [dataDic getJsonValue:@"price"];
            self.priceLabel.text = [NSString stringWithFormat:@"￥%@",price];
            
            self.tableData = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in dicArray) {
                GoodEvalutionModel *model = [[GoodEvalutionModel alloc] initWithEvalutionListDictionary:dic];
                [self.tableData addObject:model];
            }
    
            [self.tableView reloadData];
        }
    }];
}

@end
