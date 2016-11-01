//
//  TDQRScan.h
//  Pods
//
//  Created by tutitutituti on 11/1/16.
//
//

@import AVFoundation;
@import UIKit;

@interface TDQRScanView : UIView

@property (strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, assign) CGRect scanRect;

- (void)setup;

@end
