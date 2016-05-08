//
//  LFGridView.m
//  LittleFun
//
//  Created by 张迪 on 16/5/1.
//  Copyright © 2016年 张迪. All rights reserved.
//

/**
 * gridView For SnakeGame
 */

#import "LFGridView.h"


#define SINGLE_LINE_WIDTH           (1/[UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1/[UIScreen mainScreen].scale)/2)
#define SCREENSCALE                 [UIScreen mainScreen].scale

@implementation LFGridView

@synthesize gridColor = _gridColor;
@synthesize gridSpacing = _gridSpacing;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _gridColor = [UIColor blueColor];
        _gridLineWidth = SINGLE_LINE_WIDTH;
        _gridSpacing = 30;
    }
    return self;
}

- (void)setGridColor:(UIColor *)gridColor
{
    _gridColor = gridColor;
    [self setNeedsDisplay];
}

- (void)setGridSpacing:(CGFloat)gridSpacing
{
    _gridSpacing = gridSpacing;
    [self setNeedsDisplay];
}

- (void)setGridLineWidth:(CGFloat)gridLineWidth
{
    _gridLineWidth = gridLineWidth;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGFloat lineMargin = self.gridSpacing;
    /**
     * 仅当要绘制的线宽为奇数像素时，绘制位置需要调整
     */
    
    CGFloat pixelAdjustOffset = 0;
    
    if (((int)(self.gridLineWidth * SCREENSCALE) + 1) % 2 == 0) {
        pixelAdjustOffset = SINGLE_LINE_ADJUST_OFFSET;
    }
    
    CGFloat xPos = 0;
    CGFloat yPos = 0;
    
    // 纵向的线
    while (xPos <= self.bounds.size.width) {
        CGContextMoveToPoint(context, xPos, 0);
        CGContextAddLineToPoint(context, xPos, self.bounds.size.height);
        xPos += lineMargin;
    }
    
    // 横向的线
    while (yPos <= self.bounds.size.height) {
        CGContextMoveToPoint(context, 0, yPos);
        CGContextAddLineToPoint(context, self.bounds.size.width, yPos);
        yPos += lineMargin;
    }
    
    CGContextSetLineWidth(context, self.gridLineWidth);
    CGContextSetStrokeColorWithColor(context, self.gridColor.CGColor);
    CGContextStrokePath(context);
}

@end
