//
//  ViewController.m
//  用户登录
//
//  Created by  Jierism on 16/8/19.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *psw;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.userName becomeFirstResponder];
}

- (IBAction)login {
    
    NSLog(@"%s %@ %@",__func__,self.userName.text,self.psw.text);
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.userName) {
        [self.psw becomeFirstResponder];
    }else if(textField == self.psw){
        [self login];
        
        [self.psw resignFirstResponder];
    }
    return YES;
}

@end
