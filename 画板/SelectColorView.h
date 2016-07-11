//
//  SelectColorView.h
//  画板
//
//  Created by YinMingpu on 16/5/11.
//  Copyright © 2016年 YinMingpu. All rights reserved.
//

#import "BaseView.h"

typedef void(^SelectColorBlock)(UIColor *color);

@interface SelectColorView : BaseView

-(void)afterSelected:(SelectColorBlock)selectBlock;

@end
