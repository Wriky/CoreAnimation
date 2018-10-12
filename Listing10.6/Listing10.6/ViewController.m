//
//  ViewController.m
//  Listing10.6
//
//  Created by wangyuan on 2018/10/12.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

#import "ViewController.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width

@interface ViewController ()<CAAnimationDelegate>

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *ballView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:self.containerView];
    [self.containerView addSubview:self.ballView];
    
    //animate
    [self animate];
}

#pragma mark- setter

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.frame = CGRectMake(0, 100, kScreenWidth, 500);
        _containerView.backgroundColor = [UIColor whiteColor];
    }
    return _containerView;
}

- (UIImageView *)ballView {
    if (!_ballView) {
        _ballView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Ball"]];
    }
    return _ballView;
}

#pragma mark- action

- (void)animate {
    // reset ball to top of screen
    self.ballView.center = CGPointMake(150, 32);
    
    //create keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 1.0;
    animation.delegate = self;
    animation.values = @[
                         [NSValue valueWithCGPoint:CGPointMake(150, 32)], [NSValue valueWithCGPoint:CGPointMake(150, 268)], [NSValue valueWithCGPoint:CGPointMake(150, 140)], [NSValue valueWithCGPoint:CGPointMake(150, 268)], [NSValue valueWithCGPoint:CGPointMake(150, 220)], [NSValue valueWithCGPoint:CGPointMake(150, 268)], [NSValue valueWithCGPoint:CGPointMake(150, 250)], [NSValue valueWithCGPoint:CGPointMake(150, 268)]
                         ];
    animation.timingFunctions = @[
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn]
                                  ];
    animation.keyTimes = @[@0.0, @0.3, @0.5, @0.7, @0.8, @0.9, @0.95, @1.0];
    
    //apply animation
    self.ballView.layer.position = CGPointMake(150, 268);
    [self.ballView.layer addAnimation:animation forKey:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self animate];
}

@end
