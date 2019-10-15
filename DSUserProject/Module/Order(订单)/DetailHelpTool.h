//
//  DetailHelpTool.h
//  JMBaseProject
//
//  Created by Liuny on 2019/4/30.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailHelpTool : NSObject

-(instancetype)initWithOrder:(OrderModel *)order;

-(UIView *)orderInfoView;
@end

NS_ASSUME_NONNULL_END
