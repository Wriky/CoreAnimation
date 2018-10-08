//
//  ViewController.m
//  Listing8.4
//
//  Created by wangyuan on 2018/10/8.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>

@interface ViewController ()<CAAnimationDelegate>

@property (nonatomic, strong) UIImageView *clockView;

@property (nonatomic, strong) UIImageView *hourHand;
@property (nonatomic, strong) UIImageView *miniuteHand;
@property (nonatomic, strong) UIImageView *secondHand;

@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.clockView];
    [self.clockView addSubview:self.hourHand];
    [self.clockView addSubview:self.miniuteHand];
    [self.clockView addSubview:self.secondHand];
    
    [self makeConstraints];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(tick) userInfo:nil repeats:YES];
}

- (void)makeConstraints {
    
    [self.clockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(@(100));
    }];
    [self.hourHand mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.clockView);
    }];
    [self.miniuteHand mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.clockView);
    }];
    [self.secondHand mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.clockView);
    }];
}

#pragma mark- Action
- (void)tick {
    [self updateHandsAnimated:YES];
}

- (void)setAngle:(CGFloat)angle forHand:(UIView *)handView animated:(BOOL)animated {
    CATransform3D transform = CATransform3DMakeRotation(angle, 0, 0, 1);
    if (animated) {
        CABasicAnimation *animation = [CABasicAnimation animation];
        animation.keyPath = @"transform";
        animation.toValue = [NSValue valueWithCATransform3D:transform];
        animation.duration = 0.5;
        animation.delegate = self;
        [animation setValue:handView forKey:@"handView"];
        [handView.layer addAnimation:animation forKey:nil];
    } else {
        handView.layer.transform = transform;
    }
}

- (void)updateHandsAnimated:(BOOL)animated {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    CGFloat hourAngle = (components.hour / 12.0) * M_PI * 2.0;
    CGFloat minuteAngle = (components.minute / 60.0) * M_PI * 2.0;
    CGFloat secondAngle = (components.second / 60.0) * M_PI * 2.0;
    
    [self setAngle:hourAngle forHand:self.hourHand animated:animated];
    [self setAngle:minuteAngle forHand:self.miniuteHand animated:animated];
    [self setAngle:secondAngle forHand:self.secondHand animated:animated];
}


#pragma mark- setter
- (UIImageView *)clockView {
    if (!_clockView) {
        _clockView = [UIImageView new];
        _clockView.image = [UIImage imageNamed:@"ClockFace"];
    }
    return _clockView;
}

- (UIImageView *)hourHand {
    if (!_hourHand) {
        _hourHand = [UIImageView new];
        _hourHand.backgroundColor = [UIColor whiteColor];
        _hourHand.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
        _hourHand.image = [UIImage imageNamed:@"HourHand"];
    }
    return _hourHand;
}

- (UIImageView *)miniuteHand {
    if (!_miniuteHand) {
        _miniuteHand = [UIImageView new];
        _miniuteHand.backgroundColor = [UIColor whiteColor];
        _miniuteHand.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
        _miniuteHand.image = [UIImage imageNamed:@"MinuteHand"];
    }
    return _miniuteHand;
}

- (UIImageView *)secondHand {
    if (!_secondHand) {
        _secondHand = [UIImageView new];
        _secondHand.backgroundColor = [UIColor whiteColor];
        _secondHand.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
        _secondHand.image = [UIImage imageNamed:@"SecondHand"];
    }
    return _secondHand;
}

#pragma mark- CAAnimationDelegate

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag {
    UIView *handView = [anim valueForKey:@"handView"];
    handView.layer.transform = [anim.toValue CATransform3DValue];
}

@end
