//
//  ProtectionViewController.m
//  JMBaseProject
//
//  Created by 抽筋的灯 on 2019/9/18.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "ProtectionViewController.h"

@interface ProtectionViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (nonatomic, assign) BOOL canScroll;
@end

@implementation ProtectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)initControl {
    self.scrollView.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:@"childMove" object:nil];
    //其中一个TAB离开顶部的时候，如果其他几个偏移量不为0的时候，要把他们都置为0
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:@"superMove" object:nil];
}

- (void)initData {
    if (self.type == 1) {
        self.contentLabel.text = self.goodDetail.specification;
    }else {
        //服务保障
        [self requestText];
    }
}

-(void)acceptMsg:(NSNotification *)notification {
    NSString *notificationName = notification.name;
    if ([notificationName isEqualToString:@"childMove"]) {
        self.canScroll = YES;
    }else if([notificationName isEqualToString:@"superMove"]){
        self.scrollView.contentOffset = CGPointZero;
        self.canScroll = NO;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.canScroll) {
        [scrollView setContentOffset:CGPointZero];
    }
    
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"superMove" object:nil userInfo:nil];
    }
}

#pragma mark -网络请求
- (void)requestText {
    //请求服务保障文本
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = @"6";
    [[JMRequestManager sharedManager] POST:kUrlHtmlContent parameters:params completion:^(JMBaseResponse *response) {
        if (response.error) {
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        } else {
            NSDictionary *dataDic = response.responseObject[@"data"];
//            self.contentLabel.text = [dataDic getJsonValue:@"content"];
            
            
            NSString *htmlString = [dataDic getJsonValue:@"content"];
            NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[htmlString dataUsingEncoding: NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType } documentAttributes:nil error:nil];

            self.contentLabel.attributedText = attrStr;
        }
    }];
    
}

@end
