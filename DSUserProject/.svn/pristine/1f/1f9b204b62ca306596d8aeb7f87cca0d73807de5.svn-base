//
//  MemberCenterController.m
//  JMBaseProject
//
//  Created by 潘传标 on 2019/9/6.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "MemberCenterController.h"
#import "IntegralRecordListController.h"
#import "MarketViewController.h"
#import "UCInviteViewController.h"
#import "OrderViewController.h"
#import "MemberModel.h"
#import "DailyTasksModel.h"
#import "DailyTasksCell.h"

@interface MemberCenterController ()<UITableViewDelegate,UITableViewDataSource,DailyTasksCellDelegate>

/** 当前等级 */
@property (strong, nonatomic) IBOutlet UIImageView *leftLevelImageView;
/** 下一级等级 */
@property (strong, nonatomic) IBOutlet UIImageView *rightLevelImageView;
/** 等级进度 */
@property (strong, nonatomic) IBOutlet UIProgressView *progressView;
/** 总积分说明 */
@property (strong, nonatomic) IBOutlet UIButton *descButton;
/** 邀请返利1% */
@property (strong, nonatomic) IBOutlet UIImageView *inviteImageView;
@property (strong, nonatomic) IBOutlet UILabel *inviteLabel;
/** 每月优惠券10元 */
@property (strong, nonatomic) IBOutlet UIImageView *couponImageView;
@property (strong, nonatomic) IBOutlet UILabel *couponLabel;
/** 免鉴宝费 */
@property (strong, nonatomic) IBOutlet UIView *freeView;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightLC;
@property (nonatomic, strong) NSArray *tableData;
@property (nonatomic, strong) MemberModel *model;

@end

@implementation MemberCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initControl
{
    self.jm_navgationBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    ViewRadius(self.progressView, 5);
    self.freeView.hidden = YES;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)initData {
    [self requestMyMember];
    [self requestDailyTasks];
}

- (void)setModel:(MemberModel *)model {
    _model = model;
    NSString *leftLevel = [NSString stringWithFormat:@"vip_level%d",self.model.grade.intValue-1];
    self.leftLevelImageView.image = [UIImage imageNamed:leftLevel];
    NSString *rightLevel = [NSString stringWithFormat:@"vip_level%d",self.model.nextGrade.intValue-1];
    self.rightLevelImageView.image = [UIImage imageNamed:rightLevel];
    if(self.model.nextGrade.length > 0){
        CGFloat percent = self.model.experience.floatValue/self.model.nextIntegral.floatValue;
        self.progressView.progress = percent;
        int count = self.model.nextIntegral.intValue - self.model.experience.intValue;
        [self.descButton setTitle:[NSString stringWithFormat:@"总积分%d，还差%d分升级%@会员",self.model.experience.intValue,count,self.model.nextGradeName] forState:UIControlStateNormal];
    }else{
        //没有下一等级
        self.progressView.progress = 1.0;
        [self.descButton setTitle:[NSString stringWithFormat:@"总积分%d，还差0分升级",self.model.experience.intValue] forState:UIControlStateNormal];
    }
    
    switch (self.model.grade.intValue) {
        case 1:
            self.inviteImageView.image = [UIImage imageNamed:@"vip_equity_01"];
            self.couponImageView.image = [UIImage imageNamed:@"vip_equity_02"];
            self.inviteLabel.text = @"邀请返利1%";
            self.couponLabel.text = @"每月优惠券10元";
            break;
        case 2:
            self.inviteImageView.image = [UIImage imageNamed:@"vip_equity_03"];
            self.couponImageView.image = [UIImage imageNamed:@"vip_equity_04"];
            self.inviteLabel.text = @"邀请返利2%";
            self.couponLabel.text = @"每月优惠券50元";
            break;
        case 3:
            self.inviteImageView.image = [UIImage imageNamed:@"vip_equity_05"];
            self.couponImageView.image = [UIImage imageNamed:@"vip_equity_06"];
            self.inviteLabel.text = @"邀请返利3%";
            self.couponLabel.text = @"每月优惠券100元";
            self.freeView.hidden = NO;
            break;
        default:
            break;
    }
}

/**
 更新tableview高度
 */
- (void)updateTableViewHeight {
    CGFloat height = self.tableData.count * 60;
    self.tableViewHeightLC.constant = height;
    [self.tableView reloadData];
    [self.view layoutIfNeeded];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DailyTasksCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DailyTasksCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellData = self.tableData[indexPath.row];
    cell.index = indexPath.row;
    cell.delegate = self;
    
    return cell;
}

#pragma mark - DailyTasksCellDelegate
- (void)completeButtondDid:(NSInteger)index {
    DailyTasksModel *model = self.tableData[index];
    switch (model.tasksId.integerValue) {
        case 6:
            [self goMarkekVC:@"0"];
            break;
        case 7:
            [self goMarkekVC:@"0"];
            break;
        case 8:
            [self goMarkekVC:@"1"];
            break;
        case 9:
            [self goInviteVC];
            break;
        case 10:
            [self goOrderVC];
            break;
        case 11:
            [self goMarkekVC:@"1"];
            break;
        default:
            break;
    }
}

#pragma mark - Actions
- (IBAction)backButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)fansInforAction:(id)sender {
    HtmlViewController *htmlVC = [[HtmlViewController alloc] init];
    htmlVC.type = Html_VipLevel;
    [self.navigationController pushViewController:htmlVC animated:YES];
}

//积分记录
- (IBAction)recordButtonClick:(UIButton *)sender {
    IntegralRecordListController *recordVc = [[IntegralRecordListController alloc] initWithStoryboardName:@"Mine"];
    [self.navigationController pushViewController:recordVc animated:YES];
}

#pragma mark - 跳转
/**
 跳转首页

 @param type 0直播 1商城
 */
- (void)goMarkekVC:(NSString *)type {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationMarketTypeChange object:type];
    self.tabBarController.selectedIndex = 0;
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)goInviteVC {
    UCInviteViewController *inviteVC = [[UCInviteViewController alloc] initWithStoryboardName:@"UserCenter"];
    [self.navigationController pushViewController:inviteVC animated:YES];
}

-(void)goOrderVC{
    OrderViewController *orderVC = [[OrderViewController alloc] initWithStoryboardName:@"Order"];
    orderVC.selectIndex = 4;
    [self.navigationController pushViewController:orderVC animated:YES];
}

#pragma mark - 网络
/**
 获取我的会员等级信息
 */
- (void)requestMyMember {
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [[JMRequestManager sharedManager] POST:kUrlMyMember parameters:params completion:^(JMBaseResponse *response) {
        if (response.error) {
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else {
            NSDictionary *dict = response.responseObject[@"data"];
            MemberModel *model = [[MemberModel alloc] initWithDictionary:dict];
            self.model = model;
        }
    }];
}

/**
 获取每日任务
 */
- (void)requestDailyTasks {
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [[JMRequestManager sharedManager] POST:kUrlDailyTasks parameters:params completion:^(JMBaseResponse *response) {
        if (response.error) {
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in response.responseObject[@"data"]) {
                DailyTasksModel *model = [[DailyTasksModel alloc] initWithDictionary:dict];
                [array addObject:model];
            }
            self.tableData = array;
            [self updateTableViewHeight];
        }
    }];
}

@end
