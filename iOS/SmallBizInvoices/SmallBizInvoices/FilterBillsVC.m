//
//  FilterBillsVC.m
//  SmallBizInvoices
//
//  Created by Jay Vachhani on 11/11/17.
//  Copyright © 2017 Reema Bhalani. All rights reserved.
//

#import "FilterBillsVC.h"

@interface FilterBillsVC ()

@end

@implementation FilterBillsVC

@synthesize filter;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSString* title = [self navTitle];
    self.navigationItem.title = title;
}

- (NSString *) navTitle {
    switch (self.filter) {
        case DateRange:
            return @"Filter by Date range";
            break;
        case Location:
            return @"Filter by Location";
            break;
        case Item:
            return @"Filter by Item";
            break;
        case Price:
            return @"Filter by Price";
            break;
        case Day:
            return @"Filter by Week";
            break;
        default:
            return @"All";
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) showReport:(id)sender {
    JBBarChartViewController *barChartController = [[JBBarChartViewController alloc] initWithFilter:self.filter];
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
