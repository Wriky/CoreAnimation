//
//  ViewController.m
//  Listing8.14
//
//  Created by wangyuan on 2018/10/10.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *transitionBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:self.transitionBtn];
}

- (void)performTransition {
    
    //preserve the current view snapshot
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES , 0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *coverImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //insert snapshot view in front of this one
    UIView *coverView = [[UIImageView alloc] initWithImage:coverImage];
    coverView.frame = self.view.bounds;
    [self.view addSubview:coverView];
    
    //update the view (we'll simply randomize the layer background color)
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    
    self.view.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    //perform animation
    [UIView animateWithDuration:1.0 animations:^{
        //scale, rotate and fade the view
        CGAffineTransform transform = CGAffineTransformMakeScale(0.01, 0.01);
        transform = CGAffineTransformRotate(transform, M_PI_2);
        coverView.transform = transform;
        coverView.alpha = 0.0;
    }completion:^(BOOL finished) {
        [coverView removeFromSuperview];
    }];
}

#pragma mark- setter

- (UIButton *)transitionBtn {
    if (!_transitionBtn) {
        _transitionBtn = [UIButton buttonWithType:0];
        _transitionBtn.frame = CGRectMake(100, 260, 120, 30);
        [_transitionBtn setTitle:@"perform transition" forState:UIControlStateNormal];
        [_transitionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _transitionBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _transitionBtn.layer.cornerRadius = 4;
        _transitionBtn.layer.borderColor = [UIColor blueColor].CGColor;
        _transitionBtn.layer.borderWidth = 1;
        [_transitionBtn setBackgroundColor:[UIColor purpleColor]];
        [_transitionBtn addTarget:self action:@selector(performTransition) forControlEvents:UIControlEventTouchUpInside];
        _transitionBtn.clipsToBounds = YES;
    }
    return _transitionBtn;
}

@end
