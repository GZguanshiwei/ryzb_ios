//
//  OrderDetailViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/26.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderModel.h"
#import "RefundViewController.h"
#import "RefundAndGoodViewController.h"
#import "EvaluateViewController.h"
#import "AddressListViewController.h"
#import "PayViewController.h"
#import "LogisticsViewController.h"
#import "GoodDetailViewController.h"
#import <DateTools.h>
#import "EvaluateListViewController.h"
#import "PayManyTimesViewController.h"
#import "GoodCouponSelectView.h"
#import "LiveJianBaoViewController.h"

@interface OrderDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *statusTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeTipLabel;

//收货地址
@property (weak, nonatomic) IBOutlet UIView *noAddressView;
@property (weak, nonatomic) IBOutlet UIView *hasAddressView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

//商品信息
@property (weak, nonatomic) IBOutlet UIImageView *goodCoverImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *afterSaleTagView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalPayLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNoLabel;
@property (weak, nonatomic) IBOutlet UIStackView *orderInfoStackView;

@property (nonatomic, strong) OrderModel *order;

@property (weak, nonatomic) IBOutlet UIButton *oneButton;
@property (weak, nonatomic) IBOutlet UIButton *twoButton;
@property (weak, nonatomic) IBOutlet UIButton *threeButton;

@property (nonatomic, strong) AddressModel *selectAddress;
@property (nonatomic, strong) NSTimer *timer;

@property (weak, nonatomic) IBOutlet UILabel *goodPriceLabel;
@property (weak, nonatomic) IBOutlet UIView *jianBaoView;
@property (weak, nonatomic) IBOutlet UILabel *jianBaoPriceLabel;
@property (weak, nonatomic) IBOutlet UIView *daiGouView;
@property (weak, nonatomic) IBOutlet UILabel *daiGouPriceLabel;
@property (weak, nonatomic) IBOutlet UIView *couponView;
@property (weak, nonatomic) IBOutlet UILabel *couponPriceLabel;
@property (weak, nonatomic) IBOutlet UIView *kanJiaView;
@property (weak, nonatomic) IBOutlet UILabel *kanJiaPriceLabel;

//直播订单使用
@property (weak, nonatomic) IBOutlet UIView *liveJianBaoView;
@property (weak, nonatomic) IBOutlet UILabel *liveJianBaoPriceLabel;
@property (weak, nonatomic) IBOutlet UIView *liveCouponView;
@property (weak, nonatomic) IBOutlet UILabel *liveCouponPriceLabel;
@property (strong, nonatomic) NSString *liveCouponPrice;
@property (strong, nonatomic) NSString *liveCouponIds;
@property (strong, nonatomic) NSString *liveJianBaoPrice;
@property (assign, nonatomic) BOOL liveJianBao;//YES：开启鉴宝
@property (assign, nonatomic) float totalPay;
@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)dealloc{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

-(void)initControl{
    self.afterSaleTagView.layer.cornerRadius = 2.0;
    self.afterSaleTagView.layer.borderColor = [UIColor colorWithHexString:@"#DC2C2C"].CGColor;
    self.afterSaleTagView.layer.borderWidth = 0.8;
}

-(void)initData{
    self.title = @"订单详情";
    self.timeTipLabel.text = nil;
    
    self.liveJianBaoPrice = @"0";
    self.liveCouponPrice = @"0";
    self.liveJianBao = NO;
    
    [self requestOrderDetail];
}

-(void)refreshOrderDetail{
    if(self.order){
        //订单状态
        [self refreshState];
        //收货地址
        [self refreshAddress];
        
        //商品详情
        [self.goodCoverImageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:self.order.good.coverImage]];
        self.goodTitleLabel.text = self.order.good.title;
        self.priceLabel.text = [NSString stringWithFormat:@"￥%@",self.order.good.price];
        if(self.order.afterSaleState == JMOrderAfterSale_InAudit){
            self.afterSaleTagView.hidden = NO;
        }else{
            self.afterSaleTagView.hidden = YES;
        }
        
        //费用明细
        [self refreshPayInfo];
        
        //时间信息
        self.orderNoLabel.text = [NSString stringWithFormat:@"订单号：%@",self.order.orderNo];
        [self refreshTimeInfo];
        
        //底部操作按钮
        [self refreshBottomButtons];
    }
}

