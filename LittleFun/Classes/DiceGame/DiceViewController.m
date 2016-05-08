//
//  DiceViewController.m
//  LittleFun
//
//  Created by 张迪 on 16/4/27.
//  Copyright © 2016年 张迪. All rights reserved.
//

#import "DiceViewController.h"


@interface DiceViewController () <DiceViewDelegate>

@end

@implementation DiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"掷骰子";
    
    [self initDiceView];
    [self initStartGameButton];
}


#pragma  mark - 初始化筛子视图
- (void)initDiceView {

    _diceView = [[DiceView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth-100, kScreenWidth-100)];
    _diceView.center = CGPointMake(kScreenWidth/2, kScreenHeight/2 - 100);
    [self.view addSubview:_diceView];
    _diceView.delegate = self;
}

#pragma mark - 初始化开始按钮
- (void)initStartGameButton {
    _gameStartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _gameStartButton.frame = CGRectMake(0, 0, 200, 40);
    _gameStartButton.center = CGPointMake(kScreenWidth/2, _diceView.frame.origin.y + kScreenHeight - 200);
    [_gameStartButton setTitle:@"Start" forState:UIControlStateNormal];
    [_gameStartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_gameStartButton setBackgroundColor:[UIColor redColor]];
    [_gameStartButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
    [_gameStartButton addTarget:self action:@selector(startDiceGame) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_gameStartButton];
}

#pragma mark - 开始掷骰子游戏
- (void)startDiceGame
{
    _gameStartButton.selected = YES;
    
    [_diceView startDiceAnimation];
    _gameStartButton.userInteractionEnabled = NO;
    
    _avAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"diceVoice" ofType:@"mp3"]] error:nil];
    _avAudioPlayer.volume = 0.8;
    [_avAudioPlayer prepareToPlay];
    [_avAudioPlayer play];
}

- (void)DiceAnimationDidFinish {
    _gameStartButton.selected = NO;
    _gameStartButton.userInteractionEnabled = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [_diceView stopAnimation];
    [_avAudioPlayer stop];
    
}


@end
