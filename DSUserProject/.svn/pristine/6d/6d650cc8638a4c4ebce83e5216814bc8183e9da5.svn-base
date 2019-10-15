//
//  MarkListhHeadCell.h
//  JMBaseProject
//
//  Created by 潘传标 on 2019/9/3.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
static NSString *markListhHeadCellID = @"MarkListhHeadCellID";
@class LiveRoomModel;
@interface MarkListhHeadCell : UICollectionViewCell
@property(nonatomic,copy)void(^showAllAttentionBlock)(void);
@property(nonatomic,copy)void(^selectTypeBlock)(NSString *flagID);
@property(nonatomic,copy)void(^showMyAttenionBlock)(LiveRoomModel *model);
-(void)reloadAttionList;
@end

NS_ASSUME_NONNULL_END
