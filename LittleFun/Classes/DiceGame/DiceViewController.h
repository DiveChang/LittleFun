//
//  DiceViewController.h
//  LittleFun
//
//  Created by 张迪 on 16/4/27.
//  Copyright © 2016年 张迪. All rights reserved.
//


/*
 * 掷骰子游戏
 */

#import <UIKit/UIKit.h>
#import "DiceView.h"
#import <AVFoundation/AVFoundation.h>

@interface DiceViewController : UIViewController
{
    DiceView *_diceView;
    UIButton *_gameStartButton;
}


@property(nonatomic,strong) AVAudioPlayer *avAudioPlayer;

- (void)startDiceGame;

@end
