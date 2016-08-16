//
//  QXYPopView.m
//  ManagementOfTeachers
//
//  Created by mac on 16/8/4.
//  Copyright © 2016年 QXY. All rights reserved.
//

#import "QXYPopView.h"
@interface QXYPopView()
/** 背景 */
@property (nonatomic,strong) UIButton *bgBtn;
@end
@implementation QXYPopView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        // 添加点击手势
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBG:)];
//        [self addGestureRecognizer:tap];
        
        // 默认背景色
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        /** 动画方式 */
        self.type = PopViewAnimationUp;
        /** 动画开始时间 */
        self.startAnimateDuration = 0.3;
        /** 动画结束时间 */
        self.endAnimateDuration = 0.3;
//        self.backgroundColor = [UIColor clearColor];
        
        self.bgBtn = [[UIButton alloc]init];
        [self.bgBtn addTarget:self action:@selector(bgClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.bgBtn];
        
    }
    return self;
}

- (void)bgClicked{
    [self dismiss];
    [self endEditing:YES];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage{
    _backgroundImage = backgroundImage;
    [self.bgBtn setBackgroundImage:backgroundImage forState:UIControlStateNormal];
}


//- (void)tapBG:(UITapGestureRecognizer *)tap{
//    CGPoint p = [tap locationInView:self];
//    // 如果点击的是背景视图，则隐藏
//    bool isContent = CGRectContainsPoint(self.contentView.frame, p);
//    if (isContent==false) {
//        [self dismiss];
//    }else{
//        [self endEditing:YES];
//    }
//}

// 添加内容视图
- (void)setContentView:(UIView *)contentView{
    _contentView = contentView;
    [self addSubview:contentView];
}

/**
 * 显示
 */
- (void)show{
    [self setAnimateFrameIsShow:YES];
}

/**
 * 隐藏
 */
- (void)dismiss{
    [self setAnimateFrameIsShow:NO];
}

/**
 * 设置动画
 */
- (void)setAnimateFrameIsShow:(BOOL)isShow{
    if (isShow) {// 添加
        // 先调用布局，否则视图会不可见
        [self setNeedsLayout];
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    
    CGFloat width = [UIApplication sharedApplication].keyWindow.bounds.size.width;
    CGFloat height = [UIApplication sharedApplication].keyWindow.bounds.size.height;
    // 获取内容视图的宽度高度
    CGFloat contentH = CGRectGetHeight(self.contentView.frame);
    CGFloat contentW = CGRectGetWidth(self.contentView.frame);
    CGRect originFrame;
    CGRect newFrame;
    switch (self.type) {
            /** 向上弹出窗口 */
        case PopViewAnimationUp:{
            originFrame = CGRectMake(0, height, contentW, contentH);
            newFrame = CGRectMake(0, height-contentH, width, contentH);
        }break;
            /** 向下弹出窗口 */
        case PopViewAnimationDown:{
            originFrame = CGRectMake(0, -height, contentW, contentH);
            newFrame = CGRectMake(0, 0, contentW, contentH);
        }break;
            /** 向右弹出窗口 */
        case PopViewAnimationRight:{
            originFrame = CGRectMake(-contentW, 0, contentW, contentH);
            newFrame = CGRectMake(0, 0, contentW, contentH);
        }break;
            /** 向左弹出窗口 */
        case PopViewAnimationLeft:{
            originFrame = CGRectMake(width, 0, contentW, contentH);
            newFrame = CGRectMake(width-contentW, 0, contentW, contentH);
        }break;
    }
    
    CGFloat animateDuration;
    if (isShow) {
        animateDuration = self.startAnimateDuration;
        self.contentView.frame = originFrame;
    }else{
        animateDuration = self.endAnimateDuration;
        self.contentView.frame = newFrame;
    }
    
    // 动画
    [UIView animateWithDuration:animateDuration animations:^{
        if (isShow) {
            self.contentView.frame = newFrame;
        }else{
            self.contentView.frame = originFrame;
        }
    } completion:^(BOOL finished) {
        if (isShow==NO) {
            [self removeFromSuperview];
        }
    }];

}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.frame = [UIApplication sharedApplication].keyWindow.bounds;
    self.bgBtn.frame = self.bounds;
}

@end
