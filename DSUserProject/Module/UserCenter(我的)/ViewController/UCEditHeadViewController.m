//
//  UCEditHeadViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/7/4.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "UCEditHeadViewController.h"
#import "JMPickPhotoTool.h"

@interface UCEditHeadViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@end

@implementation UCEditHeadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initControl{

}

-(void)initData{
    self.title = @"我的头像";
    
    JMLoginUserModel *loginUser = [JMProjectManager sharedJMProjectManager].loginUser;
    [self.headImageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:loginUser.headUrl]];
}

#pragma mark - Navigation
-(UIImage *)jmNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(JMNavigationBar *)navigationBar{
    [JMCommonMethod navigationItemSet:rightButton fontColor:[UIColor whiteColor]];
    [rightButton setTitle:@"修改" forState:UIControlStateNormal];
    return nil;
}

-(void)rightButtonEvent:(UIButton *)sender navigationBar:(JMNavigationBar *)navigationBar{
    
    [JMPickPhotoTool startCustomPickPhotodoneBlock:^(NSArray<UIImage *> *pickImage) {
        UIImage *image = pickImage.firstObject;
        [self requestUpdateHead:image];
    }];

}

#pragma mark - 网络
-(void)requestUpdateHead:(UIImage *)image{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [[JMRequestManager sharedManager] upload:kUrlUploadHead parameters:params formDataBlock:^NSDictionary<NSData *,JMDataName *> *(id<AFMultipartFormData> formData, NSMutableDictionary<NSData *,JMDataName *> *needFillDataDict) {
        needFillDataDict[UIImageJPEGRepresentation(image, 0.3)] = @"head-image.jpg";
        return needFillDataDict;
    } progress:nil completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            [[JMProjectManager sharedJMProjectManager] updateLoginUserInfoSuccessBlock:^{
                [JMProgressHelper toastInWindowWithMessage:@"修改头像成功"];
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserUpdateHead object:nil];
                JMLoginUserModel *loginUser = [JMProjectManager sharedJMProjectManager].loginUser;
                [self.headImageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:loginUser.headUrl]];
            } failBlock:nil];
        }
    }];
}
@end
