//
//  LoginViewController.m
//  SmallBizInvoices
//
//  Created by Reema Bhalani on 11/11/17.
//  Copyright © 2017 Reema Bhalani. All rights reserved.
//

#import "LoginViewController.h"
#import "EmployeeRootVC.h"
#import "ViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)loginBtnAction:(id)sender {
    EmployeeRootVC *employeeRootVCScreen = [EmployeeRootVC new];
    [self.navigationController pushViewController:employeeRootVCScreen animated:YES];
}

- (IBAction)cancelBtnAction:(id)sender {
    ViewController *vcScreen = [ViewController new];
    [self.navigationController pushViewController:vcScreen animated:YES];
}
@end
