//
//  ShareTipView.m
//  JMBaseProject
//
//  Created by Liuny on 2019/1/4.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "ShareTipView.h"

@interface ShareTipView ()
@property (nonatomic, strong) NSString *shareUrl;

//请求分享链接需要用到的参数
@property (nonatomic, copy) NSString *requestIds;
@property (nonatomic, assign) Share_Type type;
@end

@implementation ShareTipView


-(void)showShareWithType:(Share_Type)type requestIds:(NSString *)requestIds{
    self.type = type;
    self.requestIds = requestIds;
    switch (type) {
        case Share_Invite:
            [self requestGetInviteFriendsShareUrl];
            break;
        case Share_Resale:
            [self requestGetGoodsResaleShareUrl];
            break;
        case Share_Bargain:
            [self requestKanJiaShareUrl];
            break;
        case Share_Shop:
            [self requestGetShopShareUrl];
            break;
        case Share_Live:
            [self requestSelectRoomShareUrl];
            break;
        default:
            break;
    }
}


- (IBAction)shareTypeAction:(id)sender {
    if(self.buttonClickBlock){
        UIButton *button = (UIButton *)sender;
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setJsonValue:[NSString stringWithFormat:@"%ld",(long)button.tag] key:@"ButtonIndex"];
        self.buttonClickBlock(params);
    }
    
    UIButton *button = (UIButton *)sender;
    switch (button.tag) {
        case 0:
            // 微信
            [JMUMengHelper shareWebPageToPlatformType:UMSocialPlatformType_WechatSession shareTitle:self.title subTitle:self.subtitle thumbImage:self.image shareURL:self.shareUrl];
            break;
        case 1:
            // 新浪微博
            [JMUMengHelper shareWebPageToPlatformType:UMSocialPlatformType_Sina shareTitle:self.title subTitle:self.subtitle thumbImage:self.image shareURL:self.shareUrl];
            break;
        case 2:
            // QQ
            [JMUMengHelper shareWebPageToPlatformType:UMSocialPlatformType_QQ shareTitle:self.title subTitle:self.subtitle thumbImage:self.image shareURL:self.shareUrl];
            break;
        case 3:
            // QQ空间
            [JMUMengHelper shareWebPageToPlatformType:UMSocialPlatformType_Qzone shareTitle:self.title subTitle:self.subtitle thumbImage:self.image shareURL:self.shareUrl];
            break;
        case 4:
            // QQ空间
            [JMUMengHelper shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine shareTitle:self.title subTitle:self.subtitle thumbImage:self.image shareURL:self.shareUrl];
            break;
        case 5:
        {
            // 复制链接
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            switch (self.type) {
                case Share_Live:
                    pasteboard.string = [NSString stringWithFormat:@"%@”%@“",self.title,self.shareUrl];;
                    break;
                    
                default:
                    pasteboard.string = self.shareUrl;
                    break;
            }
            
            [JMProgressHelper toastInWindowWithMessage:@"复制成功"];
        }
            break;
        default:
            break;
    }
    
    if(self.type == Share_Live){
        [self requestGetIronShareValue];
    }
    
    [self hideWithAnmation:YES];
}


- (IBAction)cancelAction:(id)sender {
    [self hideWithAnmation:YES];
}




- (void)requestGetInviteFriendsShareUrl{
    //获取邀请好友链接
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [[JMRequestManager sharedManager] POST:kUrlGetInviteFriendsShareUrl parameters:params completion:^(JMBaseResponse *response) {
        if (response.error) {
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            self.shareUrl = response.responseObject[@"data"];
            JMLoginUserModel *loginUser = [JMProjectManager sharedJMProjectManager].loginUser;
            self.title = [NSString stringWithFormat:@"“%@”邀你下载容妍珠宝",loginUser.nickName];
            self.subtitle = @"源头翡翠批发市场，精品翡翠放心买。";
            self.image = [UIImage imageNamed:@"icon.png"];
            [self showViewWithDoneBlock:nil];
        }
    }];
}

- (void)requestGetGoodsResaleShareUrl{
    //获取转售分享链接
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.requestIds key:@"goodsResaleId"];
    [[JMRequestManager sharedManager] POST:kUrlGetGoodsResaleShareUrl parameters:params completion:^(JMBaseResponse *response) {
        if (response.error) {
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            self.shareUrl = response.responseObject[@"data"];
            [self showViewWithDoneBlock:nil];
        }
    }];
}

- (void)requestGetShopShareUrl{
    //获取店铺分享链接
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [[JMRequestManager sharedManager] POST:kUrlGetShopShareUrl parameters:params completion:^(JMBaseResponse *response) {
        if (response.error) {
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            self.shareUrl = response.responseObject[@"data"];
            [self showViewWithDoneBlock:nil];
        }
    }];
}

- (void)requestSelectRoomShareUrl {
    //获取直播间分享地址
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.requestIds key:@"roomId"];
    [[JMRequestManager sharedManager] POST:kUrlSelectRoomShareUrl parameters:params completion:^(JMBaseResponse *response) {
        if (response.error) {
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            self.shareUrl = response.responseObject[@"data"];
            [self showViewWithDoneBlock:nil];
        }
    }];
}

-(void)requestKanJiaShareUrl{
    //获取砍价分享链接
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.requestIds key:@"bargainId"];
    [[JMRequestManager sharedManager] POST:kUrlKanJiaShareUrl parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            self.shareUrl = response.responseObject[@"data"];
            [self showViewWithDoneBlock:nil];
        }
    }];
}

-(void)requestGetIronShareValue{
    //分享直播间获取铁值
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.requestIds key:@"roomId"];
    [params setJsonValue:@"3" key:@"type"];
    [[JMRequestManager sharedManager] POST:kUrlLiveIron parameters:params completion:^(JMBaseResponse *response) {
        
    }];
}
@end
