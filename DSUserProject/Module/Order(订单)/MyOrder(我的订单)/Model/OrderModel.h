//
//  OrderModel.h
//  JMBaseProject
//
//  Created by Liuny on 2019/4/24.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//订单状态
typedef enum : NSInteger {
    JMOrderState_WaitPay = 0,   //未支付，待付款
    JMOrderState_WaitFaHuo = 2,     //已支付，待发货
    JMOrderState_WaitShouHuo = 7,   //已发货,待收货
    JMOrderState_WaitEvaluate = 8,  //待评价
    JMOrderState_TuiKuanSuccess = 5,  //退款成功
    JMOrderState_Close = 6,         //取消订单（交易关闭)
    JMOrderState_Complete = 9,      //已完成
}JMOrderState;

typedef enum : NSInteger {
    JMOrderAfterSale_No = 0,    //没有售后
    JMOrderAfterSale_InAudit,   //审核中
    JMOrderAfterSale_Success,
    JMOrderAfterSale_Fail,
}JMOrderAfterSale;

@interface OrderModel : NSObject
@property (nonatomic, assign) JMOrderState state;
@property (nonatomic, assign) JMOrderAfterSale afterSaleState;

@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *orderNo;                      //订单号
@property (nonatomic, strong) AddressModel *address;                //收货地址
@property (nonatomic, strong) GoodModel *good;
@property (nonatomic, copy) NSString *totalPay;
//时间
@property (nonatomic, copy) NSString *createTime;                    //下单时间
@property (nonatomic, copy) NSString *payTime;                       //支付时间
@property (nonatomic, copy) NSString *faHuoTime;                     //发货时间
@property (nonatomic, copy) NSString *evaluateTime;                  //评价时间
@property (nonatomic, copy) NSString *completeTime;                  //完成时间
@property (nonatomic, copy) NSString *orderType;//0:商城 1:直播
@property (nonatomic, copy) NSString *roomId;

//退款
@property (nonatomic, copy) NSString *afterSaleNo;                  //售后单号
@property (nonatomic, copy) NSString *applyAfterSaleTime;           //申请售后的时间
@property (nonatomic, copy) NSString *applyAfterSaleReason;         //申请售后的原因

//服务+优惠
@property (nonatomic, assign) BOOL isJianBao;//是否有鉴宝服务
@property (nonatomic, copy) NSString *jianBaoPrice;
@property (nonatomic, copy) NSString *daiGouPrice;//代购
@property (nonatomic, copy) NSString *couponPrice;//优惠券
@property (nonatomic, copy) NSString *kanJiaPrice;//砍价
@property (nonatomic, assign) BOOL haveUpdateMoney;//是否更新过金额0否1是(使用过优惠券或者鉴定宝)

//支付
@property (nonatomic, copy) NSString *payType;//5分次支付 0支付宝1微信2余额4银行卡支付
@property (nonatomic, copy) NSString *manyPaySurplusMoney;//多次支付剩余应付金额
@property (nonatomic, copy) NSString *manyTimesPayNo;//多次支付订单号


-(instancetype)initWithOrderListDictionary:(NSDictionary *)dict;
-(instancetype)initWithDetailDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
