//
//  ViewController.m
//  画板
//
//  Created by YinMingpu on 16/5/11.
//  Copyright © 2016年 YinMingpu. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"
#import "ToolView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //画板
    DrawView *drawView = [[DrawView alloc]initWithFrame:self.view.frame];
    drawView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:drawView];
    
    //工具
    NSArray *contentArray = @[@"颜色",@"线宽",@"橡皮",@"撤销",@"清屏",@"相机",@"保存"];
    
    ToolView *toolView = [[ToolView alloc]initWithFrame:CGRectMake(0, 0, 414, 50) WithArray:contentArray];
    //
    [toolView afterSelectColor:^(UIColor *color) {
        
        drawView.drawColor = color;
        
        
    } afterSelectLineWidth:^(CGFloat lineWidth) {
        
        drawView.drawLineWidth = lineWidth;
        
    }];
    
    
    
    //
    [toolView clickEraserBlock:^{
        
        drawView.drawColor = [UIColor whiteColor];
        
    } WithUndoBlock:^{
        
        [drawView undo];
        
        
    } WithClearBlock:^{
        
        [drawView clear];
        
    } WithSaveBlock:^{
        
        [drawView save];
    }];
    
    toolView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:toolView];
    
    
}


@end
