//
//  YMMCustomAlert.m
//  YMMBaseProject
//
//  Created by sunwei on 16/8/23.
//  Copyright © 2016年 kevin. All rights reserved.
//

#define kScreenFrame [UIScreen mainScreen].bounds
#define kContentWidth kScreenFrame.size.width - 15 * 2 - 10 * 2
#define KSpaceHight 15
#define KLineWidth 0.5
#define KButtonHight 44
#define KTitleFont 18
#define KMessageFont 16

#import "SWCustomAlertView.h"

static NSMutableArray* numberArray;
static UIWindow *window;

@interface SWCustomAlertView ()

@property (nonatomic, strong) NSMutableArray *otherBtns;


@end

@implementation SWCustomAlertView

#pragma mark - Setter
- (void)setAlwayDisplay:(BOOL)alwayDisplay {
    _alwayDisplay = alwayDisplay;
    if (!alwayDisplay) {
        [self dismiss];
    }
}
- (void)setCancelBtnTitleColor:(UIColor *)cancelBtnTitleColor {
    [self.cancelBtn setTitleColor:cancelBtnTitleColor forState:UIControlStateNormal];
}
- (void)setOtherBtnTitleColor:(UIColor *)otherBtnTitleColor {
    if (self.otherBtns.count>0) {
        [self.otherBtns enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *otherBtn = obj;
            [otherBtn setTitleColor:otherBtnTitleColor forState:UIControlStateNormal];
        }];
    }
}
- (void)setButtonTitleSize:(CGFloat)buttonTitleSize {
    self.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:buttonTitleSize];
    [self.otherBtns enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *otherBtn = obj;
        otherBtn.titleLabel.font = [UIFont systemFontOfSize:buttonTitleSize];
    }];
}
- (void)setCustomView:(UIView *)customView {
    _customView = customView;
    [self.ymm_contentView addSubview:_customView];
}
#pragma mark - init
- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSArray *)otherButtonTitles
        actionBlock:(AlertViewCallBack)actionBlock {
    self = [super init];
    if (self) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self initUIControl];
        });
        self.titleLab.text = title;
        self.messageLab.text = message;
        [self.cancelBtn setTitle:cancelButtonTitle?cancelButtonTitle:Define_CancelBtn forState:UIControlStateNormal];
        [self addOtherBtn:otherButtonTitles];
        _callBack = actionBlock;
    }
    return self;
}

- (void)initUIControl {
    if (!numberArray) {
        numberArray = [[NSMutableArray alloc] init];
    }
    [self.ymm_contentView setBackgroundColor:[UIColor whiteColor]];
    self.ymm_contentView.frame = CGRectMake(0,0, CGRectGetWidth(kScreenFrame) - KSpaceHight * 2, 0);
    self.ymm_contentView.layer.cornerRadius = 8;
    self.ymm_contentView.layer.masksToBounds = YES;
    [self.ymm_contentView addSubview:self.titleLab];
    [self.ymm_contentView addSubview:self.messageLab];
    [self.ymm_contentView addSubview:self.cancelBtn];
}

- (void)addOtherBtn:(NSArray *)btns {
    for (NSString* title in btns) {
        if ([title isKindOfClass:[NSString class]] && title.length > 0) {
            UIButton *otherBtn = [self otherBtn:title];
            otherBtn.tag = [btns indexOfObject:title];
            [self.otherBtns addObject:otherBtn];
            [self.ymm_contentView addSubview:otherBtn];
        }else {
            break;
        }
    }
}

- (UIButton *)otherBtn:(NSString *)title {
    UIButton *otherBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [otherBtn setTitle:title forState:UIControlStateNormal];
    otherBtn.titleLabel.font = [UIFont boldSystemFontOfSize:KTitleFont];
    [otherBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    return otherBtn;
}

#pragma mark - Action
- (void)clickButton:(UIButton *)sender {
    if (_callBack) {
        _callBack(sender.tag);
    }
    if (!_alwayDisplay) {
        [self dismiss];
    }
}

#pragma mark - View show and hide

- (void)show {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_isOnlyOne && numberArray.count > 0) {
            return ;
        }
        [numberArray addObject:self];
        if (numberArray.count > 1) {
            return;
        }
        [self showView];
    });
}

- (void)showView {
    window.hidden = NO;
    [self ymm_showInView:self.window offsetInsets:UIEdgeInsetsMake(0, 0, 0, 0) maskColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.35] completion:nil dismission:^{

    }];
}

- (void)dismiss {
    [self ymm_doDismiss];
}

- (void)ymm_maskDidDisappear {
    if (numberArray.count) {
        [numberArray removeObjectAtIndex:0];
    }
    SWCustomAlertView* alert = numberArray.firstObject;
    [alert showView];
}

