//
//  UCInviteViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/25.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "UCInviteViewController.h"
#import "ShareTipView.h"
#import "QRCode.h"

@interface UCInviteViewController ()
@property (weak, nonatomic) IBOutlet UIView *scrollContentView;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIImageView *qrCodeImageView;

@end

@implementation UCInviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initControl{
    self.view.backgroundColor = kColorMain;
    self.scrollContentView.backgroundColor = kColorMain;
}

-(void)initData{
    NSString *tip = @"邀请好友拿返利，注册即领9折券";
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:tip];
    UIColor *color = [UIColor colorWithHexString:@"#FFD200"];
    [attriStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(attriStr.length-3, 3)];
    self.tipLabel.attributedText = attriStr;
    
    [self requestGetInviteUrl];
}

#pragma mark - Navigation
-(UIColor *)jmNavigationBackgroundColor:(JMNavigationBar *)navigationBar{
    return [UIColor clearColor];
}

#pragma mark - Actions
- (IBAction)shareAction:(id)sender {
    //分享
    ShareTipView *shareTipView = [[ShareTipView alloc] initWithXib];
    [shareTipView showShareWithType:Share_Invite requestIds:nil];
}

#pragma mark - 网络
-(void)requestGetInviteUrl{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [self showLoading];
    [[JMRequestManager sharedManager] POST:kUrlInviteUrl parameters:params completion:^(JMBaseResponse *response) {
        [self dismissLoading];
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            NSString *url = response.responseObject[@"data"];
            UIImage *image = [QRCode generateImageWithQrCode:url QrCodeImageSize:self.qrCodeImageView.mj_w];
            self.qrCodeImageView.image = image;
        }
    }];
}

@end
