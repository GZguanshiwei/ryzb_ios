//
//  StoreSearchViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/7/4.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "StoreSearchViewController.h"
#import "StoreSearchPageViewController.h"

@interface StoreSearchViewController ()
@property (weak, nonatomic) IBOutlet UIView *unreadNumView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (strong, nonatomic) StoreSearchPageViewController *pageVC;
@end

@implementation StoreSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"Page"]){
        self.pageVC = (StoreSearchPageViewController *)segue.destinationViewController;
    }
}

-(void)initControl{
    self.unreadNumView.layer.cornerRadius = self.unreadNumView.mj_h/2.0;
    self.searchTextField.delegate = self;
    [self.searchTextField becomeFirstResponder];
}

#pragma mark - Navigation
-(BOOL)navUIBaseViewControllerIsNeedNavBar:(JMNavUIBaseViewController *)navUIBaseViewController{
    return NO;
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

-(UIReturnKeyType)textViewControllerLastReturnKeyType:(JMTextViewController *)textViewController{
    return UIReturnKeySearch;
}

- (IBAction)messageAction:(id)sender {
    NewsViewController *newsVC = [[NewsViewController alloc] initWithStoryboardName:@"News"];
    [self.navigationController pushViewController:newsVC animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [super textFieldShouldReturn:textField];
    [self.pageVC startSearchWithKeyword:textField.text];
    return YES;
}

@end
