//
//  YMMPopupMaskView.m
//  YMMBaseProject
//
//  Created by zhejunshen on 16/7/5.
//  Copyright © 2016年 kevin. All rights reserved.
//

#import "SWPopupMaskView.h"

@interface SWPopupMaskView () {
    //是否已移除
    BOOL isDismissed;
    
    dispatch_once_t loadOnceToken;
}

@property (nonatomic, copy) void(^ymm_dismission)(void);
@property (nonatomic, strong, readwrite) UIView *ymm_contentView;

@end

@implementation SWPopupMaskView

#pragma mark UIResponder Methods

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    if (_ymm_tapToDismiss) {
        [self ymm_doDismiss];
    }
}

#pragma mark Base Methods

- (void)ymm_loadView {
    // do noting in base
}

- (void)ymm_maskWillAppear {
    // do noting in base
}

- (void)ymm_maskDoAppear {
    // do noting in base
}

- (void)ymm_maskDidAppear {
    // do noting in base
}

- (void)ymm_maskWillDisappear {
    // do noting in base
}

- (void)ymm_maskDoDisappear {
    // do noting in base
}

- (void)ymm_maskDidDisappear {
    // do noting in base
}

#pragma mark Property Methods

- (UIView *)ymm_contentView {
    
    if (!_ymm_contentView) {
        _ymm_contentView = [[UIView alloc]init];
        _ymm_contentView.frame = self.bounds;
        [self addSubview:_ymm_contentView];
    }
    
    return _ymm_contentView;
}

#pragma mark Inerface Methods

- (void)ymm_showInView:(UIView *)view offsetInsets:(UIEdgeInsets)offsetInsets maskColor:(UIColor *)maskColor completion:(void(^)(void))completion dismission:(void(^)(void))dismission {
    
    isDismissed = NO;
    
    self.ymm_dismission = dismission;
    
    CGRect frame = view.bounds;
    frame.origin.x += offsetInsets.left;
    frame.origin.y += offsetInsets.top;
    frame.size.width -= offsetInsets.left+offsetInsets.right;
    frame.size.height -= offsetInsets.top+offsetInsets.bottom;
    
    self.backgroundColor = [UIColor clearColor];
    self.frame = frame;
    self.clipsToBounds = YES;
    [view addSubview:self];
    
    dispatch_once(&loadOnceToken, ^{
        [self ymm_loadView];
    });
    
    [self ymm_maskWillAppear];
    
    [UIView animateWithDuration:_ymm_animationDuration?_ymm_animationDuration:.3f
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self ymm_maskDoAppear];
                         self.backgroundColor = maskColor;
                     }
                     completion:^(BOOL finished) {
                         [self ymm_maskDidAppear];
                         
                         if (completion) {
                             completion();
                         }
                     }];
}

- (void)ymm_doDismiss {
    
    if (isDismissed) {
        return;
    }
    else {
        isDismissed = YES;
    }
    
    [self ymm_maskWillDisappear];
    
    [UIView animateWithDuration:_ymm_animationDuration?_ymm_animationDuration:.3f
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationCurveEaseInOut
                     animations:^{
                         
                         [self ymm_maskDoDisappear];
                         self.backgroundColor = [UIColor clearColor];
                         self.ymm_contentView.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         
                         [self ymm_maskDidDisappear];
                         
                         if (_ymm_dismission) {
                             _ymm_dismission();
                         }
                         
                         [self removeFromSuperview];
                     }
     ];
    
}

@end
