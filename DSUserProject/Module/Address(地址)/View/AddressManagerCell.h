//
//  AddressManagerCell.h
//  JMBaseProject
//
//  Created by Liuny on 2019/1/5.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AddressManagerCellDelegate <NSObject>

-(void)addressDidDelete:(NSInteger)index;
-(void)addressDidChangeDefault:(NSInteger)index;
-(void)addressDidEdit:(NSInteger)index;

@end

@interface AddressManagerCell : UITableViewCell
@property (nonatomic, strong) AddressModel *cellData;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, weak) id<AddressManagerCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
