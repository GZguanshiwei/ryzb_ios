//
//  GoodDetailViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/20.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "GoodDetailViewController.h"
#import "MarketShopCell.h"
#import "RecommendViewController.h"
#import "GoodEvaluateViewController.h"
#import "MakeOrderViewController.h"
#import "GoodDetailModel.h"
#import "ResaleTipView.h"
#import "ResaleSuccessTipView.h"
#import "DetailItemView.h"
#import "SDCycleScrollView.h"
#import "DetailBannerCell.h"
#import "KanJiaTipView.h"
#import "ShareImageViewController.h"

@interface GoodDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MarketShopCellDelegate,UIWebViewDelegate,SDCycleScrollViewDelegate>
//导航栏
@property (weak, nonatomic) IBOutlet UIView *topBarView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topBarHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *topOneView;
@property (weak, nonatomic) IBOutlet UIView *topTwoView;
@property (weak, nonatomic) IBOutlet UIButton *barBabyButton;
@property (weak, nonatomic) IBOutlet UIButton *barEvaluationButton;
@property (weak, nonatomic) IBOutlet UIButton *barRecommendButton;
@property (weak, nonatomic) IBOutlet UIButton *barInfoButton;
@property (weak, nonatomic) IBOutlet UIButton *barEnsureButton;
@property (weak, nonatomic) IBOutlet UIView *cycleScrollView;

//商品
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *tagView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *onLiveButton;


//评论
@property (weak, nonatomic) IBOutlet UIView *evaluationView;
@property (weak, nonatomic) IBOutlet UIImageView *evaHeadImageView;
@property (weak, nonatomic) IBOutlet UILabel *evaNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *evaContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *noEvaLabel;
@property (weak, nonatomic) IBOutlet UIView *evaInfoView;

//宝贝推荐
@property (weak, nonatomic) IBOutlet UIView *recommendView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *collectionData;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewConstraint;

//详情
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UIStackView *infoStackView;

//保障
@property (weak, nonatomic) IBOutlet UIView *ensureView;
@property (weak, nonatomic) IBOutlet UIWebView *ensureWebView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ensureWebHeightConstraint;


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

//底部操作栏
@property (weak, nonatomic) IBOutlet UIButton *storeButton;
@property (weak, nonatomic) IBOutlet UILabel *storeNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *resaleNumLabel;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (strong, nonatomic) GoodDetailModel *goodDetail;
@property (strong, nonatomic) SDCycleScrollView *cycleImageView;
@property (weak, nonatomic) IBOutlet UIStackView *stackView;
//是否是游客
@property(nonatomic,assign)BOOL isTourists;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@property (weak, nonatomic) IBOutlet UIButton *kanjiaButton;
@end

@implementation GoodDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initControl{
    self.topBarHeightConstraint.constant = [UIApplication sharedApplication].statusBarFrame.size.height + 44.0;
    self.topBarView.backgroundColor = [UIColor clearColor];
    self.topTwoView.alpha = 0.0;
    self.barBabyButton.selected = YES;
    
    self.scrollView.delegate = self;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    self.tagView.layer.cornerRadius = 2.0;
    self.tagView.layer.borderColor = [UIColor colorWithHexString:@"#FF701C"].CGColor;
    self.tagView.layer.borderWidth = 0.8;
    
    self.ensureWebView.delegate = self;
    
    self.evaHeadImageView.layer.cornerRadius = self.evaHeadImageView.mj_h/2.0;
    self.evaHeadImageView.layer.masksToBounds = YES;
    self.evaInfoView.hidden = YES;
    //我转售的商品详情
    if (self.isResale) {
        self.stackView.hidden = YES;
        self.leftButton.hidden = YES;
        self.rightButton.hidden = YES;
        self.bottomViewConstraint.constant = 0;
    }
    [self.cycleScrollView bringSubviewToFront:self.shareButton];

}

-(void)initData{
    [self requestGoodDetail];
    [self requestGoodEnsure];
    JMLoginUserModel *user =  [JMProjectManager sharedJMProjectManager].loginUser;
    if ([user.sessionId isEqualToString:@"sessionId"]) {
        self.isTourists = YES;
    }else
    {
        self.isTourists = NO;
    }
}

