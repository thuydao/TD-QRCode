//
//  TDQRCodeViewController.m
//  TD-QRCode
//
//  Created by Anonymous on 11/01/2016.
//  Copyright (c) 2016 Anonymous. All rights reserved.
//

#import "TDQRCodeViewController.h"
#import <TD_QRCode/TDQRScanView.h>

@interface TDQRCodeViewController ()
{
    IBOutlet TDQRScanView *scanView;
}
@end

@implementation TDQRCodeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [scanView setup];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
