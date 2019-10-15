//
//  AfterSaleModel.m
//  JMBaseProject
//
//  Created by Liuny on 2019/7/11.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "AfterSaleModel.h"

@implementation AfterSaleModel
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if(self){
        NSArray *goodList = dict[@"goodsList"];
        NSDictionary *goodDic = goodList.firstObject;
        GoodModel *good = [[GoodModel alloc] init];
        good.goodId = [goodDic getJsonValue:@"goodsId"];
        good.title = [goodDic getJsonValue:@"goodsName"];
        good.coverImage = [goodDic getJsonValue:@"skuImg"];
        good.price = [goodDic getJsonValue:@"price"];
        self.good = good;
        
        
        self.afterSaleId = [dict getJsonValue:@"id"];
        self.money = [dict getJsonValue:@"money"];
        self.afterSaleNo = [dict getJsonValue:@"no"];
        self.applyTime = [dict getJsonValue:@"createTime"];
        self.shenHeTime = [dict getJsonValue:@"auditTime"];
        self.closeTime = [dict getJsonValue:@"closeTime"];
        self.applyReason = [dict getJsonValue:@"reason"];
        self.logisticsNo = [dict getJsonValue:@"logisticsNo"];
        self.refuseReason = [dict getJsonValue:@"refuseReason"];
        self.type = [dict getJsonValue:@"type"];
        NSString *state = [dict getJsonValue:@"state"];
        switch (state.integerValue) {
            case 0://审核中
                self.state = AfterSaleState_InAudit;
                break;
            case 1://已通过等待退款
                self.state = AfterSaleState_Complete;
                break;
            case 2://不通过申请
                self.state = AfterSaleState_AuditFail;
                break;
            case 3://关闭申请
                self.state = AfterSaleState_Close;
                break;
            case 4://完成
                self.state = AfterSaleState_Complete;
                break;
            case 5://通过审核，等待上传物流单号
            case 6://物流单号已上传
                self.state = AfterSaleState_AuditSuccess;
                break;
            case 7://上传物流单号后不通过
                self.state = AfterSaleState_AuditFail;
                break;
            case 8://上传物流单号后通过
                self.state = AfterSaleState_Complete;
                break;
            case 10://超时自动退款
                self.state = AfterSaleState_Complete;
                break;
            
                
            default:
                break;
        }
        
        //图片
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for(int i=0;i<6;i++){
            NSString *key = [NSString stringWithFormat:@"img%d",i+1];
            NSString *image = [dict getJsonValue:key];
            if(image.length > 0){
                [array addObject:image];
            }
        }
        self.applyPicturesArray = array;
        
    }
    return self;
}
@end
