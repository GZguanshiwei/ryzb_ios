//
//  LiveLevelViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/9/16.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "LiveLevelViewController.h"
#import "LiveLevelRecordViewController.h"
#import "LiveLevelModel.h"

@interface LiveLevelViewController ()
/** 当前等级图标 */
@property (strong, nonatomic) IBOutlet UIImageView *nowGradeImageView;
/** 下一个等级图标 */
@property (strong, nonatomic) IBOutlet UIImageView *nextGradeImageView;
/** 等级进度 */
@property (strong, nonatomic) IBOutlet UIProgressView *gradeProgress;
/** 铁值升级说明 */
@property (strong, nonatomic) IBOutlet UIButton *gradeDescLabel;
/** 粉丝称号 */
@property (strong, nonatomic) IBOutlet UIImageView *fansNameImageView;
@property (strong, nonatomic) IBOutlet UILabel *fansOpenLabel;
/** 保级奖励 */
@property (strong, nonatomic) IBOutlet UIImageView *saveGradeImageView;
@property (strong, nonatomic) IBOutlet UILabel *saveOpenLabel;
/** 升级提醒 */
@property (strong, nonatomic) IBOutlet UIImageView *upGradeImageView;
@property (strong, nonatomic) IBOutlet UILabel *upOpenLabel;
/** 发言专属色 */
@property (strong, nonatomic) IBOutlet UIImageView *sendColorImageView;
@property (strong, nonatomic) IBOutlet UILabel *sendColorOpenLabel;
/** 观看十分钟任务 */
@property (strong, nonatomic) IBOutlet UIButton *tenMinButton;
/** 观看二十分钟任务 */
@property (strong, nonatomic) IBOutlet UIButton *twentyMinButton;
/** 分享直播间任务 */
@property (strong, nonatomic) IBOutlet UIButton *shareButton;
/** 点赞直播间任务 */
@property (strong, nonatomic) IBOutlet UIButton *zanButton;
/** 发言 */
@property (strong, nonatomic) IBOutlet UIButton *talkButton;

@property (nonatomic, strong) LiveLevelModel *levelModel;
@end

@implementation LiveLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initControl{
    self.view.backgroundColor = [UIColor clearColor];
    ViewRadius(self.gradeProgress, 2.5);
}

-(void)initData{
    [self requestMyLiveLevel];
}

- (void)setLevelModel:(LiveLevelModel *)levelModel {
    _levelModel = levelModel;
    //当前等级
    self.nowGradeImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"level_0%@",levelModel.grade]];
    //下一个等级
    self.nextGradeImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"level_0%@",levelModel.nextGrade]];
    int count = levelModel.nextIronValue.intValue - levelModel.ironValue.intValue;
    CGFloat gradePrecent = levelModel.ironValue.intValue/levelModel.nextIronValue.intValue;
    //等级进度
    self.gradeProgress.progress = gradePrecent;
    //总铁值
    [self.gradeDescLabel setTitle:[NSString stringWithFormat:@"总铁值%@，还差%d分升级",levelModel.ironValue,count] forState:UIControlStateNormal];
    //权益
    switch (levelModel.grade.intValue) {
        case 2:
            self.fansNameImageView.image = [UIImage imageNamed:@"live_pop_level_tag02"];
            self.fansOpenLabel.hidden = YES;
            break;
        case 3:
            self.fansNameImageView.image = [UIImage imageNamed:@"live_pop_level_tag02"];
            self.saveGradeImageView.image = [UIImage imageNamed:@"live_pop_level_tag03"];
            self.fansOpenLabel.hidden = YES;
            self.saveOpenLabel.hidden = YES;
            break;
        case 4:
            self.fansNameImageView.image = [UIImage imageNamed:@"live_pop_level_tag02"];
            self.saveGradeImageView.image = [UIImage imageNamed:@"live_pop_level_tag03"];
            self.upGradeImageView.image = [UIImage imageNamed:@"live_pop_level_tag04"];
            self.fansOpenLabel.hidden = YES;
            self.saveOpenLabel.hidden = YES;
            self.upOpenLabel.hidden = YES;
            break;
        case 5:
            self.fansNameImageView.image = [UIImage imageNamed:@"live_pop_level_tag02"];
            self.saveGradeImageView.image = [UIImage imageNamed:@"live_pop_level_tag03"];
            self.upGradeImageView.image = [UIImage imageNamed:@"live_pop_level_tag04"];
            self.sendColorImageView.image = [UIImage imageNamed:@"live_pop_level_tag05"];
            self.fansOpenLabel.hidden = YES;
            self.saveOpenLabel.hidden = YES;
            self.upOpenLabel.hidden = YES;
            self.sendColorOpenLabel.hidden = YES;
            break;
            
        default:
            break;
    }
    //每日任务
    if (levelModel.tenMin) {
        [self setButton:self.tenMinButton];
    }
    if (levelModel.twentyMin) {
        [self setButton:self.twentyMinButton];
    }
    if (levelModel.share) {
        [self setButton:self.shareButton];
    }
    if (levelModel.zan) {
        [self setButton:self.zanButton];
    }
    if (levelModel.talk) {
        [self setButton:self.talkButton];
    }
}

- (void)setButton:(UIButton *)button {
    button.enabled = NO;
    [button setTitle:@"已完成" forState:UIControlStateNormal];
}

#pragma mark - UINavigation
-(BOOL)navUIBaseViewControllerIsNeedNavBar:(JMNavUIBaseViewController *)navUIBaseViewController{
    return NO;
}

#pragma mark - Actions
- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)recordAction:(id)sender {
    LiveLevelRecordViewController *recordVC = [[LiveLevelRecordViewController alloc] initWithStoryboardName:@"LivePlay"];
    [self.navigationController pushViewController:recordVC animated:NO];
}

- (IBAction)levelRuleAction:(id)sender {
    HtmlViewController *htmlVC = [[HtmlViewController alloc] init];
    htmlVC.type = Html_FansLevel;
    [self.navigationController pushViewController:htmlVC animated:YES];
}

- (IBAction)taskButtonAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    [self dismissViewControllerAnimated:YES completion:nil];
    if (button.tag == 4) {
        //发言
    }
}


#pragma mark - 网络
-(void)requestMyLiveLevel{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.roomId key:@"roomId"];
    [[JMRequestManager sharedManager] POST:kUrlLiveLevelInfo parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            NSDictionary *dict = response.responseObject[@"data"];
            LiveLevelModel *model = [[LiveLevelModel alloc] initWithDictionary:dict];
            self.levelModel = model;
        }
    }];
}

@end
