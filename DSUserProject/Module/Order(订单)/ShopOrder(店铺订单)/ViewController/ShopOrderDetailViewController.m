//
//  ShopOrderDetailViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/27.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "ShopOrderDetailViewController.h"
#import "OrderModel.h"
#import "LogisticsViewController.h"
#import "GoodDetailViewController.h"
#import <DateTools.h>

@interface ShopOrderDetailViewController ()
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

@end

@implementation ShopOrderDetailViewController

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
    if(self.order.isJianBao == NO){
        self.jianBaoView.hidden = YES;
    }else{
        self.jianBaoPriceLabel.text = [NSString stringWithFormat:@"￥%@",self.order.jianBaoPrice];
    }
    //代购
    if(self.order.daiGouPrice.doubleValue > 0){
        self.daiGouPriceLabel.text = [NSString stringWithFormat:@"￥%@",self.order.daiGouPrice];
    }else{
        self.daiGouView.hidden = YES;
    }
    //优惠券
    self.couponPriceLabel.text = [NSString stringWithFormat:@"-￥%@",self.order.couponPrice];
    //砍价
    if(self.order.kanJiaPrice.doubleValue > 0){
        self.kanJiaPriceLabel.text = [NSString stringWithFormat:@"-￥%@",self.order.kanJiaPrice];
    }else{
        self.kanJiaView.hidden = YES;
    }
    
    if(self.order.payType.intValue == 5 && self.order.manyPaySurplusMoney.doubleValue > 0){
        NSString *showMoney = [NSString stringWithFormat:@"￥%@(还需支付￥%@)",self.order.totalPay,self.order.manyPaySurplusMoney];
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:showMoney];
        NSInteger totalMoneyLength = self.order.totalPay.length;
        [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ACACAC"] range:NSMakeRange(totalMoneyLength+1, showMoney.length-totalMoneyLength-1)];
        self.totalPayLabel.attributedText = attriStr;
    }else{
        self.totalPayLabel.text = [NSString stringWithFormat:@"￥%@",self.order.totalPay];
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
    if(self.order.address.phone.length == 0){
        hasAddress = NO;
    }else{
        hasAddress = YES;
    }
    if(hasAddress){
        //有收货地址
        self.hasAddressView.hidden = NO;
        self.noAddressView.hidden = YES;
        self.nameLabel.text = [NSString stringWithFormat:@"收货人：%@",self.order.address.name];
        self.phoneLabel.text = self.order.address.phone;
        self.addressLabel.text = [NSString stringWithFormat:@"收货地址：%@",self.order.address.address];
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
            break;
        case JMOrderState_WaitPay:
            break;
        case JMOrderState_TuiKuanSuccess:
            break;
        case JMOrderState_Complete:
            [buttons addObject:@"查看物流"];
            break;
        case JMOrderState_WaitFaHuo:
            break;
        case JMOrderState_WaitShouHuo:
            [buttons addObject:@"查看物流"];
            break;
        case JMOrderState_WaitEvaluate:
            [buttons addObject:@"查看物流"];
            break;
        default:
            break;
    }
    if(buttons.count > 0){
        self.oneButton.hidden = NO;
        [self.oneButton setTitle:buttons.firstObject forState:UIControlStateNormal];
    }else{
        self.oneButton.hidden = YES;
    }
}

#pragma mark - Actions

- (IBAction)bottomOperationButtonAction:(id)sender {
    //查看物流
    [self goLogisticsVC:self.order.orderNo];
}

- (IBAction)goodDetailAction:(id)sender {
    GoodDetailViewController *detailVC = [[GoodDetailViewController alloc] initWithStoryboardName:@"GoodDetail"];
    detailVC.goodId = self.order.good.goodId;
    [self.navigationController pushViewController:detailVC animated:YES];
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

#pragma mark - 跳转
-(void)goLogisticsVC:(NSString *)orderNo{
    LogisticsViewController *logisticsVC = [[LogisticsViewController alloc] initWithStoryboardName:@"Logistics"];
    logisticsVC.orderNo = orderNo;
    [self.navigationController pushViewController:logisticsVC animated:YES];
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
            [self refreshOrderDetail];
            if(self.order.payType.intValue == 5){
                [self requestManyPayMoney];
            }
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
