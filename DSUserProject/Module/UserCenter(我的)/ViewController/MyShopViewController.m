//
//  MyShopViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/26.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "MyShopViewController.h"
#import "ShareTipView.h"
#import "ShopOrderViewController.h"
#import "MyShopEditPhoneViewController.h"

@interface MyShopViewController ()
@property (weak, nonatomic) IBOutlet UILabel *showPhoneLabel;

@end

@implementation MyShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initControl{
    
}

-(void)initData{
    self.title = @"我的店铺";
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    JMLoginUserModel *loginUser = [JMProjectManager sharedJMProjectManager].loginUser;
    self.showPhoneLabel.text = loginUser.shopMobile;
}

#pragma mark - Actions
- (IBAction)previewShopAction:(id)sender {
    //预览店铺
    [self requestGetShopShareUrl];
}

- (IBAction)shareAction:(id)sender {
    //分享
    ShareTipView *shareTipView = [[ShareTipView alloc] initWithXib];
    JMLoginUserModel *loginUser = [JMProjectManager sharedJMProjectManager].loginUser;
    shareTipView.title = loginUser.nickName;
    shareTipView.subtitle = @"推荐这家店铺，支持担保交易";
    shareTipView.image = loginUser.headUrl;
    [shareTipView showShareWithType:Share_Shop requestIds:nil];
}

- (IBAction)allOrderAction:(id)sender {
    [self goOrderVCWithType:0];
}

- (IBAction)orderWithStatusAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    [self goOrderVCWithType:button.tag];
}

- (IBAction)editPhoneAction:(id)sender {
    MyShopEditPhoneViewController *editPhoneVC = [[MyShopEditPhoneViewController alloc] initWithStoryboardName:@"UserCenter"];
    [self.navigationController pushViewController:editPhoneVC animated:YES];
}

#pragma mark - 跳转
-(void)goOrderVCWithType:(NSInteger)type{
    ShopOrderViewController *orderVC = [[ShopOrderViewController alloc] initWithStoryboardName:@"ShopOrder"];
    orderVC.selectIndex = type;
    [self.navigationController pushViewController:orderVC animated:YES];
}

- (void)requestGetShopShareUrl{
    //获取店铺分享链接
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [[JMRequestManager sharedManager] POST:kUrlGetShopShareUrl parameters:params completion:^(JMBaseResponse *response) {
        if (response.error) {
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            NSString *shareUrl = response.responseObject[@"data"];
            //跳转外链
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:shareUrl]]) {
                // 跳转到店铺分享链接
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:shareUrl]];
            }
        }
    }];
}

@end
