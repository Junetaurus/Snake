//
//  GameInterfaceView.m
//  Snake
//
//  Created by ZhangJun on 2017/6/9.
//  Copyright © 2017年 ANG. All rights reserved.
//

#import "GameInterfaceView.h"
#import "Snake.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation GameInterfaceView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    if (!_snake.nodes.count) return;
    CGPoint center = _snake.nodes.firstObject.coordinate;
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [self drawHead:bezierPath center:center];
    [UIColorFromRGB(0xfdf156) set];
    [bezierPath setLineWidth:1];
    [bezierPath fill];
    for (int i = 1; i < _snake.nodes.count; i++) {
        center = _snake.nodes[i].coordinate;
        CGRect rectangle = CGRectMake(center.x - NodeWH * 0.5, center.y - NodeWH * 0.5, NodeWH, NodeWH);
        bezierPath = [UIBezierPath bezierPathWithOvalInRect:rectangle];
        [bezierPath fill];
    }
}

- (void)drawHead:(UIBezierPath *)bezierPath center:(CGPoint)center {
    CGFloat halfW = NodeWH * 0.5;
    switch (_snake.direction) {
        case MoveDirectionRight:
            [bezierPath moveToPoint:CGPointMake(center.x - halfW, center.y - halfW)];
            [bezierPath addLineToPoint:CGPointMake(center.x - halfW, center.y + halfW)];
            [bezierPath addLineToPoint:CGPointMake(center.x + halfW, center.y)];
            break;
        case MoveDirectionLeft:
            [bezierPath moveToPoint:CGPointMake(center.x - halfW, center.y)];
            [bezierPath addLineToPoint:CGPointMake(center.x + halfW, center.y + halfW)];
            [bezierPath addLineToPoint:CGPointMake(center.x + halfW, center.y - halfW)];
            break;
        case MoveDirectionDown:
            [bezierPath moveToPoint:CGPointMake(center.x - halfW, center.y - halfW)];
            [bezierPath addLineToPoint:CGPointMake(center.x + halfW, center.y - halfW)];
            [bezierPath addLineToPoint:CGPointMake(center.x, center.y + halfW)];
            break;
        case MoveDirectionUp:
            [bezierPath moveToPoint:CGPointMake(center.x, center.y - halfW)];
            [bezierPath addLineToPoint:CGPointMake(center.x - halfW, center.y + halfW)];
            [bezierPath addLineToPoint:CGPointMake(center.x + halfW, center.y + halfW)];
            break;
        default:
            break;
    }
}

@end
