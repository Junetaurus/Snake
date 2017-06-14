//
//  ViewController.m
//  Snake
//
//  Created by ZhangJun on 2017/6/9.
//  Copyright © 2017年 ANG. All rights reserved.
//

#import "ViewController.h"
#import "GameInterfaceView.h"
#import "Snake.h"

#define LevelCount 10   //多少分为1级
#define MaxLevel 9     //最高多少级

#define WeakSelf __weak typeof(self) weakSelf = self;

@interface ViewController ()

@property (nonatomic, strong) Snake *snake;
@property (nonatomic, strong) UIImageView *food;
@property (nonatomic, strong) NSArray *foodColorArray;
@property (nonatomic, assign) BOOL isGameOver;
//
@property (weak, nonatomic) IBOutlet GameInterfaceView *gameView;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;

@end

@implementation ViewController

- (UIImageView *)food {
    if (!_food) {
        _food = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, NodeWH, NodeWH)];
        _food.layer.masksToBounds = YES;
        _food.layer.cornerRadius = NodeWH / 2;
        [_gameView addSubview:_food];
    }
    _food.backgroundColor = self.foodColorArray[arc4random() % self.foodColorArray.count];
    return _food;
}

- (NSArray *)foodColorArray {
    if (!_foodColorArray) {
        _foodColorArray = [NSArray arrayWithObjects:[UIColor greenColor],[UIColor blueColor],[UIColor blackColor],[UIColor yellowColor],[UIColor orangeColor],[UIColor purpleColor], nil];
    }
    return _foodColorArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.snake = [Snake snake];
    WeakSelf;
    _snake.moveFinishBlock = ^(){
        [weakSelf isEatedFood];
        [weakSelf isDestroy];
        [weakSelf.gameView setNeedsDisplay];
    };
    _gameView.snake = _snake;
    [self createFood];
}


#pragma mark - 食物创建
- (void)createFood {
    int x = (arc4random() % (NSInteger)_gameView.bounds.size.width / NodeWH) * NodeWH + NodeWH * 0.5;
    int y = (arc4random() % (NSInteger)_gameView.bounds.size.height / NodeWH) * NodeWH + NodeWH * 0.5;
    CGPoint center = CGPointMake(x, y);
    for (Node *node in _snake.nodes) {
        if (CGPointEqualToPoint(center, node.coordinate)) {
            [self createFood];
            return;
        }
    }
    self.food.center = center;
}

#pragma mark - 食物被吃
- (void)isEatedFood {
    if (CGPointEqualToPoint(_food.center, _snake.nodes.firstObject.coordinate)) {
        NSInteger score = [_scoreLabel.text substringFromIndex:3].intValue + 1;
        _scoreLabel.text = [NSString stringWithFormat:@"分数：%ld", score];
        if (score <= LevelCount * MaxLevel && (score % LevelCount == 0)){
            NSInteger level = score / LevelCount;
            [_snake levelUpWithSpeed:level];
            _levelLabel.text = [NSString stringWithFormat:@"等级：%ld", level];
        }
        [self createFood];
        [_snake growth];
    }
}

#pragma mark - 判断游戏是否结束
- (void)isDestroy {
    Node *head = _snake.nodes.firstObject;
    for (int i = 1; i < _snake.nodes.count; i++) {
        Node *node = _snake.nodes[i];
        if (CGPointEqualToPoint(head.coordinate, node.coordinate)) {
            [self gameOver];
        }
    }
    //超过游戏视图区域
    if (head.coordinate.x < 5 || head.coordinate.x > _gameView.bounds.size.width - 5) {
        [self gameOver];
    }
    if (head.coordinate.y < 5 || head.coordinate.y > _gameView.bounds.size.height - 5) {
        [self gameOver];
    }
}

#pragma mark - 游戏结束
- (void)gameOver {
    [_snake pause];
    //
    NSString *message = [NSString stringWithFormat:@"总得分：%@\n是否继续游戏？", [_scoreLabel.text substringFromIndex:3]];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Game Over" message:message preferredStyle:UIAlertControllerStyleAlert];
    WeakSelf;
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        _startBtn.selected = NO;
        _isGameOver = YES;
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _scoreLabel.text = @"分数：0";
        _levelLabel.text = @"等级：0";
        [weakSelf createFood];
        [_snake reset];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 上下左右按钮点击
- (IBAction)btnClick:(UIButton *)sender {
    if (self.startBtn.selected) {
        self.snake.direction = (MoveDirection)sender.tag;
    }
}

#pragma mark - 开始或者暂停按钮点击
- (IBAction)startOrPause:(UIButton *)sender {
    if (sender.selected) {
        [_snake pause];
    } else {
        if (_isGameOver) {
            _scoreLabel.text = @"分数：0";
            _levelLabel.text = @"等级：0";
            [_snake reset];
            _isGameOver = NO;
        } else {
            [_snake start];
        }
    }
    sender.selected = !sender.selected;
}

@end
