//
//  OwnerRootVC.m
//  SmallBizInvoices
//
//  Created by Jay Vachhani on 11/11/17.
//  Copyright © 2017 Reema Bhalani. All rights reserved.
//

#import "OwnerRootVC.h"
#import "SmallBizAppManager.h"
#import "FilterBillsVC.h"
#import "JBBarChartViewController.h"

@interface OwnerRootVC ()

@end

@implementation OwnerRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"Jay";
}

-(void) gotoFilterVC:(ChartFilter) filter {
    
    FilterBillsVC* filterVC = [[FilterBillsVC alloc] initWithNibName:@"FilterBillsVC" bundle:nil];
    filterVC.filter = filter;
    [filterVC showReport:nil];
    [self.navigationController pushViewController:filterVC
                                         animated:NO];
}

- (IBAction)btnLocationTapped:(id)sender {
    NSLog(@"Filter by Location");
    
    [self gotoFilterVC:Location];
}

- (IBAction)btnDateTapped:(id)sender {
    NSLog(@"Filter by Date");
    [self gotoFilterVC:DateRange];

}

- (IBAction)btnItemTapped:(id)sender {
    NSLog(@"Filter by Item");
    [self gotoFilterVC:Item];


}

- (IBAction)btnPriceTapped:(id)sender {
    NSLog(@"Filter by Price");
    [self gotoFilterVC:Price];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
