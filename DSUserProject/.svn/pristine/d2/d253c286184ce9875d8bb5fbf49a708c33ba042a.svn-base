//
//  AddCashAccountView.h
//  JMBaseProject
//
//  Created by 潘传标 on 2019/9/7.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AddCashAccountViewType) {
    AddCashAccountViewTypeWeChat, //微信
    AddCashAccountViewTypePay,  //支付宝
    AddCashAccountViewTypeCard  // 银行卡
};
typedef void (^AddCashAccountConfirmBlock)(NSDictionary *data);
@interface AddCashAccountView : UIView
@property(nonatomic,copy)AddCashAccountConfirmBlock  confirmBlock;
+(void)addCashAccountWithHandle:(void(^)(NSDictionary *dataDic))sureHandle;
@end


