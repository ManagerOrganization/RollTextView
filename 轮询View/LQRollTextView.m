//
//  LQRollTextView.m
//  轮询View
//
//  Created by YSZ on 2019/12/2.
//  Copyright © 2019 YSZ. All rights reserved.
//

#import "LQRollTextView.h"

@interface LQRollTextView ()

/** 数据 */
@property (nonatomic, copy) NSArray *dataArr;
/** 当前Label */
@property (nonatomic, strong) UILabel *currentLab;
/** 下一个label */
@property (nonatomic, strong) UILabel *nextLab;
/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;
/** 当前下标 */
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation LQRollTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.currentIndex = 0;
        self.dataArr = @[@"第一条",@"第二条",@"第三条",@"第四条",@"第五条",@"第六条",@"第七条",@"第八条"];
        [self setupSubViews];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(rollLab) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        
        [self setupSubViews];
    }
    return self;
}


- (void)setupSubViews {
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 24)];
    backView.backgroundColor = [UIColor grayColor];
    backView.clipsToBounds = YES;
    backView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBackView:)];
    [backView addGestureRecognizer:tap];
    [self addSubview:backView];
    [backView addSubview:self.currentLab];
    [backView addSubview:self.nextLab];
    self.currentLab.text = self.dataArr[0];
}

- (void)refreshData {

    if (self.currentIndex == self.dataArr.count - 1) {
       self.currentIndex = -1;
    }
    self.nextLab.text = self.dataArr[self.currentIndex + 1];
    self.currentIndex ++;
}

- (void)rollLab {
    
    [self refreshData];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.currentLab.frame = CGRectMake(0,  - 24, weakSelf.frame.size.width, 24);
        weakSelf.nextLab.frame = CGRectMake(0, 0, weakSelf.frame.size.width, 24);
    } completion:^(BOOL finished) {
        weakSelf.currentLab.text = weakSelf.nextLab.text;
        weakSelf.currentLab.frame = CGRectMake(0, 0, weakSelf.frame.size.width, 24);
        weakSelf.nextLab.frame = CGRectMake(0, 24, weakSelf.frame.size.width, 24);
    }];
}

- (void)clickBackView:(UITapGestureRecognizer *)tap {
    NSLog(@"当前点击：%ld 条",self.currentIndex + 1);
}

#pragma mark -- lazy load --

- (UILabel *)currentLab {
    if (_currentLab == nil) {
        _currentLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 24)];
        _currentLab.textAlignment = NSTextAlignmentLeft;
        _currentLab.textColor = [UIColor blackColor];
    }
    return _currentLab;
}

- (UILabel *)nextLab {
    if (_nextLab == nil) {
        _nextLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, self.frame.size.width, 24)];
        _nextLab.textAlignment = NSTextAlignmentLeft;
        _nextLab.textColor = [UIColor blackColor];
    }
    return _nextLab;
}

@end
