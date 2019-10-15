//
//  UCBindPhoneViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/25.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "UCBindPhoneViewController.h"
#import "UCCheckOldPhoneViewController.h"

@interface UCBindPhoneViewController ()
@property (weak, nonatomic) IBOutlet UILabel *showPhoneLabel;

@end

@implementation UCBindPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initControl{
    
}

-(void)initData{
    self.title = @"绑定手机";
    
    JMLoginUserModel *loginUser = [JMProjectManager sharedJMProjectManager].loginUser;
    self.showPhoneLabel.text = [NSString stringWithFormat:@"您已绑定手机号：+86  %@",loginUser.mobile];
}

#pragma mark - Actions
- (IBAction)changeAction:(id)sender {
    UCCheckOldPhoneViewController *checkOldVC = [[UCCheckOldPhoneViewController alloc] initWithStoryboardName:@"UserCenter"];
    [self.navigationController pushViewController:checkOldVC animated:YES];
}


@end
