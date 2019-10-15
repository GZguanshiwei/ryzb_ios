//
//  AboutUsViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/25.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "AboutUsViewController.h"
#import "FeedbackViewController.h"

@interface AboutUsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLable;

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initControl{
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.iconImageView.layer.cornerRadius = self.iconImageView.mj_h/2.0;
//    self.iconImageView.layer.masksToBounds = YES;
}

-(void)initData{
    self.title = @"关于我们";
    [self requestInfor];
}

#pragma mark - Actions
- (IBAction)feedbackAction:(id)sender {
    //意见反馈
    FeedbackViewController *feedbackVC = [[FeedbackViewController alloc] initWithStoryboardName:@"UserCenter"];
    [self.navigationController pushViewController:feedbackVC animated:YES];
}


-(void)requestInfor{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:@"2" key:@"id"];
    [[JMRequestManager sharedManager] POST:kUrlHtmlContent parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            NSString *contentStr  = response.responseObject[@"data"][@"content"];
            NSDictionary *attributesDic = @{
                                            NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor  colorWithHexString:@"#333333"],NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType
                                            };
            NSMutableAttributedString *mAttring = [[NSMutableAttributedString alloc] initWithData:[contentStr dataUsingEncoding:NSUnicodeStringEncoding] options:attributesDic documentAttributes:nil error:nil];
            [mAttring addAttributes:attributesDic range:NSMakeRange(0, mAttring.length)];
            self.contentLable.attributedText = mAttring.copy;
       
        }
    }];
}

-(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    
    return html;
}
@end
