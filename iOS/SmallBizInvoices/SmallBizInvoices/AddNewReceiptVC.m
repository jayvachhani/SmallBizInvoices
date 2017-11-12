//
//  AddNewReceiptVC.m
//  SmallBizInvoices
//
//  Created by Reema Bhalani on 11/11/17.
//  Copyright © 2017 Reema Bhalani. All rights reserved.
//

#import "AddNewReceiptVC.h"
#import "ScanQRCodeVC.h"
#import "EnterReceiptDetailsVC.h"
#import "SmallBizAppManager.h"

@interface AddNewReceiptVC ()

@end

@implementation AddNewReceiptVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"New Bill";
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

-(void) gotoAddQRCode {
    ScanQRCodeVC *qrCodeScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"ScanQRCodeVC"];
    [self.navigationController pushViewController:qrCodeScreen
                                         animated:YES];
}

- (IBAction)addQRCodeBtnAction:(id)sender {
    [self gotoAddQRCode];
}

- (IBAction)enterDetailsBtnAction:(id)sender {
    EnterReceiptDetailsVC *enterReceiptDetailsScreen = [EnterReceiptDetailsVC new];
    [self.navigationController pushViewController:enterReceiptDetailsScreen animated:YES];
}
@end
