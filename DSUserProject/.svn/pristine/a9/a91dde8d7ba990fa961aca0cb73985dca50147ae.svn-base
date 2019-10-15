//
//  MyCouponDetailController.m
//  JMBaseProject
//
//  Created by 潘传标 on 2019/9/6.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "MyCouponDetailController.h"

@interface MyCouponDetailController ()
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLevelLabel;
@property (weak, nonatomic) IBOutlet UIButton *useButton;

@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *instructionLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@end

@implementation MyCouponDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initControl{
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)initData{
    self.nameLabel.text = self.couponData.name;
    self.instructionLabel.text = [self.couponData instructionsText];
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%@",self.couponData.deductionPrice];
    self.endTimeLabel.text = self.couponData.overTime;
    self.moneyLevelLabel.text = [NSString stringWithFormat:@"满%@可用",self.couponData.restrictPrice];
    self.tipLabel.text = self.couponData.tips;
    
    self.useButton.enabled = self.canUse;
}

#pragma mark - UINavigation
-(BOOL)navUIBaseViewControllerIsNeedNavBar:(JMNavUIBaseViewController *)navUIBaseViewController{
    return NO;
}

- (IBAction)backButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 立即使用
- (IBAction)userButtonClick:(id)sender {
    switch (self.couponData.type.integerValue) {
        case 0://0商家使用1直播间使用2全部可用
            [self goHomeWithType:@"1"];
            break;
        case 1:
            if(self.couponData.roomId.length > 0){
                [self enterLive:self.couponData.roomId];
            }else{
                [self goHomeWithType:@"0"];
            }
            break;
        case 2:
            [self goHomeWithType:@"0"];
            break;
        default:
            break;
    }
}

-(void)enterLive:(NSString *)roomId{
    [[JMProjectManager sharedJMProjectManager] enterRoom:roomId];
}

-(void)goHomeWithType:(NSString *)type{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationMarketTypeChange object:type];
    self.tabBarController.selectedIndex = 0;
    [self.navigationController popToRootViewControllerAnimated:NO];
}

@end
