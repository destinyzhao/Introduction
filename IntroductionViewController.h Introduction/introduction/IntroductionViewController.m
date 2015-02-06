//
//  IntroductionViewController.m
//  Weather
//
//  Created by 赵进雄 on 15/2/2.
//  Copyright (c) 2015年 feinno. All rights reserved.
//

#import "IntroductionViewController.h"
#import "AppDelegate.h"
#import "UIView+Size.h"
#import "ViewController.h"

#define SCREEN_BOUNDS [[UIScreen mainScreen] bounds]

@interface IntroductionViewController ()

@end

@implementation IntroductionViewController

static IntroductionViewController * _intro = nil;
+ (IntroductionViewController *)intro
{
    if (_intro == nil) {
        _intro = [[IntroductionViewController alloc]init];
    }
    return _intro;
}

- (void)loadView
{
    [super loadView];
    
    
    self.view.backgroundColor = [UIColor grayColor];
    //  首次启动用户介绍拖动页面
    _introScroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _introScroll.delegate = self;
    _introScroll.showsHorizontalScrollIndicator = NO;
    [_introScroll setPagingEnabled:YES];
    _introScroll.bounces = NO;
    [self.view addSubview:_introScroll];
    //  滑动页面标示控制器
    
    _pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 64, SCREEN_BOUNDS.size.width, 30)];
    _pageCtrl.backgroundColor = [UIColor clearColor];
    [_pageCtrl addTarget:self action:@selector(pageIndexChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_pageCtrl];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _imgArray = [NSArray arrayWithObjects:@"i5_whbg08_640x1136@2x.jpg",@"i5_whbg09_640x1136@2x.jpg",@"i5_whbg10_640x1136@2x.jpg",@"i5_whbg11_640x1136@2x.jpg", nil];
    
    [_introScroll setContentSize:CGSizeMake(_imgArray.count * self.view.width, self.view.height)];
    
    //  初始化引导图片
    CGRect imageRect = self.view.bounds;
    for (NSInteger i = 0; i < _imgArray.count; i++)
    {
        
        UIImageView *featherImageView = [[UIImageView alloc] initWithFrame:imageRect];
        featherImageView.backgroundColor = [UIColor clearColor];
        featherImageView.image = [UIImage imageNamed:[_imgArray objectAtIndex:i]];
        [_introScroll addSubview:featherImageView];
        
        if (i == _imgArray.count-1)
        {
    
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake((SCREEN_BOUNDS.size.width-168)/2.0, SCREEN_BOUNDS.size.height-43, 168, 32);
            [button setTitle:@"开始体验" forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor yellowColor]];
            [button addTarget:self action:@selector(introEnterPressed) forControlEvents:UIControlEventTouchUpInside];
            [featherImageView addSubview:button];
            [featherImageView setUserInteractionEnabled:YES];
        }
        
        imageRect.origin.x += imageRect.size.width;
    }
    _pageCtrl.numberOfPages = _imgArray.count;
    _pageCtrl.currentPage = 0;
    self.view.frame = self.view.bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)resetIntroScrollView
{
    _introScroll.contentOffset = CGPointZero;
}

- (void)pageIndexChange:(id)sender
{
    NSLog(@"%ld", (long)_pageCtrl.currentPage);
}

- (void)introEnterPressed
{
    UIApplication *App=[UIApplication sharedApplication];
    AppDelegate *delegate = (AppDelegate *)App.delegate;
    [delegate JumpViewController];
}

#pragma mark - scrollviewdelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    _pageCtrl.currentPage = page;
}

             
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