-(void)refreshGoodDetail{
    if(self.goodDetail){
        if(self.goodDetail.sellState.integerValue == 0){
            self.kanjiaButton.enabled = NO;
            if(self.showWuHuo){
                self.priceLabel.text = [NSString stringWithFormat:@"￥%@",self.goodDetail.price];
                self.oldPriceLabel.text = [NSString stringWithFormat:@"￥%@",self.goodDetail.price];
                [self.rightButton setTitle:@"商品无货" forState:UIControlStateNormal];
                self.rightButton.enabled = NO;
                UIImage *image = [UIImage imageNamed:@"spxq_btn_4"];
                [self.rightButton setBackgroundImage:image forState:UIControlStateDisabled];
            }else{
                self.priceLabel.text = @"已结缘";
                self.oldPriceLabel.text = nil;
                [self.rightButton setTitle:@"已结缘" forState:UIControlStateNormal];
                self.rightButton.enabled = NO;
                UIImage *image = [UIImage imageNamed:@"spxq_btn_2"];
                [self.rightButton setBackgroundImage:image forState:UIControlStateDisabled];
            }
        }else{
            self.priceLabel.text = [NSString stringWithFormat:@"￥%@",self.goodDetail.price];
            self.oldPriceLabel.text = [NSString stringWithFormat:@"￥%@",self.goodDetail.price];
            [self.rightButton setTitle:@"立即购买" forState:UIControlStateNormal];
            self.rightButton.enabled = YES;
            UIImage *image = [UIImage imageNamed:@"spxq_btn_2-1"];
            [self.rightButton setBackgroundImage:image forState:UIControlStateNormal];
        }
        self.onLiveButton.hidden = !self.goodDetail.isLive;
        self.goodTitleLabel.text = self.goodDetail.title;
        self.collectionData = self.goodDetail.recommendGoods;
        [self.collectionView reloadData];
        self.resaleNumLabel.text = [NSString stringWithFormat:@"转售%@",self.goodDetail.resaleNum];
        self.storeNumLabel.text = [NSString stringWithFormat:@"收藏%@",self.goodDetail.collectedNum];
        self.storeButton.selected = self.goodDetail.isCollected;
        [self refreshInfo];
        [self refreshComment];
        [self refreshBannelImage];
    }
}

-(void)refreshInfo{
    //信息
    for(GoodDetailInfoItemModel *item in self.goodDetail.infoItems){
        DetailItemView *itemView = [[DetailItemView alloc] initWithTip:item.infoTip content:item.infoContent];
        [self.infoStackView addArrangedSubview:itemView];
    }
    //图片
    for(NSString *image in self.goodDetail.infoImages){
        UIView *view = [[UIView alloc] init];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [imageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:image] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                //宽高比 370:209
                CGFloat height = (kScreenWidth - 6) * (image.size.height/image.size.width);
                make.height.mas_equalTo(height);
            }];
        }];
        [view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left).mas_offset(3);
            make.right.equalTo(view.mas_right).mas_offset(-3);
            make.top.equalTo(view.mas_top);
            make.bottom.equalTo(view.mas_bottom).mas_offset(-5);
        }];
        [self.infoStackView addArrangedSubview:view];
        
    }
}

-(void)refreshComment{
    if(self.goodDetail.commentId.length > 0){
        self.evaInfoView.hidden = NO;
        self.noEvaLabel.hidden = YES;
        self.evaNameLabel.text = self.goodDetail.commentName;
        [self.evaHeadImageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:self.goodDetail.commentHead]];
        self.evaContentLabel.text = self.goodDetail.commentContent;
    }else{
        self.evaInfoView.hidden = YES;
        self.noEvaLabel.hidden = NO;
    }
}

-(void)refreshBannelImage{
    //轮播图
    SDCycleScrollView *cycleImageView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"home_ban"]];
    cycleImageView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    cycleImageView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    cycleImageView.pageDotImage = [UIImage imageNamed:@"home_ban_unsel"];
    cycleImageView.currentPageDotImage = [UIImage imageNamed:@"home_ban_sel"];
    self.cycleImageView = cycleImageView;
    [self.cycleScrollView addSubview:cycleImageView];
    [self.cycleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.cycleScrollView);
    }];
    //设置数据
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:self.goodDetail.infoImages];
    if(self.goodDetail.videoUrl.length > 0){
        [array insertObject:self.goodDetail.coverImage atIndex:0];
    }
    self.cycleImageView.imageURLStringsGroup = array;
}

#pragma mark - SDCycleScrollViewDelegate
- (UINib *)customCollectionViewCellNibForCycleScrollView:(SDCycleScrollView *)view{
    return [UINib nibWithNibName:@"DetailBannerCell" bundle:nil];
}

