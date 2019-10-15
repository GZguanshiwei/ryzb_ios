//
//  ViewController.m
//  JMBaseProject
//
//  Created by liuny on 2018/7/14.
//  Copyright © 2018年 liuny. All rights reserved.
//

#import "ViewController.h"
#import "LiveCommentViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)buttonAction:(id)sender {
    LiveCommentViewController *commentVC = [[LiveCommentViewController alloc] initWithStoryboardName:@"LivePlay"];
    commentVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:commentVC animated:YES completion:nil];
}
@end
