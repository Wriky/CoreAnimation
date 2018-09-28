//
//  ViewController.m
//  Listing7.6
//
//  Created by wangyuan on 2018/9/27.
//  Copyright © 2018年 wangyuan. All rights reserved.
//


#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *layerView;
@property (nonatomic, strong) CALayer *colorLayer;

@property (nonatomic, strong) UIButton *changeButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:self.layerView];
    [self.layerView addSubview:self.changeButton];

    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    self.colorLayer.actions = @{@"backgroundColor": transition};
    
    [self.layerView.layer addSublayer:self.colorLayer];
    
}

- (UIView *)layerView {
    if (!_layerView) {
        _layerView = [UIView new];
        _layerView.frame = CGRectMake(60, 150 , 260, 260);
        _layerView.backgroundColor = [UIColor whiteColor];
    }
    return _layerView;
}

- (CALayer *)colorLayer {
    if (!_colorLayer) {
        _colorLayer = [CALayer new];
        _colorLayer.frame = CGRectMake(50, 50, 100, 100);
        _colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    }
    return _colorLayer;
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
    
    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
}

@end
