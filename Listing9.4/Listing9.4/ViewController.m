//
//  ViewController.m
//  Listing9.4
//
//  Created by wangyuan on 2018/10/10.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

#import "ViewController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) CALayer *doorLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.containerView];
    
    //add the door
    CALayer *doorLayer = [CALayer new];
    doorLayer.frame = CGRectMake(0, 0, 128, 256);
    doorLayer.position = CGPointMake(184 - 64, 220);
    doorLayer.anchorPoint = CGPointMake(0, 0.5);
    doorLayer.contents = (__bridge id)[UIImage imageNamed:@"Door"].CGImage;
    self.doorLayer = doorLayer;
    [self.containerView.layer addSublayer:doorLayer];
    
    //apply perspective transform
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = - 1.0 / 500.0;
    self.containerView.layer.sublayerTransform = perspective;
    
    //add pan gesture recognizer to handle swipes
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
    [pan addTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
    
    //pause all layer animations
    self.doorLayer.speed = 0.0;
    
    //apply swinging animation
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.y";
    animation.toValue = @(- M_PI_2);
    animation.duration = 2.0;
    animation.repeatCount = INFINITY;
    animation.autoreverses = YES;
    [doorLayer addAnimation:animation forKey:nil];
}

#pragma mark- setter

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.frame = CGRectMake(0, 100, kScreenWidth, 500);
        _containerView.backgroundColor = [UIColor lightGrayColor];
    }
    return _containerView;
}

#pragma mark- action
- (void)pan:(UIPanGestureRecognizer *)pan {
    //get horizontal component of pan geture
    CGFloat x = [pan translationInView:self.view].x;
    
    //convert from points to animation duration
    //using a reasonable scale factor
    x /= 200.f;
    
    //update timeOffset and clamp result
    CFTimeInterval timeOffset = self.doorLayer.timeOffset;
    timeOffset = MIN(1.999, MAX(0.0, timeOffset - x));
    self.doorLayer.timeOffset = timeOffset;
        
    //reset pan gesture
    [pan setTranslation:CGPointZero inView:self.view];
}
@end
