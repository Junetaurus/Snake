//
//  Node.m
//  Snake
//
//  Created by ZhangJun on 2017/6/9.
//  Copyright © 2017年 ANG. All rights reserved.
//

#import "Node.h"

@implementation Node

+ (instancetype)nodeWithCoordinate:(CGPoint)coordinate {
    Node *node = [[Node alloc] init];
    node.coordinate = coordinate;
    return node;
}

@end
