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
#import "SmallBizAppManager.h"
#import "OwnerRootVC.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark -
-(void) gotoEmployeeRoot {
    
    EmployeeRootVC *employeeRoot = [self.storyboard instantiateViewControllerWithIdentifier:@"EmployeeRootVC"];
    [self.navigationController pushViewController:employeeRoot
                                         animated:YES];
}

-(void) gotoManagerRoot {
    
    // Pending to change to Manager root screen
    EmployeeRootVC *employeeRoot = [self.storyboard instantiateViewControllerWithIdentifier:@"EmployeeRootVC"];
    [self.navigationController pushViewController:employeeRoot
                                         animated:YES];
}

-(void) gotoOwnerRoot {
    
    OwnerRootVC* ownerRoot = [[OwnerRootVC alloc] initWithNibName:@"OwnerRootVC" bundle:nil];
    [self.navigationController pushViewController:ownerRoot
                                         animated:YES];
}

#pragma mark - Buttons
- (IBAction)loginBtnAction:(id)sender {
    
    switch (  [SmallBizAppManager sharedInstance].currentUserType ) {
        case Employee:
            [self gotoEmployeeRoot];
            break;
        case Manager:
            [self gotoManagerRoot];
            break;
        case Owner:
            [self gotoOwnerRoot];
            break;
        default:
            break;
    }
}

- (IBAction)cancelBtnAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Memory
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
