//
//  ViewController.m
//  SmallBizInvoices
//
//  Created by Reema Bhalani on 11/11/17.
//  Copyright © 2017 Reema Bhalani. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
#import "SmallBizAppManager.h"

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

- (void) gotoLogin {
    
    LoginViewController *loginScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self.navigationController pushViewController:loginScreen animated:YES];

}

- (IBAction)empBtnAction:(id)sender {
    [SmallBizAppManager sharedInstance].currentUserType = Employee;
    [self gotoLogin];
}

- (IBAction)ManagerBtnAction:(id)sender {
    [SmallBizAppManager sharedInstance].currentUserType = Manager;
    [self gotoLogin];
}

- (IBAction)ownerBtnAction:(id)sender {
    [SmallBizAppManager sharedInstance].currentUserType = Owner;
    NSLog(@"%ld", [SmallBizAppManager sharedInstance].currentUserType);
    [self gotoLogin];
}
@end
