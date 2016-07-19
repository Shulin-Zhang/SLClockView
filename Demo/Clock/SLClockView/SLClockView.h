//
//  ClockView.h
//  Clock
//
//  Created by zhangsl on 16/7/15.
//  Copyright © 2016年 zhangshulin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SLClockView : UIView

@property (strong, nonatomic, nullable) UIImage *clockBackgroundImage;


- (void)startClockAtNow;

- (void)startClockAtHour:(CGFloat)hour minute:(CGFloat)minute second:(CGFloat)second;

- (void)startClockAtDate:(NSDate *)date;

- (void)pauseClock;

- (void)resumeClock;

@end

NS_ASSUME_NONNULL_END