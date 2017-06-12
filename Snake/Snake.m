//
//  Snake.m
//  Snake
//
//  Created by ZhangJun on 2017/6/9.
//  Copyright © 2017年 ANG. All rights reserved.
//

#import "Snake.h"

@interface Snake ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger speed;
@property (nonatomic, assign) CGPoint lastPoint;

@end

@implementation Snake

- (NSMutableArray<Node *> *)nodes {
    if (!_nodes) {
        _nodes = [[NSMutableArray alloc] init];
    }
    return _nodes;
}

+ (instancetype)snake {
    Snake *snake = [[Snake alloc] init];
    [snake initBody];
    return snake;
}

- (void)initBody {
    [self.nodes removeAllObjects];
    for (int i = 4; i >= 0; i--) {
        CGPoint point = CGPointMake(NodeWH * (i + 0.5), NodeWH * 0.5);
        [self.nodes addObject:[Node nodeWithCoordinate:point]];
    }
    _direction = MoveDirectionRight;
}

- (void)levelUpWithSpeed:(NSInteger)speed {
    _speed = speed;
    [self pause];
    [self start];
}

- (void)reset {
    [self initBody];
    _speed = 0;
    [self start];
}

- (void)start {
    float time = 0.2 - (float)_speed * 0.02;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(snakeMove) userInfo:nil repeats:YES];
}

- (void)pause {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)setDirection:(MoveDirection)direction {
    if (direction == MoveDirectionDown || direction == MoveDirectionUp) {
        if (_direction == MoveDirectionUp || _direction == MoveDirectionDown) return;
    } else if (_direction == MoveDirectionLeft || _direction == MoveDirectionRight) return;
    _direction = direction;
}

- (void)growth {
    Node *node = [Node nodeWithCoordinate:_lastPoint];
    [_nodes addObject:node];
}

- (void)snakeMove {
    Node *node = _nodes.lastObject;
    _lastPoint = node.coordinate;
    CGPoint center = _nodes.firstObject.coordinate;
    switch (_direction) {
        case MoveDirectionUp:
            center.y -= NodeWH;
            break;
        case MoveDirectionLeft:
            center.x -= NodeWH;
            break;
        case MoveDirectionDown:
            center.y += NodeWH;
            break;
        case MoveDirectionRight:
            center.x += NodeWH;
            break;
    }
    node.coordinate = center;
    [_nodes removeObject:node];
    [_nodes insertObject:node atIndex:0];
    (!_moveFinishBlock)? : _moveFinishBlock();
}

@end
