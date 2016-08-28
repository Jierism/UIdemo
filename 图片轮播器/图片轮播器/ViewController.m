//
//  ViewController.m
//  图片轮播器
//
//  Created by  Jierism on 16/8/23.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import "ViewController.h"

#define KimageCount 5

@interface ViewController ()<UIScrollViewDelegate>

@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) UIPageControl *pageControl;

@property (strong,nonatomic) NSTimer *timer;


@end

@implementation ViewController

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 20, 300, 130)];
        _scrollView.backgroundColor = [UIColor blueColor];
        [self.view addSubview:_scrollView];
        
        // 设置分页
        _scrollView.pagingEnabled = YES;
        
        // 取消水平滚动条
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
        // 取消弹簧
        _scrollView.bounces = NO;
        
        // 设置内容
        _scrollView.contentSize = CGSizeMake(KimageCount * _scrollView.bounds.size.width, 0);
        
        // 设置代理
        _scrollView.delegate = self;
        
    }

    return _scrollView;
}

- (UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        // 设置分页控件
        _pageControl = [[UIPageControl alloc] init];
        // 控件总页数
        _pageControl.numberOfPages = KimageCount;
        // 控件尺寸
        CGSize size = [_pageControl sizeForNumberOfPages:KimageCount];
        
        _pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
        _pageControl.center = CGPointMake(self.view.center.x, 130);
        
        // 设置颜色
        _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        _pageControl.pageIndicatorTintColor = [UIColor redColor];
        
        [self.view addSubview:_pageControl];
        
        // 设置page的监听方法，实现点击小点也能切换图片
        [_pageControl addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}

// 实现监听方法
- (void)pageChange:(UIPageControl *)page
{
    CGFloat x = page.currentPage * self.scrollView.bounds.size.width;
    //animated实现动画效果
    [self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置图片
    for (int i = 0; i < KimageCount; i++) {
        NSString *imageName = [NSString stringWithFormat:@"img_%02d",i + 1];
        UIImage *image = [UIImage imageNamed:imageName];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.scrollView.bounds];
        imageView.image = image;
        [self.scrollView addSubview:imageView];
        
    // 计算imageView的位置
        [self.scrollView.subviews enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL * _Nonnull stop) {
            CGRect frame = imageView.frame;
            frame.origin.x = idx * frame.size.width;
            
            imageView.frame = frame;
        }];
       // NSLog(@"%@",self.scrollView.subviews);
        
    }
    
    self.pageControl.currentPage = 0;
    
    // 启动时钟
    [self startTimer];
    
}


- (void)startTimer
{
    self.timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    // 时钟模式有两种：1、 NSDefaultRunLoopMode,当其他东西运动时，时钟会停止，但仍在累计
                //   2、NSRunLoopCommonModes,时钟始终运行
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)updateTimer
{
   // 使页号发生变化
    int page =(self.pageControl.currentPage + 1) % KimageCount;
    self.pageControl.currentPage = page;
    [self pageChange:self.pageControl];
}


#pragma mark - ScrollView Delegate代理方法
// 当滚动视图停下来，修改page的页数
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // NSLog(@"%s",__func__);
   // NSLog(@"%@",NSStringFromCGPoint(self.scrollView.contentOffset));
    
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    self.pageControl.currentPage = page;
    
    
}

/*
 使用NSRunLoopCommonModes模式运行时钟，抓不住图片。
 解决方法：实现代理方法，在拖动图片时暂停时钟，放手时，开启时钟
 */

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate]; // 暂停时钟的唯一方法
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}


@end