-(void)refreshPayInfo{
    self.goodPriceLabel.text = [NSString stringWithFormat:@"￥%@",self.order.good.price];
    //鉴宝
    if(self.order.orderType.integerValue == 1 && self.order.state == JMOrderState_WaitPay && self.order.haveUpdateMoney == NO){
        //直播订单
        self.liveJianBaoView.hidden = NO;
        self.jianBaoView.hidden = YES;
        if(self.liveJianBao == YES){
            self.liveJianBaoPriceLabel.text = [NSString stringWithFormat:@"￥%@",self.liveJianBaoPrice];
        }else{
            self.liveJianBaoPriceLabel.text = [NSString stringWithFormat:@"￥%@",@"0"];
        }
    }else{
        self.liveJianBaoView.hidden = YES;
        if(self.order.isJianBao == NO){
            self.jianBaoView.hidden = YES;
        }else{
            self.jianBaoPriceLabel.text = [NSString stringWithFormat:@"￥%@",self.order.jianBaoPrice];
        }
    }
    
    //代购
    if(self.order.daiGouPrice.doubleValue > 0){
        self.daiGouPriceLabel.text = [NSString stringWithFormat:@"￥%@",self.order.daiGouPrice];
    }else{
        self.daiGouView.hidden = YES;
    }
    //优惠券
    if(self.order.orderType.integerValue == 1 && self.order.state == JMOrderState_WaitPay && self.order.haveUpdateMoney == NO){
        self.couponView.hidden = YES;
        self.liveCouponView.hidden = NO;
        self.liveCouponPriceLabel.text = [NSString stringWithFormat:@"-￥%@",self.liveCouponPrice];
    }else{
        self.liveCouponView.hidden = YES;
        self.couponView.hidden = NO;
        self.couponPriceLabel.text = [NSString stringWithFormat:@"-￥%@",self.order.couponPrice];
    }
    //砍价
    if(self.order.kanJiaPrice.doubleValue > 0){
        self.kanJiaPriceLabel.text = [NSString stringWithFormat:@"-￥%@",self.order.kanJiaPrice];
    }else{
        self.kanJiaView.hidden = YES;
    }
    
    if(self.order.orderType.integerValue == 1 && self.order.state == JMOrderState_WaitPay){
        //直播
        if(self.liveJianBao == YES){
            float pay = self.order.good.price.doubleValue + self.order.daiGouPrice.doubleValue + self.liveJianBaoPrice.doubleValue - self.liveCouponPrice.doubleValue;
            self.totalPayLabel.text = [NSString stringWithFormat:@"￥%.2f",pay];
            self.totalPay = pay;
        }else{
            float pay = self.order.good.price.doubleValue + self.order.daiGouPrice.doubleValue - self.liveCouponPrice.doubleValue;
            self.totalPayLabel.text = [NSString stringWithFormat:@"￥%.2f",pay];
            self.totalPay = pay;
        }
    }else{
        if(self.order.payType.intValue == 5 && self.order.manyPaySurplusMoney.doubleValue > 0){
            NSString *showMoney = [NSString stringWithFormat:@"￥%@(还需支付￥%@)",self.order.totalPay,self.order.manyPaySurplusMoney];
            NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:showMoney];
            NSInteger totalMoneyLength = self.order.totalPay.length;
            [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ACACAC"] range:NSMakeRange(totalMoneyLength+1, showMoney.length-totalMoneyLength-1)];
            self.totalPayLabel.attributedText = attriStr;
        }else{
            self.totalPayLabel.text = [NSString stringWithFormat:@"￥%@",self.order.totalPay];
            self.totalPay = self.order.totalPay.doubleValue;
        }
    }
}

-(void)refreshState{
    switch (self.order.state) {
        case JMOrderState_Close:
            self.statusTipLabel.text = @"交易关闭";
            self.timeTipLabel.attributedText = nil;
            break;
        case JMOrderState_WaitPay:
            self.statusTipLabel.text = @"等待买家付款";
            //还剩 1天 23小时 自动关闭订单
            [self startTimer];
            [self timeCount];
            break;
        case JMOrderState_WaitFaHuo:
            self.statusTipLabel.text = @"等待商家发货";
            self.timeTipLabel.attributedText = nil;
            break;
        case JMOrderState_WaitShouHuo:
            self.statusTipLabel.text = @"商家已发货";
            //还剩 1天 23小时 自动关闭订单
            [self timeCount];
            break;
        case JMOrderState_TuiKuanSuccess:
            self.statusTipLabel.text = @"退款成功";
            break;
        case JMOrderState_Complete:
        case JMOrderState_WaitEvaluate:
            self.statusTipLabel.text = @"交易成功";
            self.timeTipLabel.attributedText = nil;
            break;
        
        default:
            break;
    }
}

