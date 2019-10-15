//
//  UserCenterViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/15.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "UserCenterViewController.h"
#import "UserCell.h"
#import "NewsViewController.h"
#import "UCInfoViewController.h"
#import "UCInviteViewController.h"
#import "SetViewController.h"
#import "AboutUsViewController.h"
#import "WalletViewController.h"
#import "MyShopViewController.h"
#import "OrderViewController.h"
#import "AfterSaleViewController.h"
#import "MyCouponCenterViewController.h"
#import "MyBargainingViewController.h"
#import "MemberCenterController.h"
#import "MyIntegralViewController.h"
@interface UserCenterViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *unreadNumView;
@property (strong, nonatomic) IBOutlet UILabel *unreadNumLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *statusBarHeightConstraint;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *integralLabel;
//会员等级
@property (strong, nonatomic) IBOutlet UIImageView *gradeImageView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tableData;

@property (weak, nonatomic) IBOutlet UILabel *stayPayLable;
@property (weak, nonatomic) IBOutlet UILabel *staySendLable;
@property (weak, nonatomic) IBOutlet UILabel *stayGetLable;
@property (weak, nonatomic) IBOutlet UILabel *stayCommentLable;
@property (weak, nonatomic) IBOutlet UILabel *refuseLable;

@end

@implementation UserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.stayPayLable.layer.cornerRadius = 10;
    self.stayPayLable.layer.masksToBounds = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //获取系统消息未读数
    [self requsetUnReadCount];
    [self requestOrderCount];
    [self getLoginUserInfoInfo];
}


-(void)initControl{
    self.unreadNumView.hidden = YES;
    self.unreadNumView.layer.cornerRadius = self.unreadNumView.mj_h/2.0;
    self.statusBarHeightConstraint.constant = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    //tableView
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 60.0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requsetUnReadCount) name:kNotificationSystemNotice object:nil];
}

-(void)initData{
    self.tableData = [[NSMutableArray alloc] init];
    [self.tableData addObject:@{@"title":@"我的钱包",@"image":@"mine_a02"}];
    [self.tableData addObject:@{@"title":@" 我的积分",@"image":@"mine_icon_jf"}];
    [self.tableData addObject:@{@"title":@" 我的优惠劵",@"image":@"mine_icon_yhq"}];
    [self.tableData addObject:@{@"title":@" 我的砍价",@"image":@"mine_icon_kj"}];
    [self.tableData addObject:@{@"title":@"我的店铺",@"image":@"mine_a03"}];
    [self.tableData addObject:@{@"title":@"邀请好友",@"image":@"mine_a04"}];
    [self.tableData addObject:@{@"title":@"帮助中心",@"image":@"mine_a05"}];
    [self.tableData addObject:@{@"title":@"关于我们",@"image":@"mine_a06"}];
    [self.tableData addObject:@{@"title":@"在线客服",@"image":@"mine_a07"}];
    [self.tableData addObject:@{@"title":@"电话客服",@"image":@"mine_a08"}];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshInfo) name:kNotificationUserUpdateHead object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshInfo) name:kNotificationUserUpdateName object:nil];
}

- (void)getLoginUserInfoInfo {
    [[JMProjectManager sharedJMProjectManager] updateLoginUserInfoSuccessBlock:^{
        [self refreshInfo];
    } failBlock:nil];
}

-(void)refreshInfo{
    JMLoginUserModel *loginUser = [JMProjectManager sharedJMProjectManager].loginUser;
    [self.headImageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:loginUser.headUrl]];
    self.userNameLabel.text = loginUser.nickName;
    self.integralLabel.text = [NSString stringWithFormat:@"%@积分",loginUser.integral];
    self.gradeImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"vip_level_0%@",loginUser.grade]];
}

#pragma mark - Navigation
-(BOOL)navUIBaseViewControllerIsNeedNavBar:(JMNavUIBaseViewController *)navUIBaseViewController{
    return NO;
}

- (IBAction)setAction:(id)sender {
    SetViewController *setVC = [[SetViewController alloc] initWithStoryboardName:@"UserCenter"];
    [self.navigationController pushViewController:setVC animated:YES];
}

