//
//  HomeViewController.m
//  LittleFun
//
//  Created by 张迪 on 16/4/25.
//  Copyright © 2016年 张迪. All rights reserved.
//

#import "HomeViewController.h"
#import "DiceViewController.h"
#import "SnakeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)pushDiceViewController:(UIButton *)sender {
    
    
    if (sender.tag == 1001) {
        DiceViewController *diceController = [[DiceViewController alloc] init];
        [self.navigationController pushViewController:diceController animated:YES];
    } else if (sender.tag == 1002) {
        SnakeViewController *snakeController = [[SnakeViewController alloc] init];
        [self.navigationController pushViewController:snakeController animated:YES];

    }

}

@end
