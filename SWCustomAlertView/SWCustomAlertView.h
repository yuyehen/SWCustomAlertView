//
//  YMMCustomAlert.h
//  YMMBaseProject
//
//  Created by sunwei on 16/8/23.
//  Copyright © 2016年 kevin. All rights reserved.
//

#import "SWPopupMaskView.h"

#define Define_Btn_Color [UIColor blueColor]
#define Define_Lab_Color [UIColor blackColor]
#define Define_CancelBtn @"确认"
//取消为－1，其它按照数组顺序排列
typedef void (^AlertViewCallBack)(NSInteger buttonIndex);

@interface SWCustomAlertView : SWPopupMaskView
/**
 *  默认为 NO，设为YES弹窗不消失，再次改为NO时弹窗消失
 */
@property (nonatomic, assign) BOOL alwayDisplay;
/**
 *  默认为 NO，默认时弹框会显示完一个后显示后面的，设为YES时，如果当前有弹窗显示则不显示该弹窗
 */
@property (nonatomic, assign) BOOL isOnlyOne;
/**
 *  titleLab (自定义使用，可不修改)
 */
@property (nonatomic, strong) UILabel *titleLab;
/**
 *  messageLab (自定义使用，可不修改)
 */
@property (nonatomic, strong) UILabel *messageLab;
/**
 *  cancelBtn (取消按钮，可自定义)
 */
@property (nonatomic, strong) UIButton *cancelBtn;
/**
 *  cancelBtn的字体颜色
 */
@property (nonatomic, strong) UIColor *cancelBtnTitleColor;
/**
 *  otherBtn的字体颜色
 */
@property (nonatomic, strong) UIColor *otherBtnTitleColor;
/**
 *  cancelBtn和otherBtn的字体大小
 */
@property (nonatomic, assign) CGFloat buttonTitleSize;
/**
 *  可自定义的View,customView在外面创建赋值即可,需要事先设好frame，width与ymm_contentView相同
 */
@property (nonatomic, strong) UIView *customView;
/**
 *  button事件
 */
@property (nonatomic, copy) AlertViewCallBack callBack;
/**
 *  init方法
 *
 *  @param title             title
 *  @param message           message
 *  @param cancelButtonTitle cancelTitle
 *  @param otherButtonTitles otherButtonTitles<NSString *>
 *  @param actionBlock       点击时间回调block
 *
 *  @return self
 */
- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSArray *)otherButtonTitles
        actionBlock:(AlertViewCallBack)actionBlock;
/**
 *  显示
 */
- (void)show;
/**
 *  消失
 */
- (void)dismiss;
@end