- (void)startTimer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(timeCount) userInfo:nil repeats:YES];
        
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)timeCount{
    NSDate *startTime;
    NSDate *endTime;
    switch (self.order.state) {
        case JMOrderState_WaitPay:
        {
            startTime = [NSDate dateWithString:self.order.createTime format:@"yyyy-MM-dd HH:mm:ss"];
            endTime = [startTime dateByAddingHours:24];
            double seconds = [endTime secondsUntil];
            NSInteger hour = floor(seconds/SECONDS_IN_HOUR);
            NSInteger minute = floor((seconds - hour*SECONDS_IN_HOUR)/SECONDS_IN_MINUTE);
            NSString *showTime = [NSString stringWithFormat:@"还剩 %ld小时%ld分 自动关闭订单",(long)hour,(long)minute];
            NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:showTime];
            [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ED1731"] range:NSMakeRange(3, showTime.length-10)];
            self.timeTipLabel.attributedText = attri;
            break;
        }
        case JMOrderState_WaitShouHuo:
        {
            startTime = [NSDate dateWithString:self.order.faHuoTime format:@"yyyy-MM-dd HH:mm:ss"];
            endTime = [startTime dateByAddingDays:15];
            NSInteger days = [endTime daysUntil];
            NSInteger hours = [endTime hoursUntil] - days*24;
            NSString *showTime = [NSString stringWithFormat:@"还剩 %ld天%ld小时 自动确认收货",(long)days,(long)hours];
            NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:showTime];
            [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ED1731"] range:NSMakeRange(3, showTime.length-10)];
            self.timeTipLabel.attributedText = attri;
            break;
        }
        default:
            break;
    }
}


-(void)refreshAddress{
    BOOL hasAddress = NO;
    if(self.order.address.phone.length > 0){
        hasAddress = YES;
    }
    if(self.order.orderType.integerValue == 1){
        if(self.selectAddress){
            //选择了收货地址
            hasAddress = YES;
        }
    }
    if(hasAddress){
        //有收货地址
        self.hasAddressView.hidden = NO;
        self.noAddressView.hidden = YES;
        if(self.selectAddress){
            self.nameLabel.text = [NSString stringWithFormat:@"收货人：%@",self.selectAddress.name];
            self.phoneLabel.text = self.selectAddress.phone;
            self.addressLabel.text = [NSString stringWithFormat:@"收货地址：%@",[self.selectAddress allAddress]];
        }else{
            self.nameLabel.text = [NSString stringWithFormat:@"收货人：%@",self.order.address.name];
            self.phoneLabel.text = self.order.address.phone;
            self.addressLabel.text = [NSString stringWithFormat:@"收货地址：%@",self.order.address.address];
        }
    }else{
        //没有收货地址
        self.hasAddressView.hidden = YES;
        self.noAddressView.hidden = NO;
        self.nameLabel.text = nil;
        self.phoneLabel.text = nil;
        self.addressLabel.text = nil;
    }
}

-(void)refreshTimeInfo{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    if(self.order.createTime.length > 0){
        [array addObject:[NSString stringWithFormat:@"创建时间：%@",self.order.createTime]];
    }
    if(self.order.payTime.length > 0){
        [array addObject:[NSString stringWithFormat:@"支付时间：%@",self.order.payTime]];
    }
    if(self.order.faHuoTime.length > 0){
        [array addObject:[NSString stringWithFormat:@"发货时间：%@",self.order.faHuoTime]];
    }
    if(self.order.completeTime.length > 0){
        [array addObject:[NSString stringWithFormat:@"收货时间：%@",self.order.completeTime]];
    }
    for(NSString *str in array){
        UILabel *label = [[UILabel alloc] init];
        label.text = str;
        label.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
        label.textColor = [UIColor colorWithHexString:@"#242121"];
        [self.orderInfoStackView addArrangedSubview:label];
    }
}

