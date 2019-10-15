//
//  IntegralMallListController.m
//  JMBaseProject
//
//  Created by 潘传标 on 2019/9/6.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "IntegralMallViewController.h"

@interface IntegralMallViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *lineView;
@property (weak, nonatomic) IBOutlet UIButton *intralButton;
@property (weak, nonatomic) IBOutlet UIButton *exchangeButton;

@property (weak, nonatomic) IBOutlet UIView *exchangeView;
@property (weak, nonatomic) IBOutlet UIView *mallView;


@end

@implementation IntegralMallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initControl
{
    self.title = @"积分商城";
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)initData{
    
}


- (IBAction)selectButtonClick:(UIButton *)sender {
    self.intralButton.selected = NO;
    self.exchangeButton.selected = NO;
    UIButton *selectButton;
    switch (sender.tag) {
        case 0:
            [self.view bringSubviewToFront:self.mallView];
            selectButton = self.intralButton;
            break;
        case 1:
            [self.view bringSubviewToFront:self.exchangeView];
            selectButton = self.exchangeButton;
            break;
        default:
            break;
    }
    selectButton.selected = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.lineView.frame = CGRectMake((self.intralButton.mj_w - self.lineView.mj_w) * 0.5 + self.intralButton.mj_w * sender.tag, self.lineView.mj_y, self.lineView.mj_w, self.lineView.mj_h);
    }];
  
}

@end
