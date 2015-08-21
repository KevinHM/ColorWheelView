//
//  KHMColorWheelView.h
//
//  Created by KevinHM on 15/8/8.
//  Copyright (c) 2015年 KevinHM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+Color.h"

NS_CLASS_AVAILABLE_IOS(6_0) @interface KHMColorWheelView : UIView

@property (nonatomic, readonly, strong) UIColor *currentColor; /**< 当前颜色*/
@property (nonatomic, assign) BOOL continueReponse; /**< 是否持续响应事件*/

@property (nonatomic, copy) void (^colorDidChangedBlock)(UIColor *color); /**< 颜色变化回调*/
@property (nonatomic, copy) void (^colorEventBlock)(UIColor *color); /**< 颜色相关事件回调*/
@property (nonatomic, copy) void (^pressBeginEvent)(void); /**< 开始触控*/
@property (nonatomic, copy) void (^pressEndEvent)(void); /**< 结束触控*/

/**************************************************************************
 * 预设值 ： 可高度自定义
 **************************************************************************/
@property (nonatomic, assign) CGFloat dragImageViewSize UI_APPEARANCE_SELECTOR; /**< 预设中心拖动圆半径*/
@property (nonatomic, assign) CGFloat colorMinimumAlpha UI_APPEARANCE_SELECTOR; /**< 预设图形可用区域色素点alpha下限*/
@property (nonatomic, assign) CGFloat colorMinimumRed UI_APPEARANCE_SELECTOR; /**< 色素点red下限*/
@property (nonatomic, assign) CGFloat colorMinimumGreen UI_APPEARANCE_SELECTOR; /**< 色素点green下限*/
@property (nonatomic, assign) CGFloat colorMinimumBlue UI_APPEARANCE_SELECTOR; /**< 色素点blue下限*/
@property (nonatomic, strong) UIImage *colorWheelBGImage UI_APPEARANCE_SELECTOR; /**< 色轮的地图*/
@property (nonatomic, strong) UIImage *colorWheelDragImage UI_APPEARANCE_SELECTOR; /**< 色轮上的拖拽指示*/

@end
