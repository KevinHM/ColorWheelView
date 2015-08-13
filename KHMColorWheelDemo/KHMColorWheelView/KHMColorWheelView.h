//
//  KHMColorWheelView.h
//
//  Created by KevinHM on 15/8/8.
//  Copyright (c) 2015年 KevinHM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHMColorWheelView : UIView
@property (nonatomic, readonly, strong) UIColor *currentColor; /*!< 当前颜色*/
@property (nonatomic, assign) BOOL continueReponse; /*!< 是否持续响应事件*/

@property (nonatomic, copy) void (^colorDidChangedBlock)(UIColor *color); /*!< 颜色变化回调*/
@property (nonatomic, copy) void (^colorEventBlock)(UIColor *color); /*!< 颜色相关事件回调*/
@property (nonatomic, copy) void (^pressBeginEvent)(void); /**< 开始触控*/
@property (nonatomic, copy) void (^pressEndEvent)(void); /**< 结束触控*/

@end