/** 如果你自定义了cell样式，请在实现此代理方法为你的cell填充数据以及其它一系列设置 */
- (void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(SDCycleScrollView *)view{
    DetailBannerCell *bannelCell = (DetailBannerCell *)cell;
    BOOL hasVideo = self.goodDetail.videoUrl.length > 0;
    if(hasVideo == YES){
        if(index == 0){
            [bannelCell updateImageUrl:self.goodDetail.coverImage isShowPlay:YES];
        }else{
            [bannelCell updateImageUrl:self.goodDetail.infoImages[index-1] isShowPlay:NO];
        }
    }else{
        [bannelCell updateImageUrl:self.goodDetail.infoImages[index] isShowPlay:NO];
    }
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    BOOL hasVideo = self.goodDetail.videoUrl.length > 0;
    if(hasVideo == YES && index == 0){
        //视频播放
        [[JMProjectManager sharedJMProjectManager] fullScreenPlayVideo:self.goodDetail.videoUrl title:self.goodDetail.title coverImage:self.goodDetail.coverImage];
    }else{
        //图片大图
        [JMCommonMethod largeImagePreview:self.goodDetail.bannerImages currentIndex:hasVideo?(index-1):index];
    }
}

#pragma mark - Navigation
-(BOOL)navUIBaseViewControllerIsNeedNavBar:(JMNavUIBaseViewController *)navUIBaseViewController{
    return NO;
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UICollectionView
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger rtn = 0;
    if(self.collectionData.count < 2){
        rtn = self.collectionData.count;
    }else{
        rtn = 2;
    }
    return rtn;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MarketShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MarketShopCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.index = indexPath.row;
    cell.cellData = self.collectionData[indexPath.row];
    return cell;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 15, 0, 15);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize rtn = CGSizeZero;
    rtn.width = (kScreenWidth-15*2-5)/2.0;
    rtn.height = rtn.width + 75;
    return rtn;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5.0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5.0;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GoodDetailViewController *detailVC = [[GoodDetailViewController alloc] initWithStoryboardName:@"GoodDetail"];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - MarketShopCellDelegate
-(void)didStore:(NSInteger)index{
    [self requestCollectionAtIndex:index];
}

-(void)didResale:(NSInteger)index{
    ResaleTipView *resaleView = [[ResaleTipView alloc] initWithXib];
    GoodModel *good = self.collectionData[index];
    resaleView.good = good;
    [resaleView showViewWithDoneBlock:^(NSDictionary * _Nonnull params) {
        NSString *buttonIndex = [params getJsonValue:@"ButtonIndex"];
        switch (buttonIndex.integerValue) {
            case 0://购买帮助
                [self goBuyHelpHtmlVC];
                break;
            case 1://转售
                [self requestResaleWithGood:good.goodId content:[params getJsonValue:@"Content"] index:index];
                break;
            default:
                break;
        }
    }];
}

-(void)showResaleSuccess:(GoodModel *)good{
    ResaleSuccessTipView *successView = [[ResaleSuccessTipView alloc] initWithXib];
    [successView showViewWithDoneBlock:^(NSDictionary * _Nonnull params) {
        NSString *buttonIndex = [params getJsonValue:@"ButtonIndex"];
        switch (buttonIndex.integerValue) {
            case 0://购买帮助
                [self goBuyHelpHtmlVC];
                break;
            case 1://分享朋友圈
            {
                ShareImageViewController *shareVC = [[ShareImageViewController alloc] initWithStoryboardName:@"Market"];
                shareVC.good = good;
                [self.view insertSubview:shareVC.view atIndex:0];
            }
                break;
            default:
                break;
        }
    }];
}

-(void)goBuyHelpHtmlVC{
    HtmlViewController *htmlVC = [[HtmlViewController alloc] init];
    htmlVC.type = Html_Buy;
    [self.navigationController pushViewController:htmlVC animated:YES];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //获取ScrollView的偏移量y
    CGFloat offsetY = scrollView.contentOffset.y;
    //自己设置需要滚动到哪里可以完全显示导航栏
    CGFloat scrollValue = 264.0;
    //将偏移量除以需要滚动的量,可以得到需要显示的透明度
    CGFloat alpha = offsetY/scrollValue;
    
    if(alpha >= 1){
        alpha = 1;
    }
    //将透明度赋值给第一个View即可
    UIColor *bgColor = [UIColor colorWithRed:80.0/255.0 green:204.0/255.0 blue:159.0/255.0 alpha:alpha];
    self.topBarView.backgroundColor = bgColor;
    
    self.topOneView.alpha = 1-alpha;
    self.topTwoView.alpha = alpha;
    
    [self updateTopBarButtonSelect];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self updateTopBarButtonSelect];
}

