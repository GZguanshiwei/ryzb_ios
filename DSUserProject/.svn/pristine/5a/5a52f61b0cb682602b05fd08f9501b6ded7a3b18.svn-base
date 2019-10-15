//
//  LiveJianBaoViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/9/20.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "LiveJianBaoViewController.h"

@interface LiveJianBaoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (copy, nonatomic) NSString *price;
@end

@implementation LiveJianBaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initControl{
    self.view.backgroundColor = [UIColor clearColor];
}

-(void)initData{
    [self requestJianBaoPrice];
}

-(BOOL)navUIBaseViewControllerIsNeedNavBar:(JMNavUIBaseViewController *)navUIBaseViewController{
    return NO;
}

#pragma mark - Actions
- (IBAction)selectAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
}

- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)okAction:(id)sender {
    if(self.selectBlock){
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        NSString *isSelect = self.selectButton.isSelected?@"1":@"0";
        [params setJsonValue:isSelect key:@"isSelect"];
        [params setJsonValue:self.price key:@"price"];
        self.selectBlock(params);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)htmlAction:(id)sender {
    HtmlViewController *htmlVC = [[HtmlViewController alloc] init];
    htmlVC.type = Html_Appraisal;
    [self.navigationController pushViewController:htmlVC animated:YES];
}

#pragma mark - 网络
-(void)requestJianBaoPrice{
    //鉴宝服务费用
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:@"appraisalPrice" key:@"name"];
    [self showLoading];
    [[JMRequestManager sharedManager] POST:kUrlJianBaoPrice parameters:params completion:^(JMBaseResponse *response) {
        [self dismissLoading];
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            self.price = response.responseObject[@"data"];
            if(self.price.doubleValue > 0){
                self.priceLabel.text = [NSString stringWithFormat:@"￥%@",self.price];
            }else{
                self.priceLabel.text = @"免费";
            }
        }
    }];
}
@end
