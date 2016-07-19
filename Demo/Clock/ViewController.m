//
//  ViewController.m
//  Clock
//
//  Created by zhangsl on 16/7/15.
//  Copyright © 2016年 zhangshulin. All rights reserved.
//

#import "ViewController.h"
#import "SLClockView.h"

@interface ViewController ()

@property (strong, nonatomic) SLClockView *clock;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    startButton.frame = CGRectMake(0, self.view.frame.size.height - 40, 150, 40);
    startButton.backgroundColor = [UIColor redColor];
    [startButton setTitle:@"Resume Clock" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(resumeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    
    UIButton *stopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    stopButton.frame = CGRectMake(self.view.frame.size.width - 150, self.view.frame.size.height - 40, 150, 40);
    stopButton.backgroundColor = [UIColor greenColor];
    [stopButton setTitle:@"Pause Clock" forState:UIControlStateNormal];
    [stopButton addTarget:self action:@selector(pauseButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopButton];
    
    SLClockView *clockView = [[SLClockView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    [self.view addSubview:clockView];
    clockView.center = self.view.center;
    clockView.layer.cornerRadius = 100;
    self.clock = clockView;
    
    [clockView startClockAtNow];
}

- (void)resumeButtonAction {
    [self.clock resumeClock];
}

- (void)pauseButtonAction {
    [self.clock pauseClock];    
}

@end
