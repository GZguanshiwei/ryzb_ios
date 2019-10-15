//
//  AlertCenterView.h
//  JMBaseProject
//
//  Created by 潘传标 on 2019/9/5.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^AlertViewConfirmBlock)(NSInteger tag);
@interface AlertCenterView : UIView
@property(nonatomic,copy)AlertViewConfirmBlock  confirmAlertBlock;
+(void)showWithMessage:(NSString *)message  andLeftBlock:(void(^)(void))lefthandle andRightBlock:(void(^)(void))rightHandle;
@end

NS_ASSUME_NONNULL_END
