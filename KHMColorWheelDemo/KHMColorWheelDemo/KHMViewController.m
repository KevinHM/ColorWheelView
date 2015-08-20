//
//  KHMViewController.m
//  KHMColorWheelDemo
//
//  Created by XiaoHM on 15/8/8.
//  Copyright (c) 2015年 KevinHM. All rights reserved.
//

#import "KHMViewController.h"

#import "KHMColorWheelView.h"
#import "UIImage+Color.h"
#import <Masonry/Masonry.h>

static NSInteger const KHMColorWheelViewSize = 230; //因为我使用的图片为这个尺寸 @2x\@3x

@interface KHMViewController ()
@property (nonatomic, weak) IBOutlet KHMColorWheelView *colorWheelView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSTimer *eventTimer;

@end

@implementation KHMViewController

#pragma mark - View Life Cycle

- (void)awakeFromNib {
    [[KHMColorWheelView appearance] setColorMinimumAlpha:.1f];
    [[KHMColorWheelView appearance] setDragImageViewSize:46.f];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self defaultConfiguration]; /*! 默认设置*/
    [self configuredViewHierarchy]; /*! 构建视图层级*/
    [self layoutComponents]; /*! 视图AL布局*/
}

#pragma mark - private method

- (void)defaultConfiguration {
    
   
    
    self.view.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    self.colorWheelView.layer.cornerRadius = (KHMColorWheelViewSize) / 2.0;
    self.colorWheelView.layer.masksToBounds = YES;
    
    self.imageView.backgroundColor = [UIColor whiteColor];
    
    __weak typeof(self) weakSelf = self;
    self.colorWheelView.colorDidChangedBlock = ^(UIColor *color) {
        weakSelf.imageView.image = [UIImage imageWithColor:color];
        NSLog(@"Obtain Color : %@",color);
    };
    
    self.colorWheelView.colorEventBlock = ^(UIColor *color) {
        NSLog(@"Color About Event");
    };
    
    self.colorWheelView.pressEndEvent = ^{
        NSLog(@"pressEndEvent");
    };
    
    self.colorWheelView.pressBeginEvent = ^ {
        NSLog(@"pressBeginEvent");
    };
}

- (void)configuredViewHierarchy {
//    manual code
//    [self.view addSubview:self.colorWheelView];
    [self.view addSubview:self.imageView];
}

- (void)layoutComponents {
// manual code
//    [self.colorWheelView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(KHMColorWheelViewSize, KHMColorWheelViewSize));
//        make.centerY.equalTo(self.view.mas_centerY);
//        make.centerX.equalTo(self.view.mas_centerX);
//    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 40));
        make.bottom.equalTo(self.colorWheelView.mas_top).offset(-20);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
}


#pragma mark - Getter/Setter
// manual code
//- (KHMColorWheelView *)colorWheelView {
//    if (!_colorWheelView) {
//        _colorWheelView = [[KHMColorWheelView alloc] init];
//    }
//    
//    return _colorWheelView;
//}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    
    return _imageView;
}


@end
