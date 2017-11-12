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
    //[self.tableView registerClass:self forCellReuseIdentifier:@"BarcodeCell"];

    // Do any additional setup after loading the view from its nib.
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
    NSString *urlString1 = @"http://myurl.com/endpoint01/push_notifications";
    NSData *jsonBodyData = [NSJSONSerialization dataWithJSONObject:details
                                                           options:kNilOptions
                                                             error:nil];
    // watch out: error is nil here, but you never do that in production code. Do proper checks!
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    request.HTTPMethod = @"POST";
    
    // for alternative 1:
    [request setURL:[NSURL URLWithString:urlString1]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:jsonBodyData];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config
                                                          delegate:nil
                                                     delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data,
                                                                NSURLResponse * _Nullable response,
                                                                NSError * _Nullable error) {
                                                NSLog(@"Yay, done! Check for errors in response!");
                                                NSHTTPURLResponse *asHTTPResponse = (NSHTTPURLResponse *) response;
                                                NSLog(@"The response is: %@", asHTTPResponse);
                                                NSDictionary *forJSONObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                NSLog(@"One of these might exist - object: %@", forJSONObject);
                                            }];
    [task resume];
}
@end