-(void)refreshBottomButtons{
    NSMutableArray *buttons = [[NSMutableArray alloc] init];
    switch (self.order.state) {
        case JMOrderState_Close:
            [buttons addObject:@"删除订单"];
            break;
        case JMOrderState_WaitPay:
            [buttons addObject:@"付款"];
            break;
        case JMOrderState_WaitFaHuo:
            if(self.order.afterSaleState == JMOrderAfterSale_InAudit){
                
            }else{
                if(self.order.good.refundNum.integerValue == 0){
                    [buttons addObject:@"申请退款"];
                }
            }
            break;
        case JMOrderState_WaitShouHuo:
            if(self.order.afterSaleState == JMOrderAfterSale_InAudit){
                [buttons addObject:@"查看物流"];
            }else{
                [buttons addObject:@"确认收货"];
                [buttons addObject:@"查看物流"];
                if(self.order.good.refundNum.integerValue == 0){
                      [buttons addObject:@"退款"];
                }
              
            }
            break;
        case JMOrderState_Complete:
            [buttons addObject:@"删除订单"];
            [buttons addObject:@"查看评价"];
            [buttons addObject:@"查看物流"];
            break;
        case JMOrderState_WaitEvaluate:
            [buttons addObject:@"评价"];
            [buttons addObject:@"查看物流"];
            break;
            
        default:
            break;
    }
    switch (buttons.count) {
        case 0:
            self.oneButton.hidden = YES;
            self.twoButton.hidden = YES;
            self.threeButton.hidden = YES;
            break;
        case 1:
            self.oneButton.hidden = NO;
            self.twoButton.hidden = YES;
            self.threeButton.hidden = YES;
            break;
        case 2:
            self.oneButton.hidden = NO;
            self.twoButton.hidden = NO;
            self.threeButton.hidden = YES;
            break;
        case 3:
            self.oneButton.hidden = NO;
            self.twoButton.hidden = NO;
            self.threeButton.hidden = NO;
            break;
        default:
            break;
    }
    if(buttons.count >= 1){
        [self.oneButton setTitle:buttons[0] forState:UIControlStateNormal];
    }
    if(buttons.count >= 2){
        [self.twoButton setTitle:buttons[1] forState:UIControlStateNormal];
    }
    if(buttons.count >= 3){
        [self.threeButton setTitle:buttons[2] forState:UIControlStateNormal];
    }
}

#pragma mark - Actions
- (IBAction)choiceAddressAction:(id)sender {
    //添加地址
    if(self.order.orderType.integerValue == 1 && self.order.state == JMOrderState_WaitPay){
        [self goSelectAddressVC];
    }
}

