//
//  OrderModel.m
//  JMBaseProject
//
//  Created by Liuny on 2019/4/24.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

-(instancetype)initWithOrderListDictionary:(NSDictionary *)dict{
    self = [super init];
    if(self){
        AddressModel *address = [[AddressModel alloc] init];
        address.phone = [dict getJsonValue:@"addressPhone"];
        address.name = [dict getJsonValue:@"addressName"];
        address.address = [dict getJsonValue:@"address"];
        self.address = address;
        
        self.orderId = [dict getJsonValue:@"id"];
        self.orderNo = [dict getJsonValue:@"orderNo"];
        self.totalPay = [dict getJsonValue:@"money"];
        
        NSArray *goodList = dict[@"goodsList"];
        NSDictionary *goodDic = goodList.firstObject;
        GoodModel *good = [[GoodModel alloc] init];
        good.goodId = [goodDic getJsonValue:@"goodsId"];
        good.title = [goodDic getJsonValue:@"goodsName"];
        good.coverImage = [goodDic getJsonValue:@"skuImg"];
//        good.price = [goodDic getJsonValue:@"price"];
        good.price = [dict getJsonValue:@"originalPrice"];
        good.afterSaleId = [goodDic getJsonValue:@"id"];
        good.refundNum = [goodDic getJsonValue:@"refundNum"];
        self.good = good;
        
        self.state = [dict getJsonValue:@"state"].integerValue;
        //0:未支付 1:正在支付中 2:已支付 3:支付失败 4:正在退款中 5:已退款 6:取消订单 7:已发货 8:确认收货待评价 9:已评价完成 10:售后关闭
        if(self.state == 3 || self.state == 1){
            self.state = JMOrderState_WaitPay;
        }
        
        self.afterSaleState = [dict getJsonValue:@"refundState"].integerValue;
        
        self.daiGouPrice = [dict getJsonValue:@"helpPrice"];
        NSString *isJianBao = [dict getJsonValue:@"isAppraisal"];
        self.isJianBao = [isJianBao isEqualToString:@"YES"];
        self.jianBaoPrice = [dict getJsonValue:@"appraisalPrice"];
        self.couponPrice = [dict getJsonValue:@"couponPrice"];
        self.kanJiaPrice = [dict getJsonValue:@"bargainPrice"];
        
        self.payType = [dict getJsonValue:@"payType"];
        self.orderType = [dict getJsonValue:@"orderType"];
        self.roomId = [dict getJsonValue:@"roomId"];
    }
    return self;
}


-(instancetype)initWithDetailDictionary:(NSDictionary *)dict{
    self = [self initWithOrderListDictionary:dict];
    if(self){
        self.createTime = [dict getJsonValue:@"createTime"];
        self.payTime = [dict getJsonValue:@"payTime"];
        self.faHuoTime = [dict getJsonValue:@"sendTime"];
        self.evaluateTime = [dict getJsonValue:@""];
        self.completeTime = [dict getJsonValue:@"finishTime"];
        self.haveUpdateMoney = [dict getJsonValue:@"haveUpdateMoney"].boolValue;
    }
    return self;
}

@end
