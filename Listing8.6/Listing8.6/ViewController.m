//
//  ViewController.m
//  Listing8.6
//
//  Created by wangyuan on 2018/10/9.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@property (nonatomic, strong) UIView *containerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.containerView];
    
    //create a path
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(0, 150)];
    [bezierPath addCurveToPoint:CGPointMake(300, 150)
                  controlPoint1:CGPointMake(75, 0)
                  controlPoint2:CGPointMake(225, 330)];
    
    //draw the path using a CAShapeLayer
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.f;
    [self.containerView.layer addSublayer:pathLayer];
    
    //add the ship
    CALayer *shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 64, 64);
    shipLayer.position = CGPointMake(300, 150);
    shipLayer.contents = (__bridge id)[UIImage imageNamed:@"Ship.png"].CGImage;
    [self.containerView.layer addSublayer:shipLayer];

//    create the keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 4.0;
    animation.path = bezierPath.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    [shipLayer addAnimation:animation forKey:nil];
    
    
    
}

#pragma mark- setter
- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.frame = CGRectMake(30, 60, 300, 300);
        _containerView.backgroundColor = [UIColor lightGrayColor];
    }
    return _containerView;
}

@end
