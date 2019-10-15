//
//  GroupChildrenViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/7/18.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "GroupChildrenViewController.h"
#import "GroupChildrenPageViewController.h"
#import "NewsViewController.h"
#import "SearchViewController.h"

@interface GroupChildrenViewController ()
@property (weak, nonatomic) IBOutlet UIView *unreadNumView;
@property (weak, nonatomic) IBOutlet UILabel *unreadNumLabel;
@end

@implementation GroupChildrenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //获取系统消息未读数
    [self requsetUnReadCount];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSString *identifier = segue.identifier;
    if([identifier isEqualToString:@"Page"]){
        GroupChildrenPageViewController *pageVC = (GroupChildrenPageViewController *)segue.destinationViewController;
        pageVC.typeId = self.typeId;
    }
}

-(void)initControl{
    self.unreadNumView.layer.cornerRadius = self.unreadNumView.mj_h/2.0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requsetUnReadCount) name:kNotificationSystemNotice object:nil];
}

#pragma mark - UINavigation
-(BOOL)navUIBaseViewControllerIsNeedNavBar:(JMNavUIBaseViewController *)navUIBaseViewController{
    return NO;
}


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
                self.unreadNumLabel.text = num;
            }
        }
    }];
}

@end
