//
//  GameInterfaceView.m
//  Snake
//
//  Created by ZhangJun on 2017/6/9.
//  Copyright © 2017年 ANG. All rights reserved.
//

#import "GameInterfaceView.h"
#import "Snake.h"

@implementation GameInterfaceView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    if (!_snake.nodes.count) return;
    CGPoint center = _snake.nodes.firstObject.coordinate;
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [self drawHead:bezierPath center:center];
    [[UIColor greenColor] set];
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

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.1].CGColor;
}


@end
