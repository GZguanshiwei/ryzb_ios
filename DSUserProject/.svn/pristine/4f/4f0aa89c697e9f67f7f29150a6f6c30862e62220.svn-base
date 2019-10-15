//
//  AlertCenterView.m
//  JMBaseProject
//
//  Created by 潘传标 on 2019/9/5.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "AlertCenterView.h"
@interface AlertCenterView()


@property (weak, nonatomic) IBOutlet UILabel *messageLable;

@end
@implementation AlertCenterView


+(void)showWithMessage:(NSString *)message  andLeftBlock:(void(^)(void))lefthandle andRightBlock:(void(^)(void))rightHandle
{
    AlertCenterView *alertView =   [[self alloc] init];
    alertView.messageLable.text = message;
    alertView.frame = [UIScreen mainScreen].bounds;
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
    alertView.confirmAlertBlock = ^(NSInteger tag) {
        if (tag == 1) {
            if (rightHandle) {
                rightHandle();
            }
        }else
        {
            if (lefthandle) {
                lefthandle();
            }
        }
    };
    
    
}

- (IBAction)selectButtonClick:(UIButton *)sender {
    
  if (self.confirmAlertBlock) {
            self.confirmAlertBlock(sender.tag);
        }
    [self removeFromSuperview];
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"AlertCenterView" owner:nil options:nil] lastObject];
    }
    return self;
}
@end
