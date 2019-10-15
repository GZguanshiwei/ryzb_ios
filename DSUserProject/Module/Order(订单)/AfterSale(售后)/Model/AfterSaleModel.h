//
//  AfterSaleModel.h
//  JMBaseProject
//
//  Created by Liuny on 2019/7/11.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSInteger {
    AfterSaleState_InAudit = 0,   //审核中
    AfterSaleState_AuditSuccess,   //审核通过
    AfterSaleState_AuditFail,   //审核不通过
    AfterSaleState_Close,       //关闭（自己主动关闭）
    AfterSaleState_Complete,      //退货退款成功
}AfterSaleState;

@interface AfterSaleModel : NSObject

@property (nonatomic, copy) NSString *afterSaleId;
@property (nonatomic, copy) NSString *afterSaleNo;                  //售后单号
@property (nonatomic, strong) GoodModel *good;
@property (nonatomic, copy) NSString *type;//0:仅退款 1:退货退款 2:退货退款，未收到货
@property (nonatomic, assign) AfterSaleState state;
@property (nonatomic, copy) NSString *money;//退款金额
@property (nonatomic, copy) NSString *logisticsNo;      //物流单号

@property (nonatomic, copy) NSString *applyTime;           //申请售后的时间
@property (nonatomic, strong) NSArray *applyPicturesArray;
@property (nonatomic, copy) NSString *applyReason;         //申请售后的原因
@property (nonatomic, copy) NSString *refuseReason;         //拒绝原因
@property (nonatomic, copy) NSString *shenHeTime;       //审核时间
@property (nonatomic, copy) NSString *closeTime;         //关闭时间


-(instancetype)initWithDictionary:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
