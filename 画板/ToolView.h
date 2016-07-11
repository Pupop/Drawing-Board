//
//  ToolView.h
//  画板
//
//  Created by YinMingpu on 16/5/11.
//  Copyright © 2016年 YinMingpu. All rights reserved.
//

#import "BaseView.h"
#import "SelectColorView.h"
#import "SelectLineView.h"
typedef void(^ToolActionBlock)(void);

@interface ToolView : BaseView

-(void)afterSelectColor:(SelectColorBlock)selectColorBlock afterSelectLineWidth:(SelectLineWidthBlock)selectLineWidthBlock;

- (void)clickEraserBlock:(ToolActionBlock)araserBlock WithUndoBlock:(ToolActionBlock)undoBlock WithClearBlock:(ToolActionBlock)clearBlock WithSaveBlock:(ToolActionBlock)saveBlock;

@end