-(void)updateTopBarButtonSelect{
    CGFloat barHeight = self.topBarView.mj_h;
    CGFloat evaluationY = self.evaluationView.mj_y - 12 - barHeight;
    CGFloat recommendY = self.recommendView.mj_y - 12 - barHeight;
    CGFloat infoY = self.infoView.mj_y - 12 - barHeight;
    CGFloat ensureY = self.ensureView.mj_y - 12 - barHeight;
    CGFloat offsetY = self.scrollView.contentOffset.y;
    if(offsetY >= 0 && offsetY < evaluationY){
        self.barBabyButton.selected = YES;
        self.barEvaluationButton.selected = NO;
        self.barInfoButton.selected = NO;
        self.barEnsureButton.selected = NO;
        self.barRecommendButton.selected = NO;
    }else if(offsetY >= evaluationY && offsetY < recommendY){
        self.barEvaluationButton.selected = YES;
        self.barInfoButton.selected = NO;
        self.barBabyButton.selected = NO;
        self.barEnsureButton.selected = NO;
        self.barRecommendButton.selected = NO;
    }else if(offsetY >= recommendY && offsetY < infoY){
        self.barEvaluationButton.selected = NO;
        self.barInfoButton.selected = NO;
        self.barBabyButton.selected = NO;
        self.barEnsureButton.selected = NO;
        self.barRecommendButton.selected = YES;
    }else if(offsetY >= infoY && offsetY < ensureY){
        self.barEvaluationButton.selected = NO;
        self.barInfoButton.selected = YES;
        self.barBabyButton.selected = NO;
        self.barEnsureButton.selected = NO;
        self.barRecommendButton.selected = NO;
    }else if(offsetY >= ensureY){
        self.barInfoButton.selected = NO;
        self.barEvaluationButton.selected = NO;
        self.barBabyButton.selected = NO;
        self.barEnsureButton.selected = YES;
        self.barRecommendButton.selected = NO;
    }
}


#pragma mark - Actions
- (IBAction)barBabyAction:(id)sender {
    //宝贝
    [self.scrollView setContentOffset:CGPointZero animated:YES];
}

- (IBAction)barEvaluationAction:(id)sender {
    //评价
    CGPoint point = CGPointMake(0, self.evaluationView.mj_y-self.topBarView.mj_h);
    [self.scrollView setContentOffset:point animated:YES];
}

- (IBAction)barRecommendAction:(id)sender {
    //推荐
    CGPoint point = CGPointMake(0, self.recommendView.mj_y-self.topBarView.mj_h);
    [self.scrollView setContentOffset:point animated:YES];
}

- (IBAction)barInfoAction:(id)sender {
    //详情
    CGPoint point = CGPointMake(0, self.infoView.mj_y-self.topBarView.mj_h);
    [self.scrollView setContentOffset:point animated:YES];
}

- (IBAction)barEnsureAction:(id)sender {
    //保障
    CGPoint point = CGPointMake(0, self.ensureView.mj_y-self.topBarView.mj_h);
    [self.scrollView setContentOffset:point animated:YES];
}

- (IBAction)moreRecommendAction:(id)sender {
    //更多推荐
    RecommendViewController *recommendVC = [[RecommendViewController alloc] initWithStoryboardName:@"GoodDetail"];
    [self.navigationController pushViewController:recommendVC animated:YES];
}

- (IBAction)moreEvaluateAction:(id)sender {
    //更多评论
    GoodEvaluateViewController *evaluateVC = [[GoodEvaluateViewController alloc] initWithStoryboardName:@"GoodDetail"];
    evaluateVC.goodId = self.goodId;
    [self.navigationController pushViewController:evaluateVC animated:YES];
}

- (IBAction)buyAction:(id)sender {
    [self decideIfYouCanBuy];
}

