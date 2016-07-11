//
//  SelectColorView.m
//  画板
//
//  Created by YinMingpu on 16/5/11.
//  Copyright © 2016年 YinMingpu. All rights reserved.
//

#import "SelectColorView.h"

@interface SelectColorView ()

{
    
    SelectColorBlock _selectColorBlock;
}

@end

@implementation SelectColorView

-(void)afterSelected:(SelectColorBlock)selectBlock{
    
    _selectColorBlock = selectBlock;
    
}

//选中的时候传值，吧选中的颜色传到_selectColorBlock（）
-(void)selectChangeItem:(UIButton *)sender{
    
    _selectColorBlock(self.contentArray[sender.tag-100]);
}

@end
