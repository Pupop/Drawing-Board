//
//  SelectLineView.m
//  画板
//
//  Created by YinMingpu on 16/5/11.
//  Copyright © 2016年 YinMingpu. All rights reserved.
//

#import "SelectLineView.h"

@interface SelectLineView ()

{
    SelectLineWidthBlock _selectLineWidthBlock;
    
}

@end

@implementation SelectLineView


- (void)afterSelectLineWidth:(SelectLineWidthBlock)selectLineWidthBlock{
    
    _selectLineWidthBlock = selectLineWidthBlock;
}


- (void)selectChangeItem:(UIButton *)sender{
    
    float lineWidth = [self.contentArray[sender.tag-100] floatValue];
    
    _selectLineWidthBlock(lineWidth);
    
}


@end