#pragma mark - 判断是否能购买
-(void)decideIfYouCanBuy
{
    if ([[JMProjectManager sharedJMProjectManager] isTourist] == NO) {
        NSMutableDictionary *parames = [JMCommonMethod baseRequestParams];
        [parames setJsonValue:self.goodId key:@"goodsId"];
        [[JMRequestManager sharedManager] GET:kUrlOrdergoodsCanPay parameters:parames completion:^(JMBaseResponse *response) {
            if (response.error) {
                [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
            }else{
                NSString *canBuyStr  = response.responseObject[@"data"];
                if (canBuyStr.integerValue == 1) {
                    //购买
                        MakeOrderViewController *makeOrderVC = [[MakeOrderViewController alloc] initWithStoryboardName:@"GoodDetail"];
                        makeOrderVC.good = self.goodDetail;
                        [self.navigationController pushViewController:makeOrderVC animated:YES];
                }else{
                    [JMProgressHelper toastInWindowWithMessage:@"该商品正在被其他用户购买"];
                }
            }
        }];
    }
}

- (IBAction)customerServiceAction:(id)sender {
    if ([[JMProjectManager sharedJMProjectManager] isTourist] == NO) {
        JMLoginUserModel *loginUser = [JMProjectManager sharedJMProjectManager].loginUser;
        //联系客服
        QYSource *source = [[QYSource alloc] init];
        source.title = loginUser.nickName;
        source.urlString = loginUser.headUrl;
        QiYuCustomServiceController *sessionViewController = [[QiYuCustomServiceController alloc] init];
        sessionViewController.sessionTitle = @"客服";
        sessionViewController.source = source;
        [self.navigationController pushViewController:sessionViewController animated:YES];
    }
}

- (void)onBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)enterLiveRoomAction:(id)sender {
    //进入直播
    [[JMProjectManager sharedJMProjectManager] enterRoom:self.goodDetail.roomId];
}

- (IBAction)storeAction:(id)sender {
    if ([[JMProjectManager sharedJMProjectManager] isTourist] == NO){
        //收藏、取消收藏
        [self requestCollectionAtIndex:-1];
    }
}

- (IBAction)resaleAction:(id)sender {
    if ([[JMProjectManager sharedJMProjectManager] isTourist] == NO){
        //转售
        ResaleTipView *resaleView = [[ResaleTipView alloc] initWithXib];
        resaleView.good = self.goodDetail;
        [resaleView showViewWithDoneBlock:^(NSDictionary * _Nonnull params) {
            NSString *buttonIndex = [params getJsonValue:@"ButtonIndex"];
            switch (buttonIndex.integerValue) {
                case 0://购买帮助
                    [self goBuyHelpHtmlVC];
                    break;
                case 1://转售
                    [self requestResaleWithGood:self.goodDetail.goodId content:[params getJsonValue:@"Content"] index:-1];
                    break;
                default:
                    break;
            }
        }];
    }
}

- (IBAction)shareButtonClick:(id)sender {
    //分享砍价
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.goodId key:@"goodsId"];
    [[JMRequestManager sharedManager] POST:kUrlCreateBargain parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            NSDictionary *dataDic = response.responseObject[@"data"];
            NSString *bargainId = [dataDic getJsonValue:@"id"];
            ShareTipView *shareTipView = [[ShareTipView alloc] initWithXib];
            shareTipView.title = self.goodDetail.title;
            shareTipView.subtitle = [NSString stringWithFormat:@"我正在%@APP参与砍价0元购的活动，快来帮我砍一刀吧",[UIApplication sharedApplication].appBundleName];
            shareTipView.image = self.goodDetail.coverImage;
            [shareTipView showShareWithType:Share_Bargain requestIds:bargainId];
        }
    }];
}

- (IBAction)invitionAction:(id)sender {
    //邀请好友砍价
    [self requestCreateBargain];
}

- (IBAction)introductionAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    HtmlViewController *htmlVC = [[HtmlViewController alloc] init];
    switch (button.tag) {
        case 0://鉴宝服务介绍
            htmlVC.type = Html_Appraisal;
            break;
        case 1://砍价规则
            htmlVC.type = Html_Bargaining;
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:htmlVC animated:YES];
    
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    // 获取内容高度
    CGFloat height =  [[webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.scrollHeight"] intValue];
    
    self.ensureWebHeightConstraint.constant = height;
    
    //重写contentSize,防止左右滑动
    CGSize size = webView.scrollView.contentSize;
    size.width = webView.scrollView.frame.size.width;
    webView.scrollView.contentSize = size;
}

#pragma mark - 跳转


#pragma mark - 网络
-(void)requestGoodDetail{
    if(JMIsEmpty(self.goodId) == NO){
        NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
        [params setJsonValue:self.goodId key:@"goodsId"];
        [self showLoading];
        [[JMRequestManager sharedManager] POST:kUrlGoodDetail parameters:params completion:^(JMBaseResponse *response) {
            [self dismissLoading];
            if(response.error){
                [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
            }else{
                NSDictionary *dataDic = response.responseObject[@"data"];
                self.goodDetail = [[GoodDetailModel alloc] initWithDetailDictionary:dataDic];
                [self refreshGoodDetail];
            }
        }];
    }
}

-(void)requestGoodEnsure{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:@"6" key:@"id"];
    [[JMRequestManager sharedManager] POST:kUrlHtmlContent parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            NSDictionary *dataDic = response.responseObject[@"data"];
            NSString *type = [dataDic getJsonValue:@"type"];
            if(type.intValue == 0){
                NSString *htmlContent = [dataDic getJsonValue:@"content"];
                [self.ensureWebView loadHTMLString:htmlContent baseURL:nil];
            }
        }
    }];
}


