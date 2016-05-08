//
//  LFGridView.h
//  LittleFun
//
//  Created by 张迪 on 16/5/1.
//  Copyright © 2016年 张迪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LFGridView : UIView

/**
 *  网格间距，默认30
 */
@property (nonatomic, assign) CGFloat   gridSpacing;

/**
 *  网格线宽度，默认为1 pixel (1.0f / [UIScreen mainScreen].scale)
 */
@property (nonatomic, assign) CGFloat   gridLineWidth;

/**
 *  网格颜色，默认蓝色
 */
@property (nonatomic, strong) UIColor   *gridColor;

@end
