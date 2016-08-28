//
//  ViewController.m
//  倒计时
//
//  Created by  Jierism on 16/8/28.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (nonatomic,strong) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)start
{
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (IBAction)stop
{
    [self.timer invalidate];
}

// 改变数字的监听方法
- (void)updateTimer:(NSTimer *)timer
{
   // NSLog(@"%s",__func__);

    // 取出标签中的数字
    int count = self.countLabel.text.intValue;
    
    //
    if (count == 0) {
        [self stop];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"结束了" message:@"点击X重新开始" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:alertAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        self.countLabel.text = [NSString stringWithFormat:@"%d",--count];
    }
}
- (IBAction)over:(UIBarButtonItem *)sender {
    
    self.countLabel.text = @"10";
}

@end
