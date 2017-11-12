//
//  ReceiptDetailsViewController.m
//  SmallBizInvoices
//
//  Created by Reema Bhalani on 11/11/17.
//  Copyright © 2017 Reema Bhalani. All rights reserved.
//

#import "ReceiptDetailsViewController.h"

@interface ReceiptDetailsViewController ()

@end

@implementation ReceiptDetailsViewController

@synthesize details;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    NSLog(@"detials %@", self.details);

    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.jpg"]];
    [tempImageView setFrame:self.tableView.frame];
    self.tableView.backgroundView = tempImageView;
    
    // Do any additional setup after loading the view from its nib.
}


- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"Bill Details";
}



#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"BarcodeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier
                                                            forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@ : %@", details.allKeys[indexPath.row],  [details objectForKey:details.allKeys[indexPath.row]]];
    NSLog(@"%@", cell.textLabel.text);
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.details.allKeys.count;
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

- (IBAction)uploadReceiptBtnAction:(id)sender {
    NSDictionary *headers = @{ @"content-type": @"application/json",
                               @"accept": @"application/json",
                               @"cache-control": @"no-cache",
                               @"postman-token": @"7dcdb3ea-fdc4-cdbf-1abd-4ad886839e6e" };
    NSDictionary *parameters = @{@"PayDate": @"2017-11-12T02:44:07.338996Z",
                                  @"ItemList": @[ @{ @"ItmeId": @1, @"ItemName": @"", @"Amount": @100, @"Quantity": @1 } ],
                                  @"VendorDetail": @{ @"VendorID": @"3bc5eaee-f4f0-4485-bc99-6159fcf35729", @"VendorName": @"", @"VendorLocation": @"Mountain View" },
                                  @"PurchasedBy": @"Jay",
                                  @"TotalPrice": @100,
                                  @"PurchaseLocation": @"Mountain View" };
    
    NSData *jsonBodyData = [NSJSONSerialization dataWithJSONObject:parameters
                                                           options:kNilOptions
                                                             error:nil];
    // watch out: error is nil here, but you never do that in production code. Do proper checks!
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://bizbill.satnidbiz.com:9001/api/create"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];

    // for alternative 1:
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:jsonBodyData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Successfully Uploaded" message:@"Your bills details uploaded successfully" preferredStyle:UIAlertControllerStyleAlert];
                                                        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                                           [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:2] animated:YES];
                                                        }];
                                                        [alertController addAction:action];
                                                        [self presentViewController:alertController animated:YES completion:nil];
                                                        
                                                    }
                                                }];
    [dataTask resume];
}
@end
