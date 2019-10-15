//
//  DSCounpAlerView.m
//  JMBaseProject
//
//  Created by 潘传标 on 2019/9/3.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "DSCounpAlerView.h"
@interface DSCounpAlerView()

@property (weak, nonatomic) IBOutlet UILabel *moneyLable;
@property (weak, nonatomic) IBOutlet UILabel *coditionLable;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;

@end
@implementation DSCounpAlerView


-(void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.frame = [UIScreen mainScreen].bounds;

    self.moneyLable.text = [NSString stringWithFormat:@"￥%@",self.couponData.deductionPrice];
    self.coditionLable.text = [NSString stringWithFormat:@"满%@可用",self.couponData.restrictPrice];
    self.timeLable.text = [NSString stringWithFormat:@"有效期至%@",self.couponData.overTime];
    self.titleLable.text = self.couponData.name;
}

- (IBAction)checkButtonClick:(id)sender {
    if (self.checkButtonBlock) {
        self.checkButtonBlock();
    }
    [self removeFromSuperview];
}

- (IBAction)deleteButtonClick:(id)sender {
    [self removeFromSuperview];
}

@end
