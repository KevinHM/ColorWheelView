//
//  KHMColorWheelView.m
//
//  Created by KevinHM on 15/8/8.
//  Copyright (c) 2015年 KevinHM. All rights reserved.
//

#import "KHMColorWheelView.h"
#import "UIImage+Color.h"

static NSInteger const DragImageViewSize = 23;

@interface KHMColorWheelView ()
@property (nonatomic, readwrite, strong) UIColor *currentColor;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *dragImgView;

@end

@implementation KHMColorWheelView

#pragma mark - View Life Cycle

- (instancetype)init {
    if (self = [super init]) {
        [self setupDefaultVariables];
        [self configuredViewHierarchy];
        [self layoutComponents];
        [self setupInteractionsOnComponents];
    }
    
    return self;
}

//Support IB
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupDefaultVariables];
        [self configuredViewHierarchy];
        [self layoutComponents];
        [self setupInteractionsOnComponents];
    }
    
    return self;
}

#pragma mark - private method

- (void)setupDefaultVariables {
    _continueReponse = NO;
}

- (void)configuredViewHierarchy {
    [self addSubview:self.imageView];
    [self.imageView addSubview:self.dragImgView];
}

- (void)layoutComponents {
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    //AL For ImageView
    [self addConstraints:\
        [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_imageView]-0-|"
                                                options:NSLayoutFormatDirectionLeadingToTrailing
                                                metrics:nil
                                                  views:NSDictionaryOfVariableBindings(_imageView)]];
    [self addConstraints:\
        [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_imageView]-0-|"
                                                options:NSLayoutFormatDirectionLeadingToTrailing
                                                metrics:nil
                                                  views:NSDictionaryOfVariableBindings(_imageView)]];
    
    
    //AL For DragImgView
    [self.imageView addConstraints:\
        [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_dragImgView(==width)]"
                                                options:NSLayoutFormatDirectionLeadingToTrailing
                                                metrics:@{@"width" : @(self.dragImageViewSize?:DragImageViewSize)}
                                                  views:NSDictionaryOfVariableBindings(_dragImgView)]];
    [self.imageView addConstraints:\
        [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_dragImgView(==height)]"
                                                options:NSLayoutFormatDirectionLeadingToTrailing
                                                metrics:@{@"height" : @(self.dragImageViewSize?:DragImageViewSize)}
                                                  views:NSDictionaryOfVariableBindings(_dragImgView)]];
    
    [self.imageView addConstraint:\
       [NSLayoutConstraint constraintWithItem:self.dragImgView
                                    attribute:NSLayoutAttributeCenterX
                                    relatedBy:NSLayoutRelationEqual
                                       toItem:self.imageView
                                    attribute:NSLayoutAttributeCenterX
                                   multiplier:1.0 constant:0]];
    
    [self.imageView addConstraint:\
        [NSLayoutConstraint constraintWithItem:self.dragImgView
                                     attribute:NSLayoutAttributeCenterX
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.imageView
                                     attribute:NSLayoutAttributeCenterX
                                    multiplier:1.0 constant:0.0]];
}

- (void)setupInteractionsOnComponents {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(tapEvent:)];
    
    [self.imageView addGestureRecognizer:tap];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(panEvent:)];
    
    [self.imageView addGestureRecognizer:pan];
}

- (void)updateDragImageCenter:(CGPoint)center {
    self.dragImgView.center = center;
}

- (CGPoint)obtainTouchPointByGestureRecognizer:(UIGestureRecognizer *)sender {
    
    CGPoint touchPoint = [sender locationInView:self.imageView];
    
    CGFloat frameWidth = self.imageView.image.size.width;
    CGFloat frameHeight = self.imageView.image.size.height;
    
    if (touchPoint.x > frameWidth) {
        touchPoint.x = frameWidth;
    }
    else if (touchPoint.x < 0) {
        touchPoint.x = 0;
    }
    
    if (touchPoint.y > frameHeight) {
        touchPoint.y = frameHeight;
    }
    else if (touchPoint.y < 0) {
        touchPoint.y = 0;
    }
    
    return touchPoint;
}

- (BOOL)validateColor:(UIColor *)color {
    
    CGFloat red, green, blue, alpha;
    if ([color getRed:&red green:&green blue:&blue alpha:&alpha]) {
        if (self.colorMinimumAlpha != 0 && alpha < self.colorMinimumAlpha) {
            return NO;
        }
        
        if (self.colorMinimumRed != 0 && red < self.colorMinimumRed) {
            return NO;
        }
        
        if (self.colorMinimumGreen != 0 && green < self.colorMinimumGreen) {
            return NO;
        }
        
        if (self.colorMinimumBlue != 0 && blue < self.colorMinimumBlue) {
            return NO;
        }
        
        return YES;
    }
    
    return NO;
}

#pragma mark - Event Response

- (void)tapEvent:(UITapGestureRecognizer *)sender {
    
    CGPoint touchPoint = [self obtainTouchPointByGestureRecognizer:sender];
    
    UIColor *pointColor = [self.imageView.image colorAtPixel:touchPoint];
    
    //取色满足基本条件则回调颜色并移动接触点
    if ( [self validateColor:pointColor] ) {
        
        self.currentColor = pointColor;
        
        [self updateDragImageCenter:touchPoint];
        if (self.colorDidChangedBlock) {
            self.colorDidChangedBlock(pointColor);
        }
        
        if (self.continueReponse) {
            if (self.colorEventBlock) {
                self.colorEventBlock (pointColor);
            }
        }
        else {
            if (sender.state == UIGestureRecognizerStateEnded) {
                if (self.colorEventBlock) {
                    self.colorEventBlock (pointColor);
                }
            }
        }
    }
}

- (void)panEvent:(UIPanGestureRecognizer *)sender {
    CGPoint touchPoint = [self obtainTouchPointByGestureRecognizer:sender];
    
    UIColor *pointColor = [self.imageView.image colorAtPixel:touchPoint];
    
    if ([self validateColor:pointColor]) {
        
        self.currentColor = pointColor;
        
        [self updateDragImageCenter:touchPoint];
        
        if (self.colorDidChangedBlock) {
            self.colorDidChangedBlock(pointColor);
        }
        
        if (self.continueReponse) {
            if (self.colorEventBlock) {
                self.colorEventBlock (pointColor);
            }
        }
        else {
            if (sender.state == UIGestureRecognizerStateEnded) {
                if (self.colorEventBlock) {
                    self.colorEventBlock (pointColor);
                }
            }
        }
    }
    
    //begin and end
    if (sender.state == UIGestureRecognizerStateBegan) {
        if (self.pressBeginEvent) {
            self.pressBeginEvent();
        }
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (self.pressEndEvent) {
            self.pressEndEvent();
        }
    }
}

#pragma mark - Getter/Setter

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:\
                        [UIImage imageNamed:@"pic_color_wheel"]];
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

- (UIImageView *)dragImgView {
    if (!_dragImgView) {
        _dragImgView = [[UIImageView alloc] initWithImage:\
                            [UIImage imageNamed:@"color_ wheel_progress"]];
        _dragImgView.userInteractionEnabled = YES;
    }
    
    return _dragImgView;
}

- (UIColor *)currentColor {
    if (!_currentColor) {
        _currentColor = [UIColor whiteColor];
    }
    
    return _currentColor;
}


@end
