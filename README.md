# SLClockView
一个时钟控件，用CoreAnimation实现

@property (strong, nonatomic, nullable) UIImage *clockBackgrondImage;

- (void)startClockAtNow;
- (void)startClockAtHour:(CGFloat)hour minute:(CGFloat)minute second:(CGFloat)second;
- (void)pauseClock;
- (void)resumeClock;