- (IBAction)bottomOperationButtonAction:(id)sender {
    //底部操作按钮
    UIButton *button = (UIButton *)sender;
    NSString *title = button.currentTitle;
    if([title isEqualToString:@"删除订单"]){
        [self deleteOrder];
    }else if([title isEqualToString:@"付款"]){
        [self payOrder];
    }else if([title isEqualToString:@"申请退款"] || [title isEqualToString:@"退款"]){
        [self refundOrder];
    }else if([title isEqualToString:@"查看物流"]){
        [self goLogisticsVC:self.order.orderNo];
    }else if([title isEqualToString:@"确认收货"]){
        [self confirmShouHuo];
    }else if([title isEqualToString:@"查看评价"]){
        [self goEvaluateInfoVC:self.orderId];
    }else if([title isEqualToString:@"评价"]){
        [self goEvaluateVC];
    }
}
- (IBAction)goodDetailAction:(id)sender {
    GoodDetailViewController *detailVC = [[GoodDetailViewController alloc] initWithStoryboardName:@"GoodDetail"];
    detailVC.goodId = self.order.good.goodId;
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(void)deleteOrder{
    ScreenCenterTipView *tipView = [[ScreenCenterTipView alloc] initWithXib];
    tipView.message = @"确定要删除订单？";
    tipView.buttonTitles = @[@"取消",@"确定"];
    [tipView showViewWithDoneBlock:^(NSDictionary * _Nonnull params) {
        NSInteger buttonIndex = [params getJsonValue:@"ButtonIndex"].integerValue;
        if(buttonIndex == 1){
            [self requestDeleteOrder];
        }
    }];
}

-(void)confirmShouHuo{
    ScreenCenterTipView *tipView = [[ScreenCenterTipView alloc] initWithXib];
    tipView.message = @"确认收货之后将不能进行退款/退货，是否确认收货？";
    tipView.buttonTitles = @[@"取消",@"确定"];
    [tipView showViewWithDoneBlock:^(NSDictionary * _Nonnull params) {
        NSInteger buttonIndex = [params getJsonValue:@"ButtonIndex"].integerValue;
        if(buttonIndex == 1){
            [self requestConfirmShouHuo];
        }
    }];
}

-(void)refundOrder{
    ScreenCenterTipView *tipView = [[ScreenCenterTipView alloc] initWithXib];
    tipView.message = @"每个订单只能申请一次退款，未避免审核不通过，请先联系客服协商一致后再申请退款！";
    tipView.buttonTitles = @[@"取消",@"确定"];
    [tipView showViewWithDoneBlock:^(NSDictionary * _Nonnull params) {
        NSInteger buttonIndex = [params getJsonValue:@"ButtonIndex"].integerValue;
        if(buttonIndex == 1){
            if(self.order.state == JMOrderState_WaitFaHuo){
                [self goRefundVC:self.order];
            }else if(self.order.state == JMOrderState_WaitShouHuo){
                [self goRefundAndGoodVC:self.order];
            }
        }
    }];
}

-(void)payOrder{
    if(self.order.orderType.integerValue == 1){
        if(self.selectAddress == nil && self.order.address.phone.length == 0){
            [JMProgressHelper toastInWindowWithMessage:@"请选择收货地址"];
            return;
        }
        [self requestAddressCommit];
    }else{
        [self goPayVC];
    }
}

- (IBAction)customerServiceAction:(id)sender {
    //售后客服
    JMLoginUserModel *loginUser = [JMProjectManager sharedJMProjectManager].loginUser;
    //联系客服
    QYSource *source = [[QYSource alloc] init];
    source.title = loginUser.nickName;
    source.urlString = loginUser.headUrl;
    QiYuCustomServiceController *sessionViewController = [[QiYuCustomServiceController alloc] init];
    sessionViewController.sessionTitle = @"客服";
    sessionViewController.source = source;
    [self.navigationController pushViewController:sessionViewController animated:YES];
//        RCDCustomerServiceViewController *customerVC = [[RCDCustomerServiceViewController alloc] initCustomerService];
//        [self.navigationController pushViewController:customerVC animated:YES];
}

- (IBAction)jianBaoAction:(id)sender {
    //鉴宝
    LiveJianBaoViewController *jianBaoVC = [[LiveJianBaoViewController alloc] initWithStoryboardName:@"Order"];
    jianBaoVC.selectBlock = ^(NSDictionary * _Nonnull params) {
        self.liveJianBaoPrice = [params getJsonValue:@"price"];
        self.liveJianBao = [params getJsonValue:@"isSelect"].boolValue;
        [self refreshPayInfo];
    };
    JMNavigationController *nav = [[JMNavigationController alloc] initWithRootViewController:jianBaoVC];
    nav.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:nav animated:YES completion:nil];
}

- (IBAction)couponAction:(id)sender {
    //优惠券
    GoodCouponSelectView *selectView = [[GoodCouponSelectView alloc] initWithXib];
    selectView.goodId = self.order.good.goodId;
    selectView.roomId = self.order.roomId;
    selectView.goodType = @"1";
    
    [selectView showViewWithDoneBlock:^(NSDictionary *params) {
        self.liveCouponPrice = [params getJsonValue:@"money"];
        self.liveCouponIds = [params getJsonValue:@"ids"];
        [self refreshPayInfo];
    }];
}

#pragma mark - 跳转
-(void)goRefundVC:(OrderModel *)order{
    //仅退款
    RefundViewController *refundVC = [[RefundViewController alloc] initWithStoryboardName:@"Order"];
    refundVC.order = order;
    [self.navigationController pushViewController:refundVC animated:YES];
}

-(void)goRefundAndGoodVC:(OrderModel *)order{
    //退货退款
    RefundAndGoodViewController *refundAndGoodVC = [[RefundAndGoodViewController alloc] initWithStoryboardName:@"Order"];
    refundAndGoodVC.order = order;
    [self.navigationController pushViewController:refundAndGoodVC animated:YES];
}

-(void)goEvaluateVC{
    EvaluateViewController *evaluateVC = [[EvaluateViewController alloc] initWithStoryboardName:@"Order"];
    evaluateVC.good = self.order.good;
    evaluateVC.orderId = self.order.orderId;
    [self.navigationController pushViewController:evaluateVC animated:YES];
}

-(void)goSelectAddressVC{
    AddressListViewController *addressListVC = [[AddressListViewController alloc] initWithStoryboardName:@"Address"];
    addressListVC.selectBlock = ^(AddressModel * _Nonnull address) {
        self.selectAddress = address;
        [self refreshAddress];
    };
    [self.navigationController pushViewController:addressListVC animated:YES];
}

