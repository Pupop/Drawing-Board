//
//  ToolView.m
//  画板
//
//  Created by YinMingpu on 16/5/11.
//  Copyright © 2016年 YinMingpu. All rights reserved.
//

#import "ToolView.h"
#import "SelectColorView.h"
#import "SelectLineView.h"

typedef enum : NSUInteger {
    kColorSelect = 100,
    kLineWidthSelect,
    KEraserSelect,
    kUndoSelect,
    kClearScreenSelect,
    kcameraSelect,
    kSaveSelect
} kSelectItem;

@interface ToolView ()
{
    SelectLineWidthBlock _selectLineWidthBlock;
    SelectColorBlock _selectColorBlock;
    
    ToolActionBlock _araserBlock;
    ToolActionBlock _undoBlock;
    ToolActionBlock _clearBlock;
    ToolActionBlock _saveBlock;

}


//颜色选择视图
@property (nonatomic,strong)SelectColorView *selectColorView;
//线宽选择视图
@property(nonatomic,strong)SelectLineView *selectLineWidthView;

@end

@implementation ToolView

-(void)selectChangeItem:(UIButton *)sender{
    
    switch (sender.tag) {
            
        case kColorSelect:{
            
            [self forceHideView:self.selectColorView];
            [self showHideColorSelectView];
            
        }break;
            
        case kLineWidthSelect:{
            
            [self forceHideView:self.selectLineWidthView];
            [self showHideLineSelectView];
            
        }break;
            
        case KEraserSelect:{
            
            _araserBlock();
            
        }break;
            
        case kUndoSelect:{
            
            _undoBlock();
            
        }break;
            
        case kClearScreenSelect:{
            
            _clearBlock();
            
        }break;
            
        case kSaveSelect:{
            
            _saveBlock();
            
        }break;
    }
    
}

//让线宽选择视图显示或隐藏
-(void)showHideLineSelectView{
    if (self.selectLineWidthView == nil) {
        
        NSArray *contentArray = @[@"2",@"5",@"8",@"12",@"15",@"18"];
        
        self.selectLineWidthView = [[SelectLineView alloc]initWithFrame:CGRectMake(0, - 50, 414, 50) WithArray:contentArray];
        self.selectLineWidthView.backgroundColor = [UIColor cyanColor];
        
        //调用SelectLineView里面的Block方法，传送lineWidth值
        [self.selectLineWidthView afterSelectLineWidth:^(CGFloat lineWidth) {
            
            //调用本类声明的Block方法，把lineWidth继续传
            _selectLineWidthBlock(lineWidth);
            [self forceHideView:nil];
        }];
        
        [self addSubview:self.selectLineWidthView];
        
    }
    
    [self showHideView:self.selectLineWidthView];
    
}



//让颜色选择视图显示或隐藏
-(void)showHideColorSelectView{
    
    if (self.selectColorView == nil) {
        NSArray *contentArray = @[[UIColor redColor],[UIColor greenColor],
                                  [UIColor blueColor],
                                  [UIColor yellowColor],
                                  [UIColor orangeColor],
                                  [UIColor purpleColor],
                                  [UIColor cyanColor],
                                  [UIColor blackColor]];
        
        self.selectColorView = [[SelectColorView alloc]initWithFrame:CGRectMake(0, - 50, 414, 50) WithArray:contentArray];
        
        [self.selectColorView afterSelected:^(UIColor *color) {
            
            _selectColorBlock(color);
            [self forceHideView:nil];
        }];
        
        self.selectColorView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.selectColorView];
    }
    
    [self showHideView:self.selectColorView];
}

//让视图动画式消失
-(void)showHideView:(UIView *)view{
    
    //保存要消失或出现视图的frame
    CGRect toFrame = view.frame;
    //保存当前工具栏的frame
    CGRect toolFrame = self.frame;
    
    if (toFrame.origin.y>0) {
        
        toFrame.origin.y = -50;
        toolFrame.size.height = 50;
    }else{
        
        toFrame.origin.y = 50;
        toolFrame.size.height = 100;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        
        view.frame = toFrame;
        self.frame = toolFrame;
        
    }];
    
}
//强制隐藏视图
-(void)forceHideView:(UIView *)view{
    //如果点击Btn出现的正好是此Btn对应的视图，此方法return,不执行，调用showHideView去执行；
    UIView *showView = nil;
    if (self.selectColorView.frame.origin.y>0) {
        
        showView = self.selectColorView;
    }else if (self.selectLineWidthView.frame.origin.y>0){
        
        showView = self.selectLineWidthView;
    }else{
        return;
    }
    if (view == showView) {
        return;
    }
    
    //如果点击Btn时出现的不是自己对应的视图，则把出现的视图隐藏，调用showHideView显示此Btn对应的视图；
    CGRect toFrame = showView.frame;
    
    CGRect toolFrame = self.frame;
    
    toFrame.origin.y = -50;
    toolFrame.size.height = 50;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        showView.frame = toFrame;
        self.frame = toolFrame;
        
    }];
    
}



//实现Block并搞成全局，一遍调用
-(void)afterSelectColor:(SelectColorBlock)selectColorBlock afterSelectLineWidth:(SelectLineWidthBlock)selectLineWidthBlock{
    
    _selectColorBlock = selectColorBlock;
    _selectLineWidthBlock = selectLineWidthBlock;
}

- (void)clickEraserBlock:(ToolActionBlock)araserBlock WithUndoBlock:(ToolActionBlock)undoBlock WithClearBlock:(ToolActionBlock)clearBlock WithSaveBlock:(ToolActionBlock)saveBlock{
    
    _araserBlock = araserBlock;
    _undoBlock = undoBlock;
    _clearBlock = clearBlock;
    _saveBlock = saveBlock;
    
}


@end
