//
//  LHSnakeView.m
//  LittleFun
//
//  Created by 张迪 on 16/5/7.
//  Copyright © 2016年 张迪. All rights reserved.
//

#import "LFSnakeView.h"

#define CELL_SIZE 10.0f

@implementation LFSnakeView 
{
    NSMutableArray *_sankeData;// 记录整条蛇的点,最后一个代表蛇头
    
    // 记录食物的位置
    LFPoint *_foodPos;
    
    // 食物的图片
    UIImage *_foodImage;
    
    // 游戏结束提示框
    UIAlertView *_gameOverAlert;
    
    // 代表游戏音效变量
    SystemSoundID _gu;
    SystemSoundID _crash;
    
    // 时间器
    NSTimer *_timer;
    
    // 宽高的格子数
    NSInteger _width;
    NSInteger _height;
    
    // 网格
    LFGridView *_gridView;

}

@synthesize snakeOrient;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        //  食物图片
        _foodImage = [UIImage imageNamed:@"app"];
        
        // 读取音效文件
        NSURL *guURL = [[NSBundle mainBundle] URLForResource:@"gu" withExtension:@"mp3"];
        NSURL *crashURL = [[NSBundle mainBundle] URLForResource:@"crash" withExtension:@"mp3"];
        
        // 加载两个音效文件
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)guURL , &_gu);
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)crashURL , &_crash);
        
        // 游戏结束警示框
        _gameOverAlert = [[UIAlertView alloc] initWithTitle:@"游戏结束" message:@"是否继续游戏？" delegate:self cancelButtonTitle:@"不继续" otherButtonTitles:@"再来一局", nil];
       
        _width = (NSInteger)self.bounds.size.width/CELL_SIZE;
        _height = (NSInteger)self.bounds.size.height/CELL_SIZE;

        [self initGridView];
        
        [self startGame];
    }
    
    return  self;
}

- (void)startGame {
    // 游戏开始初始化
    _sankeData = [NSMutableArray arrayWithObjects:
                    [[LFPoint alloc] initWithX:1 andY:0],
                    [[LFPoint alloc] initWithX:2 andY:0],
                    [[LFPoint alloc] initWithX:3 andY:0],
                    [[LFPoint alloc] initWithX:4 andY:0], nil];
    
    // 初始化起始的方向
    snakeOrient = kRight;
    
    // 初始化时间器
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.3f target:self selector:@selector(snakeRunning) userInfo:nil repeats:YES];
    
}

- (void)snakeRunning {
    // 修改snake位置
    LFPoint *first = [_sankeData objectAtIndex:_sankeData.count-1];
    LFPoint *headPoint = [[LFPoint alloc] initWithX:first.x andY:first.y];
    switch (snakeOrient) {
        case kUp:
            headPoint.y -= 1;
            break;
        case kDown:
            headPoint.y += 1;
            break;
        case kLeft:
            headPoint.x -= 1;
            break;
        case kRight:
            headPoint.x += 1;
            break;
            
        default:
            break;
    }
    
    // 判断是否发生碰撞
    if (headPoint.x < 0 || headPoint.x > _width-1 || headPoint.y < 0 || headPoint.y > _height-1 || [_sankeData containsObject:headPoint]) {
        // 播放碰撞的音效  游戏结束 时间器停止
        AudioServicesPlaySystemSound(_crash);
        [_gameOverAlert show];
        [_timer invalidate];
    }
    
    // 吃到食物
    if ([headPoint isEqual:_foodPos]) {
        // 播放吃食物的音效
        AudioServicesPlaySystemSound(_gu);
        // 将食物点添加成新的蛇头
        [_sankeData addObject:_foodPos];
        // 食物清空
        _foodPos = nil;
    } else {
        // 从第一个点开始控制蛇身前进 (蛇头已经前进)
        for (int i = 0; i<_sankeData.count-1; i++) {
            // 将第i的坐标设为第i+1个的坐标
            LFPoint *curPoint = [_sankeData objectAtIndex:i];
            LFPoint *nextPoint = [_sankeData objectAtIndex:i+1];
            curPoint.x = nextPoint.x;
            curPoint.y = nextPoint.y;
        }
        [_sankeData setObject:headPoint atIndexedSubscript:_sankeData.count-1];
        
        if (_foodPos == nil) {
            while(true)
            {
                LFPoint* newFoodPos = [[LFPoint alloc]
                                       initWithX:arc4random() % _width andY:
                                       arc4random() % _height];
                // 如果新产生的食物点没有位于蛇身上
                if(![_sankeData containsObject:newFoodPos])
                {  
                    _foodPos = newFoodPos;
                    break; // 成功生成了食物的位置，跳出循环  
                }  
            }
        }
    }
    
    [self setNeedsDisplay];
    
}


- (void)drawRect:(CGRect)rect
{
    // 获取回头API
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, [UIColor brownColor].CGColor);
    // 绘制背景
    CGContextFillRect(ctx, self.bounds);

#if 0
    // 绘制文字
    [@"疯狂贪食蛇" drawAtPoint:CGPointMake(50 ,20)
           withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                           [UIFont fontWithName:@"Heiti SC" size: 40] , NSFontAttributeName,
                           [UIColor colorWithRed:1 green:0 blue:1 alpha:.4],
                           NSForegroundColorAttributeName, nil]];
    [@"www.fkjava.org" drawAtPoint:CGPointMake(50 ,60)
                    withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIFont fontWithName:@"Heiti SC" size: 26] , NSFontAttributeName,  
                                    [UIColor colorWithRed:1 green:0 blue:1 alpha:.4],  
                                    NSForegroundColorAttributeName, nil]];
#endif
    
    // 设置蛇的填充颜色
    CGContextSetRGBFillColor(ctx, 1, 1, 0, 1);
    // 遍历数组 绘制蛇图
    for (int i=0; i<_sankeData.count; i++) {
        LFPoint *point = [_sankeData objectAtIndex:i];
        CGRect rect = CGRectMake(point.x * CELL_SIZE, point.y*CELL_SIZE, CELL_SIZE, CELL_SIZE);
        // 绘制蛇尾巴，让蛇的尾巴小一些
        if (i < 4) {
            CGFloat inset = (4 - i);
            CGContextFillEllipseInRect(ctx,CGRectInset(rect, inset, inset));
        } else {
            CGContextFillEllipseInRect(ctx, rect);
        }
    }
    
    // 绘制食物图片
//    [_foodImage drawAtPoint:CGPointMake(_foodPos.x*CELL_SIZE, _foodPos.y*CELL_SIZE)];
    [_foodImage drawInRect:CGRectMake(_foodPos.x*CELL_SIZE, _foodPos.y*CELL_SIZE, CELL_SIZE, CELL_SIZE)];
}

#pragma mark - 网格
- (void)initGridView {
    CGFloat gridViewHeight = self.bounds.size.height;
    CGFloat gridViewWidth = self.bounds.size.width;
    
    LFGridView *gridView = [[LFGridView alloc] initWithFrame:CGRectMake(0, 0, gridViewWidth, gridViewHeight)];
    gridView.gridColor = [UIColor lightGrayColor];
    gridView.backgroundColor = [UIColor clearColor];
    gridView.gridSpacing = CELL_SIZE;
    
    [self addSubview:gridView];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // 如果用户单击了第2 个按钮，则重新开始游戏
    if(buttonIndex == 1) [self startGame];
}

- (void) stopSnake {
    [_timer invalidate];
    _timer = nil;

}

@end
