//
//  GoodTypeViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2018/12/24.
//  Copyright © 2018 liuny. All rights reserved.
//

#import "GoodTypeViewController.h"
#import "GroupLevelOneViewController.h"
#import "GroupLevelTwoViewController.h"
#import "NewsViewController.h"
#import "SearchViewController.h"

@interface GoodTypeViewController()
@property (weak, nonatomic) IBOutlet UIView *unreadNumView;
@property (weak, nonatomic) IBOutlet UILabel *unreadNumLable;
@property (nonatomic, weak) GroupLevelOneViewController *levelOneVC;
@property (nonatomic, weak) GroupLevelTwoViewController *levelTwoVC;
@end

@implementation GoodTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSString *identifier = segue.identifier;
    if([identifier isEqualToString:@"LevelOne"]){
        self.levelOneVC = (GroupLevelOneViewController *)segue.destinationViewController;
    }else if([identifier isEqualToString:@"LevelTwo"]){
        self.levelTwoVC = (GroupLevelTwoViewController *)segue.destinationViewController;
    }
}

-(void)initControl{
    self.unreadNumView.layer.cornerRadius = self.unreadNumView.mj_h/2.0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requsetUnReadCount) name:kNotificationSystemNotice object:nil];
}

-(void)initData{
    JMWeak(self);
    self.levelOneVC.changeGroupBlock = ^(NSString * _Nonnull groupId) {
        [weakself.levelTwoVC changeParentGroup:groupId];
    };
    [self requsetUnReadCount];
}

#pragma mark - UINavigation
-(BOOL)navUIBaseViewControllerIsNeedNavBar:(JMNavUIBaseViewController *)navUIBaseViewController{
    return NO;
}

#pragma mark - Actions
- (IBAction)searchAction:(id)sender {
    [self goSearchVC];
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)messageAction:(id)sender {
    NewsViewController *newsVC = [[NewsViewController alloc] initWithStoryboardName:@"News"];
    [self.navigationController pushViewController:newsVC animated:YES];
}
#pragma mark - 跳转
-(void)goSearchVC{
    SearchViewController *searchVC = [[SearchViewController alloc] initWithStoryboardName:@"Search"];
    [self.navigationController pushViewController:searchVC animated:NO];
}

/**
 获取系统消息未读数
 */
- (void)requsetUnReadCount {
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [[JMRequestManager sharedManager] POST:kUrlUnReadCount parameters:params completion:^(JMBaseResponse *response) {
        if (response.error) {
            
        }else {
            NSString *num = [response.responseObject getJsonValue:@"data"];
            if (num.integerValue == 0) {
                self.unreadNumView.hidden = YES;
            }else {
                self.unreadNumView.hidden = NO;
                self.unreadNumLable.text = num;
            }
        }
    }];
}
@end
