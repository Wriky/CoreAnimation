//
//  ViewController.m
//  Listing8.1
//
//  Created by wangyuan on 2018/9/28.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CAAnimationDelegate>

@property (nonatomic, strong) CALayer *colorLayer;
@property (nonatomic, strong) UIView *layerView;

@property (nonatomic, strong) UIButton *changeButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.layerView];
    
    [self.layerView.layer addSublayer:self.colorLayer];
    
    [self.view addSubview:self.changeButton];
}

- (CALayer *)colorLayer {
    if (!_colorLayer) {
        _colorLayer = [CALayer new];
        _colorLayer.frame = CGRectMake(50, 50, 100, 100);
        _colorLayer.position = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
        _colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    }
    return _colorLayer;
}

- (UIView *)layerView {
    if (!_layerView) {
        _layerView = [UIView new];
        _layerView.frame = CGRectMake(60, 150 , 260, 260);
        _layerView.backgroundColor = [UIColor whiteColor];
    }
    return _layerView;
}


- (UIButton *)changeButton {
    if (!_changeButton) {
        _changeButton = [UIButton buttonWithType:0];
        _changeButton.frame = CGRectMake(50, 220, 100, 30);
        _changeButton.layer.cornerRadius = 4;
        _changeButton.layer.borderWidth = 1;
        _changeButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _changeButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_changeButton setTitle:@"Change Color" forState:UIControlStateNormal];
        [_changeButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_changeButton addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeButton;
}


#pragma mark- Action

- (void)changeColor: (UIButton *)button {
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.toValue = (__bridge id)color.CGColor;
    animation.delegate = self;
    
//    [self.colorLayer addAnimation:animation forKey:nil];
    [self applyBasicAnimation:animation toLayer:self.colorLayer];
}


- (void)applyBasicAnimation:(CABasicAnimation *)animation toLayer:(CALayer *)layer {
    
    animation.fromValue = [layer.presentationLayer ?: layer valueForKeyPath:animation.keyPath];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [CATransaction setValue:animation.toValue forKey:animation.keyPath];
    [CATransaction commit];
    
    [layer addAnimation:animation forKey:nil];
}

#pragma mark- CAAniamtionDelegate

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.colorLayer.backgroundColor= (__bridge CGColorRef)anim.toValue;
    [CATransaction commit];
}

@end
