//
//  ScanQRCodeVC.m
//  SmallBizInvoices
//
//  Created by Reema Bhalani on 11/11/17.
//  Copyright © 2017 Reema Bhalani. All rights reserved.
//

#import "ScanQRCodeVC.h"
#import <AVFoundation/AVFoundation.h>
#import "MTBBarcodeScanner.h"

@interface ScanQRCodeVC ()
@property (nonatomic, strong) MTBBarcodeScanner *scanner;
@property (nonatomic, strong) NSMutableArray *uniqueCodes;
@property (nonatomic, assign) BOOL captureIsFrozen;
@property (nonatomic, assign) BOOL didShowCaptureWarning;

@end

@implementation ScanQRCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self startScanning];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(previewTapped)];
    [self.preViewLayet addGestureRecognizer:tapGesture];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.scanner stopScanning];
    [super viewWillDisappear:animated];
}

#pragma mark - Scanner

- (MTBBarcodeScanner *)scanner {
    if (!_scanner) {
        _scanner = [[MTBBarcodeScanner alloc] initWithPreviewView:_preViewLayet];
    }
    return _scanner;
}

#pragma mark - Scanning

- (void)startScanning {
    
    [MTBBarcodeScanner requestCameraPermissionWithSuccess:^(BOOL success) {
        if (success) {
            
            NSError *error = nil;
            [self.scanner startScanningWithResultBlock:^(NSArray *codes) {
                for (AVMetadataMachineReadableCodeObject *code in codes) {
                    NSLog(@"Found code: %@", code.stringValue);
                }
                [self.scanner stopScanning];
            } error:&error];
            
        } else {
            // The user denied access to the camera
        }
    }];
    
//    self.uniqueCodes = [[NSMutableArray alloc] init];
//
//    NSError *error = nil;
//    [self.scanner startScanningWithResultBlock:^(NSArray *codes) {
//        for (AVMetadataMachineReadableCodeObject *code in codes) {
//            if (code.stringValue && [self.uniqueCodes indexOfObject:code.stringValue] == NSNotFound) {
//                [self.uniqueCodes addObject:code.stringValue];
//
//                NSLog(@"Found unique code: %@", code.stringValue);
//
//                // Update the tableview
//            }
//        }
//    } error:&error];
//
//    if (error) {
//        NSLog(@"An error occurred: %@", error.localizedDescription);
//    }
    
}
- (void)stopScanning {
    [self.scanner stopScanning];
    
    self.captureIsFrozen = NO;
}

#pragma mark - Actions




#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"BarcodeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier
                                                            forIndexPath:indexPath];
    cell.textLabel.text = self.uniqueCodes[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.uniqueCodes.count;
}

#pragma mark - Helper Methods

- (void)displayPermissionMissingAlert {
    NSString *message = nil;
    if ([MTBBarcodeScanner scanningIsProhibited]) {
        message = @"This app does not have permission to use the camera.";
    } else if (![MTBBarcodeScanner cameraIsPresent]) {
        message = @"This device does not have a camera.";
    } else {
        message = @"An unknown error occurred.";
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Scanning Unavaialble" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - Gesture Handlers

- (void)previewTapped {
    if (![self.scanner isScanning] && !self.captureIsFrozen) {
        return;
    }
    
    if (!self.didShowCaptureWarning) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Capture Frozen" message:@"The capture is now frozen. Tap the preview again to unfreeze." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:action];
        [self presentViewController:alertController animated:YES completion:nil];
        
        self.didShowCaptureWarning = YES;
    }
    
    if (self.captureIsFrozen) {
        [self.scanner unfreezeCapture];
    } else {
        [self.scanner freezeCapture];
    }
    
    self.captureIsFrozen = !self.captureIsFrozen;
}

#pragma mark - Setters

- (void)setUniqueCodes:(NSMutableArray *)uniqueCodes {
    _uniqueCodes = uniqueCodes;
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
