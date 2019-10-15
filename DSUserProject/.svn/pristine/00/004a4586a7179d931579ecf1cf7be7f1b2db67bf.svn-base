//
//  ChoiceAddressView.h
//  JMBaseProject
//
//  Created by 潘传标 on 2019/9/7.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class AddressModel;
@interface ChoiceAddressView : UIView
typedef void (^AddressConfirmBlock)(AddressModel * model);
@property(nonatomic,copy)AddressConfirmBlock  confirmAlertBlock;
+(void)showWithSelectCoyponBlock:(void(^)(AddressModel *model))selectModel;
@end

NS_ASSUME_NONNULL_END
