//
//  ViewController.m
//  Listing10.1
//
//  Created by wangyuan on 2018/10/11.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) CALayer *colorLayer;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(0, 0, 100, 100);
    self.colorLayer.position = CGPointMake(self.view.bounds.size.width/2.0, self.view.bounds.size.height/2);
    self.colorLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.colorLayer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //configure the transaction
    [CATransaction begin];
    [CATransaction setAnimationDuration:1];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    //set the position
    self.colorLayer.position = [[touches anyObject] locationInView:self.view];
    
    //commit transaction
    [CATransaction commit];
}
@end
