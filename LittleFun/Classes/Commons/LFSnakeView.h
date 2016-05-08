//
//  LHSnakeView.h
//  LittleFun
//
//  Created by 张迪 on 16/5/7.
//  Copyright © 2016年 张迪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "LFPoint.h"
#import "LFGridView.h"


// 定义移动方向的枚举
typedef enum {
    kDown = 0,
    kLeft,
    kUp,
    kRight
} Orient;


@interface LFSnakeView : UIView <UIAlertViewDelegate>

@property (nonatomic, assign) Orient snakeOrient;

- (void)stopSnake;

@end
