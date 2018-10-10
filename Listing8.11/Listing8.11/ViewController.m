//
//  ViewController.m
//  Listing8.11
//
//  Created by wangyuan on 2018/10/10.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) UIButton *switchBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.switchBtn];
    
    self.images = @[[UIImage imageNamed:@"Anchor"],
                    [UIImage imageNamed:@"Cone"],
                    [UIImage imageNamed:@"Igloo"],
                    [UIImage imageNamed:@"Spaceship"]
                    ];
    
    
}

#pragma mark- setter
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.frame = CGRectMake(50, 100, 200, 200);
        _imageView.image = [UIImage imageNamed:@"Anchor"];
    }
    return _imageView;
}

- (UIButton *)switchBtn {
    if (!_switchBtn) {
        _switchBtn = [UIButton new];
        _switchBtn.frame = CGRectMake(100, 320, 60, 30);
        [_switchBtn setTitle:@"切换" forState:UIControlStateNormal];
        [_switchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_switchBtn addTarget:self action:@selector(switchImage:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _switchBtn;
}

#pragma mark- action

- (void)switchImage:(UIButton *)button {
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    
    //apply transition to imageView backing layer
    [self.imageView.layer addAnimation:transition forKey:nil];
    
    //cycle to next image
    UIImage *currentImage = self.imageView.image;
    NSUInteger index = [self.images indexOfObject:currentImage];
    
    index = (index + 1) % self.images.count;
    self.imageView.image = self.images[index];
}

    @end
