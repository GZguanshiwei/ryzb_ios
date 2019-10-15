//
//  GuideViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/2/15.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "GuideViewController.h"
#import <UIApplication+YYAdd.h>

@interface GuideViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) IBOutlet UIButton *enterButton;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+(BOOL)isShowGuide{
    //判断是否显示引导页
    NSString *guide = [[NSUserDefaults standardUserDefaults] objectForKey:@"Guide"];
    BOOL showGuide = NO;
    if(guide.length > 0){
        NSArray *array = [guide componentsSeparatedByString:@"_"];
        NSString *lastObject = array.lastObject;
        NSString *firstObject = array.firstObject;
        BOOL isShow = lastObject.boolValue;
        NSString *localVersion = [UIApplication sharedApplication].appVersion;
        BOOL flag = [localVersion compare:firstObject options:NSNumericSearch] == NSOrderedDescending;
        if(flag){
            //新版本
            showGuide = YES;
        }else{
            if(isShow == NO){
                showGuide = YES;
            }
        }
    }else{
        showGuide = YES;
    }
    return showGuide;
}

-(void)initControl{
    self.enterButton.hidden = NO;
    self.nextButton.hidden = NO;
    
    self.pageControl.numberOfPages = 3;
    self.scrollView.delegate = self;
}

-(void)initData{
    //保存标识
    NSString *value = [NSString stringWithFormat:@"%@_%@",[UIApplication sharedApplication].appVersion,@"1"];
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:@"Guide"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - UINavigation
-(BOOL)navUIBaseViewControllerIsNeedNavBar:(JMNavUIBaseViewController *)navUIBaseViewController{
    return NO;
}

- (IBAction)enterAction:(id)sender {
    [[JMProjectManager sharedJMProjectManager] loadRootVC];
}

- (IBAction)nextAction:(id)sender {
    [[JMProjectManager sharedJMProjectManager] loadRootVC];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/scrollView.size.width;
    self.pageControl.currentPage = index;
    switch (index) {
        case 0:
        case 1:
            self.enterButton.hidden = YES;
            self.nextButton.hidden = NO;
            self.pageControl.hidden = NO;
            break;
        case 2:
            self.enterButton.hidden = NO;
            self.nextButton.hidden = YES;
            self.pageControl.hidden = YES;
            break;
        default:
            break;
    }
}

@end
