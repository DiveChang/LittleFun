
//
//  DiceView.m
//  LittleFun
//
//  Created by 张迪 on 16/4/27.
//  Copyright © 2016年 张迪. All rights reserved.
//

#import "DiceView.h"

#define AnimationTargetDuration 2.0f // 动画将要执行多久
#define TimeInterval 0.1f // 时间器的间隔

#define DiceCountDefault 1

@implementation DiceView
{
    UIImageView *_diceImageView;
    CAKeyframeAnimation *_diceAnimation;
}

+ (instancetype)shareDiceView
{
    static DiceView *shareDiceView = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareDiceView = [[self alloc] init];
    });
    
    return shareDiceView;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addImageViewWithDiceCount:DiceCountDefault];
    }
    return self;
}

- (void)addImageViewWithDiceCount:(NSInteger)diceCount
{
    _diceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _diceImageView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [self setDiceImage];
    [self addSubview:_diceImageView];
    
    NSMutableArray *diceImgArray = [NSMutableArray array];
    for (int i = 1; i < 15; i++) {
        UIImage *diceAniImage = [UIImage imageNamed:[NSString stringWithFormat:@"AniDice%d",i]];
        CGImageRef cgimg = diceAniImage.CGImage;
        [diceImgArray addObject:(__bridge UIImage *)cgimg];
    }
    
    //创建CAKeyframeAnimation
    _diceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    _diceAnimation.duration = AnimationTargetDuration;
    _diceAnimation.delegate = self;
    _diceAnimation.values = diceImgArray;
}

#pragma mark - 开始动画
- (void)startDiceAnimation{
    if (self.subviews.count) {
        [_diceImageView startAnimating];
        [_diceImageView.layer addAnimation:_diceAnimation forKey:nil];
    }
}


// 改变骰子图片
- (void)setDiceImage {

    NSInteger currentNumber = arc4random()%6 + 1;
    _diceImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"dice_%d",(int)currentNumber]];
}

- (void)stopAnimation {
    [_diceImageView.layer removeAllAnimations];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self setDiceImage];
    if (self.delegate) {
        [self.delegate DiceAnimationDidFinish];
    }
}

@end
