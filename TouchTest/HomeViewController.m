//
//  HomeViewController.m
//  TouchTest
//
//  Created by XAD on 2019/5/5.
//  Copyright © 2019 XAD. All rights reserved.
//

#import "HomeViewController.h"
#import "FirstView.h"
#import "SecondView.h"
#import "ThirdView.h"

@interface HomeViewController () {
    CGFloat _screenW;
    CGFloat _screenH;
}
@property (nonatomic, strong) FirstView *firstView;
@property (nonatomic, strong) SecondView *secondView;
@property (nonatomic, strong) ThirdView *thirdView;

@property (nonatomic, strong) UIView *keyWindowView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _screenW = [UIScreen mainScreen].bounds.size.width;
    _screenH = [UIScreen mainScreen].bounds.size.height;
    
    [self.view addSubview:self.firstView];
    
    [self.firstView addSubview:self.secondView];
    _secondView.center = CGPointMake(0.5 * CGRectGetWidth(self.firstView.frame), 0.5 * CGRectGetWidth(self.firstView.frame));

    [self.secondView addSubview:self.thirdView];
    _thirdView.center = CGPointMake(0.5 * CGRectGetWidth(self.secondView.frame), 0.5 * CGRectGetWidth(self.secondView.frame));

}

- (FirstView *)firstView {
    if (!_firstView) {
        _firstView = [[FirstView alloc] initWithFrame:CGRectMake(0, 0, _screenW, _screenW)];
        _firstView.center = CGPointMake(0.5 * _screenW, 0.5 * _screenH);
        _firstView.backgroundColor = [UIColor redColor];
        _firstView.clipsToBounds = YES;
    }
    
    return _firstView;
}

- (SecondView *)secondView {
    if (!_secondView) {
        _secondView = [[SecondView alloc] initWithFrame:CGRectMake(0, 0, _screenW * 0.8, _screenW * 0.8)];
        _secondView.backgroundColor = [UIColor blueColor];
    }
    
    return _secondView;
}

- (ThirdView *)thirdView {
    if (!_thirdView) {
        _thirdView = [[ThirdView alloc] initWithFrame:CGRectMake(0, 0, _screenW * 0.5, _screenW * 0.5)];
        _thirdView.tag = 0;
        _thirdView.backgroundColor = [UIColor greenColor];
        [self addGestureToVideoView:_thirdView];
    }
    
    return _thirdView;
}

- (UIView *)keyWindowView {
    if (!_keyWindowView) {
        _keyWindowView = [[ThirdView alloc] initWithFrame:CGRectMake(0, 0, _screenW, _screenH)];
        _keyWindowView.backgroundColor = [UIColor clearColor];
        [self addGestureToVideoView:_keyWindowView];
        
        [self addGestureToWindowView:_keyWindowView];
    }
    
    return _keyWindowView;
}

- (void)addGestureToVideoView:(UIView *)videoView {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videoViewTapped:)];
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired = 1;
    [videoView addGestureRecognizer:tap];
}

- (void)addGestureToWindowView:(UIView *)windowView {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowViewTapper:)];
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired = 1;
    [windowView addGestureRecognizer:tap];
}

- (void)windowViewTapper:(id)sender {
    _thirdView.tag = 1 - _thirdView.tag;
    NSLog(@"winow the current tag is %d", (int)(_thirdView.tag));
    if (_thirdView.tag == 0) {
        self.firstView.clipsToBounds = YES;
        _thirdView.frame = CGRectMake(0, 0, _screenW * 0.5, _screenW * 0.5);
        _thirdView.center = CGPointMake(0.5 * CGRectGetWidth(self.secondView.frame), 0.5 * CGRectGetWidth(self.secondView.frame));
        
        [self.keyWindowView removeFromSuperview];
        self.keyWindowView = nil;
        
    }else {
        self.firstView.clipsToBounds = NO;
        
        _thirdView.frame = CGRectMake(0, 0, _screenW, _screenH);
        _thirdView.center = CGPointMake(0.5 * CGRectGetWidth(self.firstView.frame), 0.5 * CGRectGetWidth(self.firstView.frame));
    }
}

- (void)videoViewTapped:(id)sender {
    _thirdView.tag = 1 - _thirdView.tag;
    NSLog(@"the current tag is %d", (int)(_thirdView.tag));
    if (_thirdView.tag == 0) {
        self.firstView.clipsToBounds = YES;
        _thirdView.frame = CGRectMake(0, 0, _screenW * 0.5, _screenW * 0.5);
        _thirdView.center = CGPointMake(0.5 * CGRectGetWidth(self.secondView.frame), 0.5 * CGRectGetWidth(self.secondView.frame));
    }else {
        self.firstView.clipsToBounds = NO;
        
        [[UIApplication sharedApplication].keyWindow addSubview:self.keyWindowView];
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self.keyWindowView];
        
        _thirdView.frame = CGRectMake(0, 0, _screenW, _screenH);
        _thirdView.center = CGPointMake(0.5 * CGRectGetWidth(self.firstView.frame), 0.5 * CGRectGetWidth(self.firstView.frame));
    }
}

@end
