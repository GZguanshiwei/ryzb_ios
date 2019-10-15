//
//  RefundAndGoodViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/27.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "RefundAndGoodViewController.h"
#import "EditGoodCell.h"
#import "EidtGoodAddCell.h"
#import "PickImageTipView.h"
#import "RefundTypeView.h"
#import "JMSystemPickImageTool.h"

@interface RefundAndGoodViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UILabel *statuTipLabel;
@property (weak, nonatomic) IBOutlet UITextView *reasonTextView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *pictureNumTipLabel;

@property (strong, nonatomic) NSMutableArray *collectionData;
@property (strong, nonatomic) NSString *type;
@end

#define AddItem @"Add"

@implementation RefundAndGoodViewController

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
    self.title = @"退货退款";
    self.type = @"1";
    //初始化
    self.collectionData = [[NSMutableArray alloc] init];
    [self.collectionData addObject:AddItem];
    [self updateCollectionView];
}

-(void)updateCollectionView{
    //更新数据源
    id lastObject = self.collectionData.lastObject;
    if(self.collectionData.count > 6){
        if([lastObject isEqual:AddItem]){
            [self.collectionData removeObject:AddItem];
        }
    }else if(self.collectionData.count < 6){
        if([lastObject isEqual:AddItem] == NO){
            [self.collectionData addObject:AddItem];
        }
    }
    [self.collectionView reloadData];
    //更新高度
    CGFloat width = (kScreenWidth - 15.0*2 - 12.0*2)/3.0;
    NSInteger row = ceil(self.collectionData.count/3.0);
    CGFloat needHeight = width*row + 12*(row-1);
    self.collectionHeightConstraint.constant = needHeight;
    //更新图片数量提示
    lastObject = self.collectionData.lastObject;
    if([lastObject isEqual:AddItem]){
        self.pictureNumTipLabel.text = [NSString stringWithFormat:@"最多上传6张照片 (%d/6)",(int)self.collectionData.count-1];
    }else{
        self.pictureNumTipLabel.text = [NSString stringWithFormat:@"最多上传6张照片 (%d/6)",(int)self.collectionData.count];
    }
}

#pragma mark - UICollection

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.collectionData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    id model = self.collectionData[indexPath.row];
    if([model isEqual:AddItem]){
        //添加
        EidtGoodAddCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EidtGoodAddCell" forIndexPath:indexPath];
        return cell;
    }else{
        EditGoodCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EditGoodCell" forIndexPath:indexPath];
        cell.imageView.image = self.collectionData[indexPath.row];
        JMWeak(self);
        cell.deleteBlock = ^{
            [weakself.collectionData removeObjectAtIndex:indexPath.row];
            [weakself updateCollectionView];
        };
        return cell;
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (kScreenWidth - 15.0*2 - 12.0*2)/3.0;
    return CGSizeMake(width, width);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10.0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 12.0;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    id model = self.collectionData[indexPath.row];
    if([model isEqual:AddItem]){
        //添加
        [self addImage];
    }else{
        
    }
}

-(void)addImage{
    
    NSInteger maxCount = 6 - self.collectionData.count;
    if([self.collectionData containsObject:AddItem]){
        maxCount++;
    }
    [JMPickPhotoTool pickImageWithCount:maxCount doneBlock:^(NSArray<UIImage *> *images) {
        for(UIImage *image in images){
            [self.collectionData insertObject:image atIndex:self.collectionData.count-1];
        }
        [self updateCollectionView];
    }];
}

#pragma mark - Actions
- (IBAction)commitAction:(id)sender {
    NSString *reason = self.reasonTextView.text;
    if(reason.length == 0){
        [JMProgressHelper toastInWindowWithMessage:self.reasonTextView.placeholder];
        return;
    }
    [self requestCommit];
}

- (IBAction)statusAction:(id)sender {
    RefundTypeView *typeView = [[RefundTypeView alloc] initWithXib];
    [typeView showViewWithDoneBlock:^(NSDictionary *params) {
        NSString *buttonIndex = [params getJsonValue:@"ButtonIndex"];
        switch (buttonIndex.integerValue) {
            case 0:
                //已收到货
                self.statuTipLabel.text = @"已收到货";
                self.type = @"1";
                break;
            case 1:
                //未收到货
                self.statuTipLabel.text = @"未收到货";
                self.type = @"2";
                break;
            default:
                break;
        }
    }];
}

#pragma mark - 网络
-(void)requestCommit{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.order.orderId key:@"orderId"];
    [params setJsonValue:self.reasonTextView.text key:@"reason"];
    [params setJsonValue:self.type key:@"type"];
    [params setJsonValue:[NSString stringWithFormat:@"%@_1",self.order.good.afterSaleId] key:@"ids"];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for(id object in self.collectionData){
        if([object isKindOfClass:[UIImage class]]){
            [array addObject:object];
        }
    }
    
    [self showLoading];
    [[JMRequestManager sharedManager] upload:kUrlRefundWithGoodOrder parameters:params formDataBlock:^NSDictionary<NSData *,JMDataName *> *(id<AFMultipartFormData> formData, NSMutableDictionary<NSData *,JMDataName *> *needFillDataDict) {
        for(int i=0;i<array.count;i++){
            UIImage *image = array[i];
            needFillDataDict[UIImageJPEGRepresentation(image, 0.3)] = [NSString stringWithFormat:@"img%d-image.jpg",(i+1)];
        }
        return needFillDataDict;
    } progress:nil completion:^(JMBaseResponse *response) {
        [self dismissLoading];
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            [JMProgressHelper toastInWindowWithMessage:response.responseObject[@"desc"]];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}
@end
