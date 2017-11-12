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
#import "ReceiptDetailsViewController.h"

@interface ScanQRCodeVC ()
@property (nonatomic, strong) MTBBarcodeScanner *scanner;
@property (nonatomic, assign) BOOL captureIsFrozen;
@property (nonatomic, assign) BOOL didShowCaptureWarning;
@property (nonatomic) ReceiptDetailsViewController *receiptDetailsScreen;
@end

@implementation ScanQRCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.receiptDetailsScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"ReceiptDetailsViewController"];
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
           
            self.receiptDetailsScreen.details = [NSMutableDictionary dictionary];
            
            NSError *error = nil;
            [self.scanner startScanningWithResultBlock:^(NSArray *codes) {
                
                AVMetadataMachineReadableCodeObject *code = [codes lastObject];
                NSLog(@"Found code: %@", code.stringValue);
                NSDictionary* aBill = [NSJSONSerialization JSONObjectWithData:[code.stringValue dataUsingEncoding:NSUTF8StringEncoding]
                                                                      options:NSJSONReadingMutableLeaves error:nil];
                self.receiptDetailsScreen.details = [NSMutableDictionary dictionaryWithDictionary:aBill];
                [self.scanner stopScanning];
                [self gotoReceiptDetails];
            } error:&error];
            
        } else {
            // The user denied access to the camera
            [self displayPermissionMissingAlert];
        }
    }];

}
- (void)stopScanning {
    [self.scanner stopScanning];
    
    self.captureIsFrozen = NO;
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) gotoReceiptDetails {
    
    // Pending to change to Manager root screen
    [self.navigationController pushViewController:self.receiptDetailsScreen
                                         animated:YES];
}

@end
