//
//  SnakeViewController.m
//  LittleFun
//
//  Created by 张迪 on 16/5/1.
//  Copyright © 2016年 张迪. All rights reserved.
//

#import "SnakeViewController.h"
#define GridViewSpacing 10

@interface SnakeViewController ()
{
    LFSnakeView *_snakeView;
}

@end

@implementation SnakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    self.navigationItem.title = @"贪食蛇";

    [self initSnakeView];
}

- (void) initSnakeView {
 
    CGFloat gridViewY = 150;
    CGFloat gridViewHeight = ((int)(kScreenHeight - gridViewY - 40))/((int)GridViewSpacing) * GridViewSpacing;
    CGFloat gridViewX = 20;
    CGFloat gridViewWidth = ((int)(kScreenWidth-gridViewX*2))/((int)GridViewSpacing) * GridViewSpacing;
    
    _snakeView = [[LFSnakeView alloc] initWithFrame:CGRectMake(gridViewX, gridViewY, gridViewWidth, gridViewHeight)];
    [self.view addSubview:_snakeView];
    
    //添加手势
    [self addGestureReconizer];
}


- (void)addGestureReconizer {
    // 设置self.view 控件支持用户交互
    self.view.userInteractionEnabled = YES;
    // 设置self.view 控件支持多点触碰
    self.view.multipleTouchEnabled = YES;
    
    for (int i = 0 ; i < 4 ; i++)
    {
        // 创建手势处理器，指定使用该控制器的handleSwipe:方法处理轻扫手势
        UISwipeGestureRecognizer* gesture = [[UISwipeGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(handleSwipe:)];
        // 设置该手势处理器只处理i 个手指的轻扫手势
        gesture.numberOfTouchesRequired = 1;
        // 指定该手势处理器只处理1 << i 方向的轻扫手势
        gesture.direction = 1 << i;  
        // 为self.view 控件添加手势处理器  
        [self.view addGestureRecognizer:gesture];  
    }  

}

- (void)handleSwipe:(UISwipeGestureRecognizer *)swapGesture {
    // 获取轻扫手势的方向
    NSUInteger direction = swapGesture.direction;
    switch (direction)
    {
        case UISwipeGestureRecognizerDirectionLeft:
            if(_snakeView.snakeOrient != kRight) // 只要不是向右，即可改变方向
                _snakeView.snakeOrient = kLeft;
            break;
        case UISwipeGestureRecognizerDirectionUp:
            if(_snakeView.snakeOrient != kDown) // 只要不是向下，即可改变方向
                _snakeView.snakeOrient = kUp;
            break;
        case UISwipeGestureRecognizerDirectionDown:
            if(_snakeView.snakeOrient != kUp) // 只要不是向上，即可改变方向
                _snakeView.snakeOrient = kDown;
            break;
        case UISwipeGestureRecognizerDirectionRight:  
            if(_snakeView.snakeOrient != kLeft) // 只要不是向左，即可改变方向
                _snakeView.snakeOrient = kRight;
            break;  
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [_snakeView stopSnake];
}



@end
