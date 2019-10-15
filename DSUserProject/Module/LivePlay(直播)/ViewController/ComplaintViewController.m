//
//  ComplaintViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/17.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "ComplaintViewController.h"
#import "ComplaintCell.h"

@interface ComplaintViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *collectionData;
@property (assign, nonatomic) NSInteger selectIndex;
@property (weak, nonatomic) IBOutlet UITextView *inputContentTextView;
@end

@implementation ComplaintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initControl{
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.scrollEnabled = NO;
}

-(void)initData{
    self.title = @"投诉建议";
    
    self.collectionData = @[@"投诉主播",
                            @"投诉客服",
                            @"物流状况",
                            @"优惠活动",
                            @"功能异常",
                            @"表扬",
                            @"建议",
                            @"其他"
                            ];
    self.selectIndex = -1;
    
}

#pragma mark - UICollectionView
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.collectionData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ComplaintCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ComplaintCell" forIndexPath:indexPath];
    BOOL isSelect = self.selectIndex == indexPath.row;
    [cell updateWithTitle:self.collectionData[indexPath.row] isSelect:isSelect];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize rtn = CGSizeZero;
    rtn.width = (kScreenWidth - 10)/2.0;
    rtn.height = 30;
    return rtn;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.selectIndex = indexPath.row;
    [self.collectionView reloadData];
}

#pragma mark - Actions
- (IBAction)commitAction:(id)sender {
    //提交
    if(self.selectIndex == -1){
        [JMProgressHelper toastInWindowWithMessage:@"请选择投诉类型"];
    }else{
        [self requestCommit];
    }
}

#pragma mark - 网络
-(void)requestCommit{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.userId key:@"targetId"];
    [params setJsonValue:[NSString stringWithFormat:@"%d",(int)self.selectIndex] key:@"type"];
    [params setJsonValue:self.inputContentTextView.text key:@"description"];
    [self showLoading];
    [[JMRequestManager sharedManager] POST:kUrlComplaintAnchor parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            [JMProgressHelper toastInWindowWithMessage:@"提交成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}
@end
