//
//  QXYPopView.h
//  ManagementOfTeachers
//
//  Created by mac on 16/8/4.
//  Copyright © 2016年 QXY. All rights reserved.
//  用户弹窗窗口的基础视图，扩展视图可继承此类

#import <UIKit/UIKit.h>
typedef enum{
    /** 向上弹出窗口 */
    PopViewAnimationUp,
    /** 向下弹出窗口 */
    PopViewAnimationDown,
    /** 向左弹出窗口 */
    PopViewAnimationLeft,
    /** 向右弹出窗口 */
    PopViewAnimationRight,
}PopViewAnimationType;
@interface QXYPopView : UIView

/** 动画方向 */
@property (nonatomic,assign) PopViewAnimationType type;
/** 动画开始时间 */
@property (nonatomic,assign) CGFloat startAnimateDuration;
/** 动画结束时间 */
@property (nonatomic,assign) CGFloat endAnimateDuration;
/** 内容视图 */
@property (nonatomic,strong) UIView *contentView;
/** 背景图 */
@property (nonatomic,strong) UIImage *backgroundImage;
/**
 * 显示
 */
- (void)show;
/**
 * 隐藏
 */
- (void)dismiss;

@end