- (IBAction)messageAction:(id)sender {
    NewsViewController *newsVC = [[NewsViewController alloc] initWithStoryboardName:@"News"];
    [self.navigationController pushViewController:newsVC animated:YES];
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell"];
    cell.cellData = self.tableData[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.tableData[indexPath.row];
    NSString *title = [dic getJsonValue:@"title"];
    if([title isEqualToString:@"邀请好友"]){
        [self goInviteVC];
    }else if([title isEqualToString:@"关于我们"]){
        [self goAboutUsVC];
    }else if([title isEqualToString:@"我的钱包"]){
        [self goWalletVC];
    }else if([title isEqualToString:@"我的店铺"]){
        [self goMyShopVC];
    }else if([title isEqualToString:@"帮助中心"]){
        [self goHelpVC];
    }else if([title isEqualToString:@"在线客服"]){
        [self goCustomerServiceVC];
    }else if([title isEqualToString:@"电话客服"]){
        [self callCustomService];
    }else if ([title isEqualToString:@" 我的优惠劵"])
    {
        [self goCouponVC];
    }else if ([title isEqualToString:@" 我的砍价"])
    {
        [self goKanJiaVc];
    }else if ([title isEqualToString:@" 我的积分"])
 {
    [self goMyInteravalVc];
  }
}

#pragma mark - Actions
//会员中心
- (IBAction)memberCenterAction:(id)sender {
    [self goMemberCenterVc];
}

//用户
- (IBAction)userAction:(id)sender {
    [self goUserInfoVC];
}

//订单
- (IBAction)orderAction:(id)sender {
    [self goOrderVCWithType:0];
}
- (IBAction)orderWithStatusAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    [self goOrderVCWithType:button.tag];
}

//退货/退款
- (IBAction)refundAction:(id)sender {
    [self goOrderAfterSaleVC];
}

#pragma mark - 跳转

-(void)goMyInteravalVc
{
    MyIntegralViewController*interavalVc = [[MyIntegralViewController alloc] initWithStoryboardName:@"Mine"];
    [self.navigationController pushViewController:interavalVc animated:YES];
}

-(void)goMemberCenterVc
{
    MemberCenterController*memberVc = [[MemberCenterController alloc] initWithStoryboardName:@"Mine"];
    [self.navigationController pushViewController:memberVc animated:YES];
}
-(void)goKanJiaVc
{
    MyBargainingViewController *bargaingVc = [[MyBargainingViewController alloc] initWithStoryboardName:@"Mine"];
    [self.navigationController pushViewController:bargaingVc animated:YES];
}
-(void)goCouponVC{
    MyCouponCenterViewController *couponVC = [[MyCouponCenterViewController alloc] initWithStoryboardName:@"Mine"];
    [self.navigationController pushViewController:couponVC animated:YES];
}

-(void)goUserInfoVC{
    UCInfoViewController *infoVC = [[UCInfoViewController alloc] initWithStoryboardName:@"UserCenter"];
    [self.navigationController pushViewController:infoVC animated:YES];
}

-(void)goInviteVC{
    UCInviteViewController *inviteVC = [[UCInviteViewController alloc] initWithStoryboardName:@"UserCenter"];
    [self.navigationController pushViewController:inviteVC animated:YES];
}

-(void)goAboutUsVC{
    AboutUsViewController *aboutUsVC = [[AboutUsViewController alloc] initWithStoryboardName:@"UserCenter"];
    [self.navigationController pushViewController:aboutUsVC animated:YES];
}

-(void)goWalletVC{
    WalletViewController *walletVC = [[WalletViewController alloc] initWithStoryboardName:@"Wallet"];
    [self.navigationController pushViewController:walletVC animated:YES];
}

-(void)goMyShopVC{
    MyShopViewController *shopVC = [[MyShopViewController alloc] initWithStoryboardName:@"UserCenter"];
    [self.navigationController pushViewController:shopVC animated:YES];
}

-(void)goOrderVCWithType:(NSInteger)type{
    OrderViewController *orderVC = [[OrderViewController alloc] initWithStoryboardName:@"Order"];
    orderVC.selectIndex = type;
    [self.navigationController pushViewController:orderVC animated:YES];
}

-(void)goOrderAfterSaleVC{
    AfterSaleViewController *afterSaleVC = [[AfterSaleViewController alloc] initWithStoryboardName:@"AfterSale"];
    [self.navigationController pushViewController:afterSaleVC animated:YES];
}

