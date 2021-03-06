//
//  EmployeeRootVC.m
//  SmallBizInvoices
//
//  Created by Reema Bhalani on 11/11/17.
//  Copyright © 2017 Reema Bhalani. All rights reserved.
//

#import "EmployeeRootVC.h"
#import "ReceiptListViewController.h"
#import "AddNewReceiptVC.h"
#import "SmallBizAppManager.h"

@interface EmployeeRootVC ()

@end

@implementation EmployeeRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"Reema";
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
-(void) gotoAddNewReceipt {
    AddNewReceiptVC *newReceiptScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"AddNewReceiptVC"];
    [self.navigationController pushViewController:newReceiptScreen
                                         animated:YES];
}
- (void) gotoMyReceipts {
    
     ReceiptListViewController *receiptListScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"ReceiptListViewController"];
    [self.navigationController pushViewController:receiptListScreen
                                         animated:YES];
}

- (IBAction)myReceiptsbtnAction:(id)sender {
    [SmallBizAppManager sharedInstance].currentUserType = Employee;
    [self gotoMyReceipts];
}

- (IBAction)addNewReceiptBtnAction:(id)sender {
    [SmallBizAppManager sharedInstance].currentUserType = Employee;
    [self gotoAddNewReceipt];
}


@end
