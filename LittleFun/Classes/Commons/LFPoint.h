//
//  LFPoint.h
//  LittleFun
//
//  Created by 张迪 on 16/5/7.
//  Copyright © 2016年 张迪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LFPoint : NSObject

@property (nonatomic, assign) NSInteger x;
@property (nonatomic, assign) NSInteger y;

- (id)initWithX:(NSInteger)pointX andY:(NSInteger)pointY;

@end
