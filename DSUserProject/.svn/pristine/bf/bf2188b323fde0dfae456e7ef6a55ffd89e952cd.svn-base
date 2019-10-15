//
//  ShareImageViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/9/26.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "ShareImageViewController.h"

@interface ShareImageViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (strong, nonatomic) NSString *shareUrl;
@end

@implementation ShareImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initControl{
    ViewRadius(self.mainView, 8.0);
}

-(void)initData{
    self.nameLabel.text = self.good.title;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",self.good.price];
    [self.coverImageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:self.good.coverImage] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        //加载完就截图
        UIImage *screenImage = [self.view snapshotImage];
        [self shareImage:screenImage];
    }];
    
}

#pragma mark - UINavigation
-(BOOL)navUIBaseViewControllerIsNeedNavBar:(JMNavUIBaseViewController *)navUIBaseViewController{
    return NO;
}

#pragma mark - 网络
- (void)requestGetGoodsResaleShareUrl:(UIImage *)thumbImage{
    //获取转售分享链接
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.good.goodsResaleId key:@"goodsResaleId"];
    [[JMRequestManager sharedManager] POST:kUrlGetGoodsResaleShareUrl parameters:params completion:^(JMBaseResponse *response) {
        if (response.error) {
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            self.shareUrl = response.responseObject[@"data"];
            //分享到微信朋友圈
            [JMUMengHelper shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine shareTitle:self.good.title subTitle:self.content thumbImage:thumbImage shareURL:self.shareUrl];
            [self.view removeFromSuperview];
        }
    }];
}

-(void)shareImage:(UIImage *)image{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    shareObject.title = self.good.resaleContent;
    [shareObject setShareImage:image];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatTimeLine messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        [self.view removeFromSuperview];
        if (error) {
            JMLog(@"************Share fail with error %@*********",error);
        }else{
            JMLog(@"response data is %@",data);
        }
    }];
}

@end
