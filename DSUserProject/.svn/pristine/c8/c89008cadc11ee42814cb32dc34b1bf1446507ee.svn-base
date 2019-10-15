//
//  ReceiveGiftManager.m
//  JMBaseProject
//
//  Created by liuny on 2018/7/13.
//  Copyright © 2018年 liuny. All rights reserved.
//

#import "ReceiveGiftManager.h"
#import "ReceiveGiftView.h"

#import "LiveEnterRoomView.h"
#import "LiveShowGiftView.h"
@interface ReceiveGiftManager()
@property (nonatomic, strong) NSMutableArray *giftAnimViews;
@property (nonatomic, strong) NSMutableArray *positions;
//保存收到的礼物
@property (nonatomic, strong) NSMutableArray *giftQueue;
@end

@implementation ReceiveGiftManager
-(NSMutableArray *)giftQueue{
    if (_giftQueue == nil) {
        _giftQueue = [NSMutableArray array];
    }
    return _giftQueue;
}

-(NSMutableArray *)giftAnimViews
{
    if (_giftAnimViews == nil) {
        _giftAnimViews = [NSMutableArray array];
    }
    return _giftAnimViews;
}

-(NSMutableArray *)positions{
    if(_positions == nil){
        _positions = [NSMutableArray array];
    }
    return _positions;
}

-(BOOL)isComboGift:(TCMsgModel *)gift{
    return NO;
//    TCMsgModel *comboGift = nil;
//    for (TCMsgModel *giftItem in self.giftQueue) {
//        // 如果是连发礼物就记录下来
////        if (giftItem.gift.giftId == gift.gift.giftId && giftItem.sendUser.userId == gift.sendUser.userId) {
////            comboGift = giftItem;
////            break;
////        }
//    }
//    if (comboGift) { // 连发礼物有值
//        // 礼物模型的礼物总数+1
////        comboGift.giftNum += 1;
//        return YES;
//    }
    return NO;
}

-(void)handleGiftAnim:(TCMsgModel *)gift
{
     UIView * giftView = [[UIView alloc]init];
       if (gift.msgType == 11) {
             // 1.创建礼物动画的View
             LiveShowGiftView *giftViews = [[LiveShowGiftView alloc] initWithXib];
             // 3.传递礼物模型
             giftViews.gift = gift;
             __weak typeof(self) weakSelf = self;
             giftViews.dismissViewBlock = ^(LiveShowGiftView *giftView){
                 [weakSelf dismissView:giftView];
             };
           giftView = giftViews;
       }else{
           // 1.创建礼物动画的View
             LiveEnterRoomView *giftViews = [[LiveEnterRoomView alloc] initWithXib];
             // 3.传递礼物模型
             giftViews.gift = gift;
             __weak typeof(self) weakSelf = self;
             giftViews.dismissViewBlock = ^(LiveEnterRoomView *giftView){
                 [weakSelf dismissView:giftView];
             };
              giftView = giftViews;
       }
     
       
       
       // 2.设置礼物View的frame
       CGRect frame = giftView.bounds;
       frame.origin.y = self.giftShowView.mj_h - frame.size.height;
       giftView.frame = frame;
       //获取开头的view
       UIView  * beforeGift = [self.giftAnimViews firstObject];
       
     
       
       // 添加礼物View
       [self.giftShowView addSubview:giftView];
       // 添加记录礼物View数组
       [self.giftAnimViews addObject:giftView];
       
       
       // 设置动画
       giftView.transform = CGAffineTransformMakeTranslation(-giftView.mj_w, 0);
       [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
           giftView.transform = CGAffineTransformIdentity;
           if(beforeGift){
               //更新上一个礼物的位置
               CGRect oldframe = beforeGift.frame;
               oldframe.origin.y = 0;
               beforeGift.frame = oldframe;
           }
       } completion:^(BOOL finished) {
           // 开始连击动画
           if ([giftView isKindOfClass:[LiveEnterRoomView class]]) {
                     LiveEnterRoomView * view = (LiveEnterRoomView *)giftView;
                     [view hideView];
                 }else if([giftView isKindOfClass:[LiveShowGiftView class]]){
                     LiveShowGiftView * view = (LiveShowGiftView *)giftView;
                     [view hideView];
                 }
       }];
}

- (void)dismissView:(UIView *)giftView{
     [UIView animateWithDuration:1 animations:^{
           giftView.alpha = 0;
           giftView.transform = CGAffineTransformMakeTranslation(0, -giftView.mj_h);
       } completion:^(BOOL finished) {
           if ([giftView isKindOfClass:[LiveEnterRoomView class]]) {
               LiveEnterRoomView * view = (LiveEnterRoomView *)giftView;
                 [self.giftQueue removeObject:view.gift];
           }else if([giftView isKindOfClass:[LiveShowGiftView class]]){
               LiveShowGiftView * view = (LiveShowGiftView *)giftView;
                            [self.giftQueue removeObject:view.gift];
           }
        
        // 移除当前动画的View
        [giftView removeFromSuperview];
        
        // 移除礼物动画View数组
        [self.giftAnimViews removeObject:giftView];
        
        // 判断队列中是否还有未处理的礼物
        TCMsgModel *item = [self fetchNoHandleGiftItemOfQueue];
        
        // 处理礼物动画
        if (item) {
            [self handleGiftAnim:item];
        }
    }];
}

// 搜索礼物队列中未执行的礼物
- (TCMsgModel *)fetchNoHandleGiftItemOfQueue{
    
    // 取出队列中的礼物
    for (TCMsgModel *item in self.giftQueue) {
        // 当前礼物模型有可能在执行
        if (![self isExcutingGift:item]) return item;
    }
    
    return nil;
}

// 判断当前礼物是否正在执行
- (BOOL)isExcutingGift:(TCMsgModel *)gift{
    // 判断当前模型是否已经在执行，执行就不需要在做动画
    for (UIView *giftView in self.giftAnimViews) {
        if ([giftView isKindOfClass:[LiveEnterRoomView class]]) {
                      LiveEnterRoomView * leveEnterview = (LiveEnterRoomView *)giftView;
                         if (leveEnterview.gift == gift) return YES;
                  }else if([giftView isKindOfClass:[LiveShowGiftView class]]){
                      LiveShowGiftView * liveShowview = (LiveShowGiftView *)giftView;
                         if (liveShowview.gift == gift) return YES;
                  }
      
    }
    
    
    return NO;
}

- (void)setupGiftAnim:(TCMsgModel *)gift
{
    // 1.判断当前接收的礼物是否属于连发礼物 属于直接return，不需要在重新创建新的动画View
    if ([self isComboGift:gift]) return;
    
    // 2.添加到礼物队列
    [self.giftQueue addObject:gift];
    
    // 3.判断当前显示多少个礼物动画View
    if (self.giftAnimViews.count == 2) return;
    
    // 4.处理礼物动画
    [self handleGiftAnim:gift];
}
@end
