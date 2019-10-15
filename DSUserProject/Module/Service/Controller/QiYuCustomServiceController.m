//
//  QiYuCustomServiceController.m
//  JMBaseProject
//
//  Created by 潘传标 on 2019/8/8.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "QiYuCustomServiceController.h"

@interface QiYuCustomServiceController ()

@end

@implementation QiYuCustomServiceController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgationController];
    JMLoginUserModel *loginUser = [JMProjectManager sharedJMProjectManager].loginUser;
    [[QYSDK sharedSDK] customUIConfig].customerHeadImageUrl = loginUser.headUrl;

    QYUserInfo *userInfo = [[QYUserInfo alloc] init];
    userInfo.userId = loginUser.userId;
    NSDictionary * nameDic = @{@"key" : @"real_name", @"value":loginUser.nickName};
    NSDictionary * phoneDic = @{@"key" : @"mobile_phone", @"value":loginUser.mobile};
    NSArray * array = @[nameDic,phoneDic];
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString * string =   [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    userInfo.data = string;
    [[QYSDK sharedSDK] setUserInfo:userInfo];
}

-(void)setNavgationController
{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"NavigationBack"] style:UIBarButtonItemStylePlain target:self action:@selector(onBack:)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
      self.navigationController.navigationBar.hidden = YES;
}
 - (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
@end
