//
//  DrawView.m
//  画板
//
//  Created by YinMingpu on 16/5/11.
//  Copyright © 2016年 YinMingpu. All rights reserved.
//

#import "DrawView.h"
#import "PathModel.h"

@interface DrawView ()

//当前正在绘制的路径
@property (nonatomic,assign) CGMutablePathRef path;

//已经绘制过的路径
@property(nonatomic,strong)NSMutableArray *pathArray;

//判断当前路径是否被释放
@property(nonatomic,assign)BOOL isPathReleased;

@end
@implementation DrawView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.drawColor = [UIColor blueColor];
        self.drawLineWidth = 2;
        
    }
    return self;
}


-(void)drawRect:(CGRect)rect{
    //1. 获取到与试图相关联的上下文对象(相当于获取到画笔)
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawView:context];
    
}

#pragma mark 触摸
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //起点
    CGPoint point = [[touches anyObject]locationInView:self];
    
    //新建路径时，表明路径没有被释放
    self.isPathReleased = NO;
    
    //2. 创建及设置路径（path)
    self.path = CGPathCreateMutable();
    //起点
    CGPathMoveToPoint(self.path, NULL, point.x, point.y);
}

//移动不断循环调用 追加路径
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGPoint point = [[touches anyObject]locationInView:self];
    //追加
    CGPathAddLineToPoint(self.path, NULL, point.x, point.y);
    
    //不能直接调用drawRect，使用setNeedsDisplay来触发 调用drawRect执行
    [self setNeedsDisplay];
    
}

//绘制结束，手指松开调用
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    if (self.pathArray == nil) {
        self.pathArray = [NSMutableArray array];
    }
    
    //使用贝塞尔曲线，将CGPath包装成对象
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithCGPath:self.path];
    
    PathModel *pathModel = [[PathModel alloc]init];
    
    pathModel.bezierPath = bezierPath;
    pathModel.color = self.drawColor;
    pathModel.lineWidth = self.drawLineWidth;
    
    
    [self.pathArray addObject:pathModel];
    
    
    //释放
    CGPathRelease(self.path);
    
    //路径被释放了
    self.isPathReleased = YES;
}

//绘制
-(void)drawView:(CGContextRef )context{
    
    for (PathModel *pathModel in self.pathArray) {
        
        CGContextAddPath(context, pathModel.bezierPath.CGPath);
        
        [pathModel.color setStroke];
        
        CGContextSetLineWidth(context, pathModel.lineWidth);
        
        CGContextDrawPath(context, kCGPathStroke);
        
    }
    if (self.isPathReleased == NO) {
        
    
    //将路径添加到上下文
    CGContextAddPath(context, self.path);
    //状态
//    [[UIColor redColor]setStroke];
//    CGContextSetLineWidth(context, 2);
        [self.drawColor setStroke];
        CGContextSetLineWidth(context, self.drawLineWidth);
    
    //绘制
    CGContextDrawPath(context, kCGPathStroke);
        
    }
}

- (void)undo{
    
    [self.pathArray removeLastObject];
    
    //不能直接调用drawRect，使用setNeedsDisplay来触发 调用drawRect执行
    [self setNeedsDisplay];
    
}

- (void)clear{
    
    [self.pathArray removeAllObjects];
    
    //不能直接调用drawRect，使用setNeedsDisplay来触发 调用drawRect执行
    [self setNeedsDisplay];
}

- (void)save{
    
    UIGraphicsBeginImageContext(CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)));
    
    //获取到当前指定试图上的内容，并把它放到画板上面
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, NULL);
    
}


@end
