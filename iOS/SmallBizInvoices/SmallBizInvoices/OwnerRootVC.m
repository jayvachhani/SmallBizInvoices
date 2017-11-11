//
//  OwnerRootVC.m
//  SmallBizInvoices
//
//  Created by Jay Vachhani on 11/11/17.
//  Copyright © 2017 Reema Bhalani. All rights reserved.
//

#import "OwnerRootVC.h"
#import "SmallBizAppManager.h"

@interface OwnerRootVC ()

@end

@implementation OwnerRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"Filter Bills";
}

- (IBAction)btnLocationTapped:(id)sender {
    NSLog(@"Filter by Location");
}

- (IBAction)btnDateTapped:(id)sender {
    NSLog(@"Filter by Date");

}

- (IBAction)btnItemTapped:(id)sender {
    NSLog(@"Filter by Item");

}

- (IBAction)btnPriceTapped:(id)sender {
    NSLog(@"Filter by Price");

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
