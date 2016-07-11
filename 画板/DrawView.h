//
//  DrawView.h
//  画板
//
//  Created by YinMingpu on 16/5/11.
//  Copyright © 2016年 YinMingpu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawView : UIView

@property (nonatomic,strong) UIColor *drawColor;
@property (nonatomic,assign) CGFloat drawLineWidth;

- (void)undo;

- (void)clear;

- (void)save;

@end
