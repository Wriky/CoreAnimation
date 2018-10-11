//
//  ViewController.m
//  Listing9.3
//
//  Created by wangyuan on 2018/10/11.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *speedTxtLabel;
@property (nonatomic, strong) UILabel *timeOffsetTxtLabel;
@property (nonatomic, strong) UILabel *speedLabel;
@property (nonatomic, strong) UILabel *timeOffsetLabel;
@property (nonatomic, strong) UISlider *speedSlider;
@property (nonatomic, strong) UISlider *timeOffsetSlider;
@property (nonatomic, strong) UIBezierPath *bezierPath;
@property (nonatomic, strong) CALayer *shipLayer;
@property (nonatomic, strong) UIButton *playBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.containerView];
    [self.containerView addSubview:self.speedTxtLabel];
    [self.containerView addSubview:self.timeOffsetTxtLabel];
    [self.containerView addSubview:self.speedLabel];
    [self.containerView addSubview:self.timeOffsetLabel];
    [self.containerView addSubview:self.speedSlider];
    [self.containerView addSubview:self.timeOffsetSlider];
    [self.containerView addSubview:self.playBtn];
    
    //create a path
    self.bezierPath = [[UIBezierPath alloc] init];
    [self.bezierPath moveToPoint:CGPointMake(0, 150)];
    [self.bezierPath addCurveToPoint:CGPointMake(300, 150)
                       controlPoint1:CGPointMake(75, 0)
                       controlPoint2:CGPointMake(225, 300)];
    
    //draw the path using a CAShapeLayer
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = self.bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.containerView.layer addSublayer:pathLayer];
    
    //add the ship
    self.shipLayer = [CALayer layer];
    self.shipLayer.frame = CGRectMake(0, 0, 64, 64);
    self.shipLayer.position = CGPointMake(0, 150);
    self.shipLayer.contents = (__bridge id)[UIImage imageNamed:@"Ship.png"].CGImage;
    [self.containerView.layer addSublayer:self.shipLayer];
    
    //set initial values
    [self updateSliders];
}

#pragma mark- setter
- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.frame = CGRectMake(30, 60, 360, 500);
        _containerView.backgroundColor = [UIColor lightGrayColor];
    }
    return _containerView;
}
- (UILabel *)speedTxtLabel {
    if (!_speedTxtLabel) {
        _speedTxtLabel = [UILabel new];
        _speedTxtLabel.frame = CGRectMake(10, 360, 60, 30);
        _speedTxtLabel.text = @"speed";
        _speedTxtLabel.font = [UIFont systemFontOfSize:12];
    }
    return _speedTxtLabel;
}

- (UILabel *)timeOffsetTxtLabel {
    if (!_timeOffsetTxtLabel) {
        _timeOffsetTxtLabel = [UILabel new];
        _timeOffsetTxtLabel.text = @"timeOffset";
        _timeOffsetTxtLabel.frame = CGRectMake(10, 320, 60, 30);
        _timeOffsetTxtLabel.font = [UIFont systemFontOfSize:12];
    }
    return _timeOffsetTxtLabel;
}

- (UILabel *)speedLabel {
    if (!_speedLabel) {
        _speedLabel = [UILabel new];
        _speedLabel.frame = CGRectMake(230, 360, 40, 30);
        _speedLabel.font = [UIFont systemFontOfSize:12];
    }
    return _speedLabel;
}

- (UILabel *)timeOffsetLabel {
    if (!_timeOffsetLabel) {
        _timeOffsetLabel = [UILabel new];
        _timeOffsetLabel.frame = CGRectMake(230, 320, 40, 30);
        _timeOffsetLabel.font = [UIFont systemFontOfSize:12];
    }
    return _timeOffsetLabel;
}

- (UISlider *)speedSlider {
    if (!_speedSlider) {
        _speedSlider = [UISlider new];
        _speedSlider.frame = CGRectMake(80, 360, 140, 30);
        _speedSlider.maximumValue = 1.0;
        [_speedSlider addTarget:self action:@selector(updateSliders) forControlEvents:UIControlEventValueChanged];
    }
    return _speedSlider;
}

- (UISlider *)timeOffsetSlider {
    if (!_timeOffsetSlider) {
        _timeOffsetSlider = [UISlider new];
        _timeOffsetSlider.frame = CGRectMake(80, 320, 140, 30);
        _timeOffsetSlider.maximumValue = 0.5;
        [_timeOffsetSlider addTarget:self action:@selector(updateSliders) forControlEvents:UIControlEventValueChanged];
    }
    return _timeOffsetSlider;
}

- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:0];
        _playBtn.frame = CGRectMake(280, 330, 40, 30);
        _playBtn.backgroundColor = [UIColor whiteColor];
        _playBtn.layer.cornerRadius = 4;
        _playBtn.clipsToBounds = YES;
        _playBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_playBtn setTitle:@"play" forState:UIControlStateNormal];
        [_playBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

#pragma mark- action
- (void)updateSliders {
    CFTimeInterval timeOffset = self.timeOffsetSlider.value;
    self.timeOffsetLabel.text = [NSString stringWithFormat:@"%0.2f",timeOffset];
    
    float speed = self.speedSlider.value;
    self.speedLabel.text = [NSString stringWithFormat:@"%0.2f", speed];
}

- (void)play
{
    //create the keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation]; animation.keyPath = @"position";
    animation.timeOffset = self.timeOffsetSlider.value; animation.speed = self.speedSlider.value;
    animation.duration = 1.0;
    animation.path = self.bezierPath.CGPath; animation.rotationMode = kCAAnimationRotateAuto; animation.removedOnCompletion = NO;
    [self.shipLayer addAnimation:animation forKey:@"slide"];
}

@end
