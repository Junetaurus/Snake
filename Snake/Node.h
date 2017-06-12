//
//  Node.h
//  Snake
//
//  Created by ZhangJun on 2017/6/9.
//  Copyright © 2017年 ANG. All rights reserved.
//  节点类

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define NodeWH 10 //节点默认宽高

@interface Node : NSObject

@property (nonatomic, assign) CGPoint coordinate;

+ (instancetype)nodeWithCoordinate:(CGPoint)coordinate;

@end
