//
//  YMMPopupMaskView.h
//  YMMBaseProject
//
//  Created by zhejunshen on 16/7/5.
//  Copyright © 2016年 kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWPopupMaskView : UIView


/**
 *  是否点击即消失,默认是NO
 */
@property (nonatomic) BOOL ymm_tapToDismiss;

/**
 *  动画持续时间
 */
@property (nonatomic)CGFloat ymm_animationDuration;

/**
 *  内容容器视图 （请勿直接将subviews添加在PopupMaskView上，添加到contentView）
 */
@property (nonatomic, readonly)UIView *ymm_contentView;

/**
 *  蒙板加载视图 (重载后请调用super方法)
 */
- (void)ymm_loadView;

/**
 *  蒙板将要显示时被调用
 */
- (void)ymm_maskWillAppear;

/**
 *  蒙板正在显示时被调用
 */
- (void)ymm_maskDoAppear;

/**
 *  蒙板已显示时被调用
 */
- (void)ymm_maskDidAppear;

/**
 *  蒙板将要消失时被调用
 */
- (void)ymm_maskWillDisappear;

/**
 *  蒙板正在消失时被调用
 */
- (void)ymm_maskDoDisappear;

/**
 *  蒙板已消失时被调用
 */
- (void)ymm_maskDidDisappear;

/**
 *  显示弹出式蒙板视图
 *
 *  @param view         弹出的父视图
 *  @param offsetInsets 偏移边距
 *  @param maskColor    蒙板颜色
 *  @param completion   显示完成Block
 *  @param dismission   消失完成Block
 */
- (void)ymm_showInView:(UIView *)view
         offsetInsets:(UIEdgeInsets)offsetInsets
            maskColor:(UIColor *)maskColor
           completion:(void(^)(void))completion
           dismission:(void(^)(void))dismission;

/**
 *  解散弹出式蒙板视图
 */
- (void)ymm_doDismiss;

@end
