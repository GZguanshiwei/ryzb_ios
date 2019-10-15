//
//  DetailHelpTool.m
//  JMBaseProject
//
//  Created by Liuny on 2019/4/30.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "DetailHelpTool.h"

@interface DetailHelpTool ()
@property (strong, nonatomic) OrderModel *orderData;
@end


@implementation DetailHelpTool

-(instancetype)initWithOrder:(OrderModel *)order{
    self = [super init];
    if(self){
        self.orderData = order;
    }
    return self;
}

#pragma mark - Public
-(UIView *)orderInfoView{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    
    CGFloat labelOffset = 5.0;
    UIView *topView;
    //订单编号
    NSString *orderNoInfo = [NSString stringWithFormat:@"订单编号:%@",self.orderData.orderNo];
    UILabel *orderNoLabel = [self orderInfoLabalWithContent:orderNoInfo];
    [view addSubview:orderNoLabel];
    [orderNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_top);
        make.left.equalTo(view.mas_left);
    }];
    topView = orderNoLabel;
    //订单提交时间
    if(JMIsEmpty(self.orderData.createTime) == NO){
        NSString *createTimeInfo = [NSString stringWithFormat:@"订单提交时间:%@",self.orderData.createTime];
        UILabel *createTimeLabel = [self orderInfoLabalWithContent:createTimeInfo];
        [view addSubview: createTimeLabel];
        [createTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left);
            make.top.equalTo(topView.mas_bottom).mas_offset(labelOffset);
        }];
        topView = createTimeLabel;
    }
    //订单支付时间
    if(JMIsEmpty(self.orderData.payTime) == NO){
        NSString *payTimeInfo = [NSString stringWithFormat:@"订单支付时间:%@",self.orderData.payTime];
        UILabel *payTimeLabel = [self orderInfoLabalWithContent:payTimeInfo];
        [view addSubview:payTimeLabel];
        [payTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left);
            make.top.equalTo(topView.mas_bottom).mas_offset(labelOffset);
        }];
        //支付方式
        UIView *payView = [self orderInfoPayTypeView];
        [view addSubview:payView];
        [payView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left);
            make.height.mas_equalTo(30);
            make.right.equalTo(view.mas_right);
            make.top.equalTo(payTimeLabel.mas_bottom);
        }];
        topView = payView;
    }
    //订单评价时间
    if(JMIsEmpty(self.orderData.evaluateTime) == NO){
        NSString *evaluateTimeInfo = [NSString stringWithFormat:@"订单评价时间:%@",self.orderData.evaluateTime];
        UILabel *evaluateTimeLabel = [self orderInfoLabalWithContent:evaluateTimeInfo];
        [view addSubview:evaluateTimeLabel];
        [evaluateTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left);
            make.top.equalTo(topView.mas_bottom);
        }];
        topView = evaluateTimeLabel;
    }
    //订单完成时间
    if(JMIsEmpty(self.orderData.evaluateTime) == NO){
        NSString *completeTimeInfo = [NSString stringWithFormat:@"订单完成时间:%@",self.orderData.completeTime];
        UILabel *completeTimeLabel = [self orderInfoLabalWithContent:completeTimeInfo];
        [view addSubview:completeTimeLabel];
        [completeTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left);
            make.top.equalTo(topView.mas_bottom).mas_offset(labelOffset);
        }];
        topView = completeTimeLabel;
    }
    //退款编号
    if(JMIsEmpty(self.orderData.afterSaleNo) == NO){
        NSString *afterSaleNoInfo = [NSString stringWithFormat:@"退款单号:%@",self.orderData.afterSaleNo];
        UILabel *afterSaleNoLabel = [self orderInfoLabalWithContent:afterSaleNoInfo];
        [view addSubview:afterSaleNoLabel];
        [afterSaleNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left);
            make.top.equalTo(topView.mas_bottom);
        }];
        topView = afterSaleNoLabel;
    }
    //申请退款时间
    if(JMIsEmpty(self.orderData.applyAfterSaleTime) == NO){
        NSString *applyAfterSaleTimeInfo = [NSString stringWithFormat:@"申请退款时间:%@",self.orderData.applyAfterSaleTime];
        UILabel *applyAfterSaleTimeLabel = [self orderInfoLabalWithContent:applyAfterSaleTimeInfo];
        [view addSubview:applyAfterSaleTimeLabel];
        [applyAfterSaleTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left);
            make.top.equalTo(topView.mas_bottom).mas_offset(labelOffset);
        }];
        topView = applyAfterSaleTimeLabel;
    }
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view.mas_bottom);
    }];
    return view;
}

#pragma mark - Private
-(UIView *)orderInfoPayTypeView{
    //支付方式view
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    
    UIColor *fontColor = [UIColor colorWithHexString:@"#666666"];
    UIFont *labelFont = [UIFont systemFontOfSize:14.0];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.font = labelFont;
    tipLabel.textColor = fontColor;
    tipLabel.text = @"支付方式：";
    [view addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left);
        make.centerY.equalTo(view);
    }];
    //支付图标
    UIImageView *typeIconView = [[UIImageView alloc] init];
    typeIconView.image = [UIImage imageNamed:@"zfb_ic"];
    [view addSubview:typeIconView];
    [typeIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tipLabel.mas_right).offset(5);
        make.centerY.equalTo(view);
    }];
    
    UILabel *typeLabel = [[UILabel alloc] init];
    typeLabel.textColor = fontColor;
    typeLabel.font = labelFont;
    typeLabel.text = @"支付宝支付";
    [view addSubview:typeLabel];
    [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(typeIconView.mas_right).offset(2);
        make.centerY.equalTo(view);
    }];
    return view;
}

-(UILabel *)orderInfoLabalWithContent:(NSString *)content{
    if(JMIsEmpty(content)){
        return nil;
    }
    UILabel *label = [[UILabel alloc] init];
    UIColor *fontColor = [UIColor colorWithHexString:@"#666666"];
    UIFont *labelFont = [UIFont systemFontOfSize:14.0];
    label.textColor = fontColor;
    label.font = labelFont;
    label.text = content;
    return label;
}



@end
