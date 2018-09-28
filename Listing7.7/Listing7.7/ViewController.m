//
//  ViewController.m
//  Listing7.7
//
//  Created by wangyuan on 2018/9/28.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) CALayer *colorLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view.layer addSublayer:self.colorLayer];
}

#pragma mark- setter
- (CALayer *)colorLayer {
    if (!_colorLayer) {
        _colorLayer = [CALayer new];
        _colorLayer.frame = CGRectMake(50, 50, 100, 100);
        _colorLayer.position = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
        _colorLayer.backgroundColor = [UIColor redColor].CGColor;
    }
    return _colorLayer;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self.view];
    
    if ([self.colorLayer.presentationLayer hitTest:point]) {
        CGFloat red = arc4random() / (CGFloat)INT_MAX;
        CGFloat green = arc4random() / (CGFloat)INT_MAX;
        CGFloat blue = arc4random() / (CGFloat)INT_MAX;
        
        self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1].CGColor;
    } else {
        [CATransaction begin];
        [CATransaction setAnimationDuration:4.0];
        
        self.colorLayer.position = point;
        [CATransaction commit];
    }
}
@end
