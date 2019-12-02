//
//  ViewController.m
//  轮询View
//
//  Created by YSZ on 2019/12/2.
//  Copyright © 2019 YSZ. All rights reserved.
//

#import "ViewController.h"
#import "LQRollTextView.h"

@interface ViewController ()

/** 滚动View */
@property (nonatomic, strong) LQRollTextView *rollTextView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.rollTextView = [[LQRollTextView alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 24)];
    [self.view addSubview:self.rollTextView];

}

@end