-(void)requestResaleWithGood:(NSString *)goodId content:(NSString *)content index:(NSInteger)index{
    //转售
    GoodModel *good;
    if(index == -1){
        good = self.goodDetail;
    }else{
        good = self.collectionData[index];
    }
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:goodId key:@"goodsId"];
    [params setJsonValue:content key:@"describe"];
    [[JMRequestManager sharedManager] POST:kUrlResaleGood parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            good.goodsResaleId = response.responseObject[@"data"];
            good.resaleContent = content;
            [self showResaleSuccess:good];
            [self refreshGoodAtIndex:index];
        }
    }];
}

-(void)requestCollectionAtIndex:(NSInteger)index{
    //收藏、取消收藏
    NSString *goodId;
    if(index == -1){
        goodId = self.goodDetail.goodId;
    }else{
        GoodModel *good = self.collectionData[index];
        goodId = good.goodId;
    }
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:goodId key:@"goodsId"];
    [[JMRequestManager sharedManager] POST:kUrlCollectionGood parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            [JMProgressHelper toastInWindowWithMessage:response.responseObject[@"desc"]];
            [self refreshGoodAtIndex:index];
        }
    }];
}

-(void)refreshGoodAtIndex:(NSInteger)index{
    //推荐刷新单个
    GoodModel *good;
    if(index == -1){
        good = self.goodDetail;
    }else{
        good = self.collectionData[index];
    }
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:good.goodId key:@"goodsId"];
    [[JMRequestManager sharedManager] POST:kUrlGoodDetail parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            NSDictionary *dataDic = response.responseObject[@"data"];
            good.isCollected = [dataDic getJsonValue:@"isCollected"].boolValue;
            good.collectedNum = [dataDic getJsonValue:@"collectedNum"];
            good.resaleNum = [dataDic getJsonValue:@"resaleNum"];
            if(index == -1){
                self.resaleNumLabel.text = [NSString stringWithFormat:@"转售%@",self.goodDetail.resaleNum];
                self.storeNumLabel.text = [NSString stringWithFormat:@"收藏%@",self.goodDetail.collectedNum];
                self.storeButton.selected = self.goodDetail.isCollected;
            }else{
                NSIndexPath *row = [NSIndexPath indexPathForItem:index inSection:0];
                [self.collectionView reloadItemsAtIndexPaths:@[row]];
            }
        }
    }];
}

-(void)requestCreateBargain{
    //发起砍价
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.goodId key:@"goodsId"];
    [[JMRequestManager sharedManager] POST:kUrlCreateBargain parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            [JMProgressHelper toastInWindowWithMessage:response.responseObject[@"desc"]];
            KanJiaTipView *tipView = [[KanJiaTipView alloc] initWithXib];
            NSDictionary *dataDic = response.responseObject[@"data"];
            NSString *bargainId = [dataDic getJsonValue:@"id"];
            tipView.downMoney = [dataDic getJsonValue:@"price"];
            [tipView showViewWithDoneBlock:^(NSDictionary * _Nonnull params) {
                ShareTipView *shareTipView = [[ShareTipView alloc] initWithXib];
                shareTipView.title = self.goodDetail.title;
                shareTipView.subtitle = [NSString stringWithFormat:@"我正在%@APP参与砍价0元购的活动，快来帮我砍一刀吧",[UIApplication sharedApplication].appBundleName];
                shareTipView.image = self.goodDetail.coverImage;
                [shareTipView showShareWithType:Share_Bargain requestIds:bargainId];
            }];
        }
    }];
}

@end
