//
//  IntroductionViewController.h
//  Weather
//
//  Created by 赵进雄 on 15/2/2.
//  Copyright (c) 2015年 feinno. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroductionViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic, strong) UIPageControl *pageCtrl;
@property (nonatomic, strong) UIScrollView *introScroll;
@property (nonatomic, strong) NSArray *imgArray;

/*
 *  功能说明：单例方法，获取单例对象指针
 *
 *  参数说明：无参数
 *
 */
+ (IntroductionViewController *)intro;

/*
 *  功能说明：单例方法，获取单例对象指针
 *
 *  参数说明：无参数
 *
 */
- (void)resetIntroScrollView;

@end