#pragma mark - UI Layout
- (void)ymm_maskWillAppear {
    CGFloat viewOriginX = 15;
    CGFloat tipViewOriginX = 10;
    CGFloat tipViewOriginY = KSpaceHight*2;
    CGFloat hight;
    CGFloat viewWidth = CGRectGetWidth(kScreenFrame) - viewOriginX * 2;
    if (self.titleLab.text.length > 0) {
        hight = [self viewHight:self.titleLab.text Font:self.titleLab.font Width:viewWidth];
        self.titleLab.frame = CGRectMake(0, tipViewOriginY, viewWidth, hight);
        tipViewOriginY += hight;
        tipViewOriginY += KSpaceHight;
    }else{
        self.titleLab.frame = CGRectMake(0, tipViewOriginY, viewWidth, 0);
    }
    if (self.messageLab.text.length > 0) {
        hight = [self viewHight:self.messageLab.text Font:self.messageLab.font Width:viewWidth-tipViewOriginX*2];
        self.messageLab.frame = CGRectMake(tipViewOriginX, tipViewOriginY, viewWidth-tipViewOriginX*2, hight);
        tipViewOriginY += hight;
        tipViewOriginY += KSpaceHight;
    }else{
        self.messageLab.frame = CGRectMake(tipViewOriginX, tipViewOriginY, viewWidth-tipViewOriginX*2, 0);
    }
    if (_customView) {
        _customView.frame = CGRectMake(0, tipViewOriginY, viewWidth, _customView.frame.size.height);
        tipViewOriginY += _customView.frame.size.height;
        tipViewOriginY += KSpaceHight;
    }
    tipViewOriginY += KSpaceHight;
    UIImageView *btnTopLineImageView = [self lineImageView];
    btnTopLineImageView.frame = CGRectMake(0, tipViewOriginY, viewWidth, KLineWidth);
    tipViewOriginY += KLineWidth;
    [self.ymm_contentView addSubview:btnTopLineImageView];
    CGFloat btnWidth = viewWidth/(self.otherBtns.count + 1);
    CGFloat btnOriginX = 0;
    for (int i = 0; i< self.otherBtns.count + 1; i++) {
        if (i == 0) {
            _cancelBtn.frame = CGRectMake(btnOriginX, tipViewOriginY, btnWidth, KButtonHight);
            btnOriginX += btnWidth;
        }else{
            UIImageView *btnLineImageView = [self lineImageView];
            btnLineImageView.frame = CGRectMake(btnOriginX, tipViewOriginY, KLineWidth, KButtonHight);
             [self.ymm_contentView addSubview:btnLineImageView];
            UIButton *otherBtn = self.otherBtns[i-1];
            otherBtn.frame = CGRectMake(btnOriginX+KLineWidth, tipViewOriginY, btnWidth, KButtonHight);
            btnOriginX += btnWidth + KLineWidth;
        }
    }
    tipViewOriginY += KButtonHight;
    self.ymm_contentView.frame = CGRectMake(0,0, viewWidth, tipViewOriginY);
    self.ymm_contentView.center = self.center;
}

#pragma mark - Getter
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.numberOfLines = 0;
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont boldSystemFontOfSize:KTitleFont];
        _titleLab.textColor = Define_Lab_Color;
    }
    return _titleLab;
}

- (UILabel *)messageLab {
    if (!_messageLab) {
        _messageLab = [[UILabel alloc] init];
        _messageLab.numberOfLines = 0;
        _messageLab.textAlignment = NSTextAlignmentCenter;
        _messageLab.font = [UIFont systemFontOfSize:KMessageFont];
        _messageLab.textColor = Define_Lab_Color;
    }
    return _messageLab;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:KTitleFont];
        _cancelBtn.tag = -1;
        [_cancelBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (NSMutableArray *)otherBtns {
    if (!_otherBtns) {
        _otherBtns = [[NSMutableArray array] init];
    }
    return _otherBtns;
}

- (UIImageView *)lineImageView {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor colorWithWhite:0.81 alpha:1];
    return imageView;
}

- (UIWindow *)window {
    if (!window) {
        window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        window.backgroundColor = [UIColor clearColor];
        window.windowLevel = UIWindowLevelAlert;
        UIViewController *VC = [[UIViewController alloc] init];
        window.rootViewController = VC;
//        self._ymm_taskPool.keywindow = _window;
        window.hidden = NO;
    }
    return window;
}
#pragma mark - 计算Lab高度
- (CGFloat)viewHight:(NSString *)string Font:(UIFont *)font Width:(CGFloat)width {
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    CGRect frame = self.frame;
    frame.size.height = rect.size.height*1.035;
    return frame.size.height;
}

+(NSMutableArray *)instanceCount{
    return numberArray;
}

- (void)dealloc {
    if (numberArray.count == 0) {
        window.hidden = YES;
        [window resignKeyWindow];
    }
    NSLog(@"销毁alert");
}

@end
