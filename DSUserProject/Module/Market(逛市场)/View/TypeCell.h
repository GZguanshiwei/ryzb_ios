//
//  TypeCell.h
//  JMBaseProject
//
//  Created by Liuny on 2019/6/21.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TypeCell : UICollectionViewCell
-(void)updateWithTitle:(NSString *)title isSelect:(BOOL)isSelect;
@end

NS_ASSUME_NONNULL_END