-(void)goPayVC{
    if(self.order.payType.intValue == 5){
        NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
        [params setJsonValue:self.orderId key:@"orderId"];
        [[JMRequestManager sharedManager] POST:kUrlPayManyTimeCreate parameters:params completion:^(JMBaseResponse *response) {
            if(response.error){
                [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
            }else{
                NSDictionary *dataDic = response.responseObject[@"data"];
                self.order.manyTimesPayNo = [dataDic getJsonValue:@"orderNo"];
                [self goManyTimesPay];
            }
        }];
    }else{
        [self goNormalPay];
    }
}

-(void)goManyTimesPay{
    PayManyTimesViewController *payVC = [[PayManyTimesViewController alloc] initWithStoryboardName:@"Pay"];
    payVC.orderNo = self.order.manyTimesPayNo;
    payVC.orderId = self.order.orderId;
    [self.navigationController pushViewController:payVC animated:YES];
}

-(void)goNormalPay{
    PayViewController *payVC = [[PayViewController alloc] initWithStoryboardName:@"Pay"];
    payVC.orderNo = self.order.orderNo;
    payVC.orderId = self.order.orderId;
    payVC.totalPrice =  self.totalPay;
    payVC.inGroup = self.inGroup;
    [self.navigationController pushViewController:payVC animated:YES];
}

-(void)goLogisticsVC:(NSString *)orderNo{
    LogisticsViewController *logisticsVC = [[LogisticsViewController alloc] initWithStoryboardName:@"Logistics"];
    logisticsVC.orderNo = orderNo;
    [self.navigationController pushViewController:logisticsVC animated:YES];
}

- (void)goEvaluateInfoVC:(NSString *)orderId{
    //查看评价详情
    EvaluateListViewController *evaluateListVC = [[EvaluateListViewController alloc] initWithStoryboardName:@"Order"];
    evaluateListVC.orderId = orderId;
    [self.navigationController pushViewController:evaluateListVC animated:YES];
}

#pragma mark - 网络
-(void)requestOrderDetail{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.orderId key:@"orderId"];
    [[JMRequestManager sharedManager] POST:kUrlOrderDetail parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            NSDictionary *dataDic = response.responseObject[@"data"];
            self.order = [[OrderModel alloc] initWithDetailDictionary:dataDic];
            if(self.order.orderType.integerValue == 1){
                self.liveJianBao = self.order.isJianBao;
                self.liveJianBaoPrice = self.order.jianBaoPrice;
                self.liveCouponPrice = self.order.couponPrice;
            }
            [self refreshOrderDetail];
            if(self.order.payType.intValue == 5){
                [self requestManyPayMoney];
            }
        }
    }];
}

-(void)requestDeleteOrder{
    //删除订单
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.order.orderId key:@"orderId"];
    [self showLoading];
    [[JMRequestManager sharedManager] POST:kUrlDeleteOrder parameters:params completion:^(JMBaseResponse *response) {
        [self dismissLoading];
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            [JMProgressHelper toastInWindowWithMessage:response.responseObject[@"desc"]];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

-(void)requestConfirmShouHuo{
    //确认收货
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.order.orderId key:@"orderId"];
    [self showLoading];
    [[JMRequestManager sharedManager] POST:kUrlConfirmShouHuo parameters:params completion:^(JMBaseResponse *response) {
        [self dismissLoading];
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            [JMProgressHelper toastInWindowWithMessage:response.responseObject[@"desc"]];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

-(void)requestAddressCommit{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.order.orderNo key:@"orderNo"];
    [params setJsonValue:self.selectAddress.addressId key:@"addressId"];
    
    if(self.liveJianBao == YES){
        [params setJsonValue:@"YES" key:@"isAppraisal"];
    }else{
        [params setJsonValue:@"NO" key:@"isAppraisal"];
    }
    [params setJsonValue:self.liveCouponIds key:@"couponIds"];
    
    [self showLoading];
    [[JMRequestManager sharedManager] POST:kUrlOrderAddAddress parameters:params completion:^(JMBaseResponse *response) {
        [self dismissLoading];
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            [self goPayVC];
        }
    }];
}

-(void)requestManyPayMoney{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.orderId key:@"orderId"];
    [[JMRequestManager sharedManager] POST:kUrlPayManyHasPay parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            NSDictionary *dic = response.responseObject;
            self.order.manyPaySurplusMoney = [dic getJsonValue:@"data"];
            [self refreshPayInfo];
        }
    }];
}
@end