-(void)goHelpVC{
    HtmlViewController *htmlVC = [[HtmlViewController alloc] init];
    htmlVC.type = Html_Help;
    [self.navigationController pushViewController:htmlVC animated:YES];
}

-(void)goCustomerServiceVC{
    JMLoginUserModel *loginUser = [JMProjectManager sharedJMProjectManager].loginUser;
    //联系客服
    QYSource *source = [[QYSource alloc] init];
    source.title = loginUser.nickName;
    source.urlString = loginUser.headUrl;
    QiYuCustomServiceController *sessionViewController = [[QiYuCustomServiceController alloc] init];
    sessionViewController.sessionTitle = @"客服";
    sessionViewController.source = source;
    [self.navigationController pushViewController:sessionViewController animated:YES];


}

-(void)callCustomService{
    [self requestGetSerivcePhone];
}

#pragma mark - 网络
-(void)requestGetSerivcePhone{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:@"11" key:@"id"];
    [[JMRequestManager sharedManager] POST:kUrlHtmlContent parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            NSDictionary *dataDic = response.responseObject[@"data"];
            NSString *mobile = [dataDic getJsonValue:@"content"];
            NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",mobile];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
    }];
    
}

/**
 获取系统消息未读数
 */
- (void)requsetUnReadCount {
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [[JMRequestManager sharedManager] POST:kUrlUnReadCount parameters:params completion:^(JMBaseResponse *response) {
        if (response.error) {
            
        }else {
            NSString *num = [response.responseObject getJsonValue:@"data"];
            if (num.integerValue == 0) {
                self.unreadNumView.hidden = YES;
            }else {
                self.unreadNumView.hidden = NO;
                self.unreadNumLabel.text = num;
            }
        }
    }];
}

-(void)requestOrderCount
{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [[JMRequestManager sharedManager] POST:
     kUrlOrderMyOrderNum parameters:params completion:^(JMBaseResponse *response) {
        if (response.error) {
            
        }else {
            NSDictionary *dataDic = response.responseObject[@"data"];
              [self refreshOrderNumWithData:dataDic];
        }
    }];
    
}

-(void)refreshOrderNumWithData:(NSDictionary *)dataDic
{
    
    NSString *noPayStr = [dataDic getJsonValue:@"noPay"];
    if (noPayStr.integerValue == 0) {
        self.stayPayLable.hidden = YES;
    }else
    {
        self.stayPayLable.hidden = NO;
        self.stayPayLable.text = noPayStr;
    }

    NSString *noDeliveryStr =  [dataDic getJsonValue:@"noDelivery"];
    if (noDeliveryStr.integerValue == 0) {
        self.staySendLable.hidden = YES;
    }else
    {
        self.staySendLable.hidden = NO;
        self.staySendLable.text = noDeliveryStr;
    }

    NSString *deliveryStr = [dataDic getJsonValue:@"delivery"];
    if (deliveryStr.integerValue == 0) {
        self.stayGetLable.hidden = YES;
    }else
    {
        self.stayGetLable.hidden = NO;
        self.stayGetLable.text = deliveryStr;
    }

    NSString *completeStr = [dataDic getJsonValue:@"complete"];
    if (completeStr.integerValue == 0) {
        self.stayCommentLable.hidden = YES;
    }else
    {
        self.stayCommentLable.hidden = NO;
        self.stayCommentLable.text = completeStr;
    }
    [self requestAfterSaleList];
}

#pragma mark - 网络
-(void)requestAfterSaleList{
    NSMutableDictionary *parames = [JMCommonMethod baseRequestParams];
    [parames setJsonValue:@"-1" key:@"state"];
    [parames setJsonValue:@"-1" key:@"type"];
    [[JMRequestManager sharedManager] GET:kUrlRefundList parameters:parames completion:^(JMBaseResponse *response) {
        NSDictionary *dataDic = response.responseObject[@"data"];
        NSString *refundStr =  [dataDic getJsonValue:@"totalRow"];
        if (refundStr.integerValue == 0) {
            self.refuseLable.hidden = YES;
        }else
        {
            self.refuseLable.hidden = NO;
            self.refuseLable.text = refundStr;
        }
    }];
}
@end
