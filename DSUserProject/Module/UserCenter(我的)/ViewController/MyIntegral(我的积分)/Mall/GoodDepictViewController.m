//
//  GoodDepictViewController.m
//  JMBaseProject
//
//  Created by 抽筋的灯 on 2019/9/18.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "GoodDepictViewController.h"

@interface GoodDepictViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *detailedLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailedLabelHeight;
@property (weak, nonatomic) IBOutlet UIStackView *imageStackView;

@property (nonatomic, assign) BOOL canScroll;
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation GoodDepictViewController

#pragma mark -懒加载
- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    //图片
    [self.imageStackView removeAllSubviews];
    for(NSString *image in dataArray){
        UIView *view = [[UIView alloc] init];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        
        [imageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:image] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                //宽高比 370:209
                CGFloat height = (kScreenWidth - 36) * (image.size.height/image.size.width);
                make.height.mas_equalTo(height);
            }];
        }];
        
        [view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left).mas_offset(18);
            make.right.equalTo(view.mas_right).mas_offset(-18);
            make.top.equalTo(view.mas_top);
            make.bottom.equalTo(view.mas_bottom).mas_offset(-5);
        }];
        [self.imageStackView addArrangedSubview:view];
    }
}

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
    self.detailedLabel.text = self.goodDetail.detailedText;
    CGSize size = [self.detailedLabel.text boundingRectWithSize:CGSizeMake(kScreenWidth - 16, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.detailedLabel.font} context:nil].size;
    self.detailedLabelHeight.constant = size.height;
    [self.view layoutIfNeeded];
    self.dataArray = self.goodDetail.infoImages.copy;
}

#pragma mark -tableView
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
    if (offsetY <= 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"superMove" object:nil userInfo:nil];
    }
}



@end
