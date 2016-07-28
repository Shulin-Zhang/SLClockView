//
//  ClockView.m
//  Clock
//
//  Created by zhangsl on 16/7/15.
//  Copyright © 2016年 zhangshulin. All rights reserved.
//

#import "SLClockView.h"

@interface SLClockView ()

@property (weak, nonatomic) CALayer *hourPointer;
@property (weak, nonatomic) CALayer *minutePointer;
@property (weak, nonatomic) CALayer *secondPointer;

@end

@implementation SLClockView

//------------------------------------------------------------------------------
#pragma mark - Init
//------------------------------------------------------------------------------

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _hourPointer = [self addLayerWithColor:[UIColor grayColor] size:CGSizeMake(4, frame.size.height * 0.5 - 40)];
        _minutePointer = [self addLayerWithColor:[UIColor greenColor] size:CGSizeMake(3, frame.size.height * 0.5 - 15)];
        _secondPointer = [self addLayerWithColor:[UIColor redColor] size:CGSizeMake(2, frame.size.height * 0.5)];
        
        self.layer.contents = (__bridge id)[UIImage imageNamed:@"c.jpeg"].CGImage;
    }
    
    return self;
}

//------------------------------------------------------------------------------
#pragma mark - Public Mehtod
//------------------------------------------------------------------------------

- (void)startClockAtHour:(NSUInteger)hour minute:(NSUInteger)minute second:(NSUInteger)second {
    [self.secondPointer removeAnimationForKey:@"second"];
    [self.minutePointer removeAnimationForKey:@"minute"];
    [self.hourPointer removeAnimationForKey:@"hour"];
    
    CABasicAnimation *secondAnimation = [CABasicAnimation animation];
    secondAnimation.keyPath = @"transform.rotation.z";
    secondAnimation.repeatCount = HUGE_VALF;
    secondAnimation.fillMode = kCAFillModeForwards;
    secondAnimation.removedOnCompletion = NO;
    secondAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    secondAnimation.duration = 60;
    secondAnimation.fromValue = @((second / 60.0) * (2 * M_PI));
    secondAnimation.byValue = @(2 * M_PI);
    [self.secondPointer addAnimation:secondAnimation forKey:@"second"];
    
    CABasicAnimation *minuteAnimation = [CABasicAnimation animation];
    minuteAnimation.keyPath = @"transform.rotation.z";
    minuteAnimation.repeatCount = HUGE_VALF;
    minuteAnimation.fillMode = kCAFillModeForwards;
    minuteAnimation.removedOnCompletion = NO;
    minuteAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    minuteAnimation.duration = 60 * 60;
    minuteAnimation.fromValue = @(((minute + second / 60.0) / 60.0) * (2 * M_PI));
    minuteAnimation.byValue = @(2 * M_PI);
    [self.minutePointer addAnimation:minuteAnimation forKey:@"minute"];
    
    CABasicAnimation *hourAnimation = [CABasicAnimation animation];
    hourAnimation.keyPath = @"transform.rotation.z";
    hourAnimation.repeatCount = HUGE_VALF;
    hourAnimation.fillMode = kCAFillModeForwards;
    hourAnimation.removedOnCompletion = NO;
    hourAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    hourAnimation.duration = 60 * 60 * 12;
    hourAnimation.fromValue = @(((hour + minute / 60.0 + second / 3600.0)/ 12.0) * (2 * M_PI));
    hourAnimation.byValue = @(2 * M_PI);
    [self.hourPointer addAnimation:hourAnimation forKey:@"hour"];
}

- (void)startClockAtNow {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dates = [calendar components:NSCalendarUnitHour |
                               NSCalendarUnitMinute |
                               NSCalendarUnitSecond fromDate:[NSDate date]];
    
    [self startClockAtHour:dates.hour minute:dates.minute second:dates.second];
}

- (void)startClockAtDate:(NSDate *)date {
    if (!date) {
        return;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm:ss";
    NSString *dateString = [formatter stringFromDate:date];
    NSArray *dateArray = [dateString componentsSeparatedByString:@":"];
    
    CGFloat hour = 0;
    CGFloat minute = 0;
    CGFloat second = 0;
    if (dateArray.count == 3) {
        hour = [dateArray[0] floatValue];
        minute = [dateArray[1] floatValue];
        second = [dateArray[2] floatValue];
    }
    
    [self startClockAtHour:hour minute:minute second:second];
}

- (void)pauseClock {
    [self pauseLayer:self.secondPointer];
    [self pauseLayer:self.minutePointer];
    [self pauseLayer:self.hourPointer];
}

- (void)resumeClock {
    [self resumeLayer:self.secondPointer];
    [self resumeLayer:self.minutePointer];
    [self resumeLayer:self.hourPointer];
}

//------------------------------------------------------------------------------
#pragma mark - Private Method
//------------------------------------------------------------------------------

- (CALayer *)addLayerWithColor:(UIColor *)color size:(CGSize)size {
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = color.CGColor;
    
    layer.anchorPoint = CGPointMake(0.5, 1);
    layer.bounds = CGRectMake(0, 0, size.width, size.height);
    layer.position = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    layer.cornerRadius = 4;
    
    [self.layer addSublayer:layer];
    
    return layer;
}

- (void)pauseLayer:(CALayer *)layer {
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

- (void)resumeLayer:(CALayer *)layer {
    if (layer.speed != 0.0) {
        return;
    }
    
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

//------------------------------------------------------------------------------
#pragma mark - Setter & Getter
//------------------------------------------------------------------------------

- (void)setClockBackgroundImage:(UIImage *)clockBackgroundImage {
    if (!clockBackgroundImage) {
        return;
    }
    
    _clockBackgroundImage = clockBackgroundImage;
    
    self.layer.contents = (__bridge id)clockBackgroundImage.CGImage;
}

@end
