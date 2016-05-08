//
//  DiceView.h
//  LittleFun
//
//  Created by 张迪 on 16/4/27.
//  Copyright © 2016年 张迪. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DiceViewDelegate <NSObject>

- (void)DiceAnimationDidFinish;

@end

@interface DiceView : UIView

@property (nonatomic, assign) id<DiceViewDelegate> delegate;

+ (instancetype)shareDiceView;
- (id)initWithFrame:(CGRect)frame;
// 开始动画
- (void)startDiceAnimation;

// 移除动画
- (void)stopAnimation;
@end
