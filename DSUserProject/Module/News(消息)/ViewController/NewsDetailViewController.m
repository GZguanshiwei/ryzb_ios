//
//  NewsDetailViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/19.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "NewsDetailViewController.h"

@interface NewsDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initControl{
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)initData{
    self.title = @"公告详情";
    
    self.titleLabel.text = self.notice.title;
    self.timeLabel.text = self.notice.time;
    [self.webView loadHTMLString:self.notice.content baseURL:nil];
}

@end
