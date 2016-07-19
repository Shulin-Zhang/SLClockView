//
//  ClockView.h
//  Clock
//
//  Created by zhangsl on 16/7/15.
//  Copyright © 2016年 zhangshulin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLClockView : UIView

@property (strong, nonatomic, nullable) UIImage *clockBackgrondImage;


- (void)startClockAtNow;

- (void)startClockAtHour:(CGFloat)hour minute:(CGFloat)minute second:(CGFloat)second;

- (void)pauseClock;

- (void)resumeClock;


@end
