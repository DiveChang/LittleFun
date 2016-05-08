//
//  LFPoint.m
//  LittleFun
//
//  Created by 张迪 on 16/5/7.
//  Copyright © 2016年 张迪. All rights reserved.
//

#import "LFPoint.h"

@implementation LFPoint

- (id)initWithX:(NSInteger)pointX andY:(NSInteger)pointY
{
    if (self = [super init]) {
        _x = pointX;
        _y = pointY;
    }
    
    return self;
}

- (void)setX:(NSInteger)x
{
    _x = x;
}

- (void)setY:(NSInteger)y
{
    _y = y;
}

- (BOOL)isEqual:(id)object
{
        LFPoint *point2 = (LFPoint *)object;
        if ((self.x == point2.x) && (self.y == point2.y)) {
            return YES;
        } else {
            return NO;
        }
}


@end
