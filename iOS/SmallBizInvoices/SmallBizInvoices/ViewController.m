//
//  ViewController.m
//  SmallBizInvoices
//
//  Created by Reema Bhalani on 11/11/17.
//  Copyright © 2017 Reema Bhalani. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)empBtnAction:(id)sender {
    LoginViewController *loginScreen = [LoginViewController new];
    [self.navigationController pushViewController:loginScreen animated:YES];
}

- (IBAction)ManagerBtnAction:(id)sender {
    LoginViewController *loginScreen = [LoginViewController new];
    [self.navigationController pushViewController:loginScreen animated:YES];
}

- (IBAction)ownerBtnAction:(id)sender {
    LoginViewController *loginScreen = [LoginViewController new];
    [self.navigationController pushViewController:loginScreen animated:YES];
}
@end
