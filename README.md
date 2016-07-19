# SLClockView
一个时钟控件，用CoreAnimation实现

@property (strong, nonatomic, nullable) UIImage *clockBackgroundImage;

- (void)startClockAtNow;
- (void)startClockAtHour:(CGFloat)hour minute:(CGFloat)minute second:(CGFloat)second;
- (void)pauseClock;
- (void)resumeClock;

![picture](https://github.com/Coderzhangsl/SLClockView/blob/master/Pictures/Simulator%20Screen%20Shot%202016%E5%B9%B47%E6%9C%8819%E6%97%A5%20%E4%B8%8A%E5%8D%889.18.00.png =300x)
