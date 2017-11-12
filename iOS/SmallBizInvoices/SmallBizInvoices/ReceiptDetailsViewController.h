//
//  ReceiptDetailsViewController.h
//  SmallBizInvoices
//
//  Created by Reema Bhalani on 11/11/17.
//  Copyright © 2017 Reema Bhalani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReceiptDetailsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *details;
- (IBAction)uploadReceiptBtnAction:(id)sender;

@end
