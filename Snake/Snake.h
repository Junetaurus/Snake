//
//  Snake.h
//  Snake
//
//  Created by ZhangJun on 2017/6/9.
//  Copyright © 2017年 ANG. All rights reserved.
//  蛇类

#import <Foundation/Foundation.h>
#import "Node.h"

typedef enum {
    MoveDirectionUp,
    MoveDirectionLeft,
    MoveDirectionDown,
    MoveDirectionRight
} MoveDirection;

@interface Snake : NSObject

@property (nonatomic, strong) NSMutableArray<Node *> *nodes;
@property (nonatomic, assign) MoveDirection direction;
@property (nonatomic, copy) void(^moveFinishBlock)();

+ (instancetype)snake;
- (void)levelUpWithSpeed:(NSInteger)speed;
- (void)growth;
- (void)pause;
- (void)start;
- (void)reset;

@end
