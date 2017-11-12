//
//  FilterBillsVC.m
//  SmallBizInvoices
//
//  Created by Jay Vachhani on 11/11/17.
//  Copyright © 2017 Reema Bhalani. All rights reserved.
//

#import "FilterBillsVC.h"
#import "JBBarChartViewController.h"

@interface FilterBillsVC ()

@end

@implementation FilterBillsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) showReport:(id)sender {
    JBBarChartViewController *barChartController = [[JBBarChartViewController alloc] initWithFilter:Item];
    [self.navigationController pushViewController:barChartController
                                         animated:YES];
    [barChartController reloadChart];
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
