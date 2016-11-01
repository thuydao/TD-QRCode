//
//  TDQRScan.m
//  Pods
//
//  Created by tutitutituti on 11/1/16.
//
//

#import "TDQRScanView.h"
#import "TDOverLayView.h"

@interface TDQRScanView () <AVCaptureMetadataOutputObjectsDelegate, UINavigationControllerDelegate>

@property (nonatomic, assign) BOOL isQRCodeCaptured;

@end

@implementation TDQRScanView

- (void)setup {
    AVAuthorizationStatus authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authorizationStatus) {
        case AVAuthorizationStatusNotDetermined: {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler: ^(BOOL granted) {
                if (granted) {
                    [self setupCapture];
                } else {
                    NSLog(@"%@", @"Camera Access denied!");
                }
            }];
            break;
        }

        case AVAuthorizationStatusAuthorized: {
            [self setupCapture];
            break;
        }

        case AVAuthorizationStatusRestricted:
        case AVAuthorizationStatusDenied: {
            NSLog(@"%@", @"Camera Access denied!");
            break;
        }
            
        default: {
            break;
        }
    }
}

- (void)setupCapture {
    dispatch_async(dispatch_get_main_queue(), ^{
        AVCaptureSession *session = [[AVCaptureSession alloc] init];
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        NSError *error;
        AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
        if (deviceInput) {
            [session addInput:deviceInput];

            AVCaptureMetadataOutput *metadataOutput = [[AVCaptureMetadataOutput alloc] init];
            [metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
            [session addOutput:metadataOutput];
            metadataOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];

            self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
            self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;

            self.previewLayer.frame = self.frame;
            [self.layer insertSublayer:self.previewLayer atIndex:0];


            if (CGRectIsEmpty (self.scanRect)) {
                self.scanRect = CGRectMake(CGRectGetMidX(self.previewLayer.bounds),
                                           CGRectGetMidY(self.previewLayer.bounds),
                                           MIN(200, CGRectGetWidth(self.previewLayer.bounds)),
                                           MIN(200, CGRectGetHeight(self.previewLayer.bounds)));
            }
            __weak typeof(self) weakSelf = self;
            [[NSNotificationCenter defaultCenter] addObserverForName:AVCaptureInputPortFormatDescriptionDidChangeNotification
                                                              object:nil
                                                               queue:[NSOperationQueue currentQueue]
                                                          usingBlock: ^(NSNotification *_Nonnull note) {
                                                              metadataOutput.rectOfInterest = [self.previewLayer metadataOutputRectOfInterestForRect:weakSelf.scanRect];
                                                          }];

            TDOverLayView *scanView = [[TDOverLayView alloc] initWithScanRect:self.scanRect];
            [self addSubview:scanView];

            [session startRunning];
        } else {
            NSLog(@"%@", error);
        }
    });
}


#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    AVMetadataMachineReadableCodeObject *metadataObject = metadataObjects.firstObject;
    if ([metadataObject.type isEqualToString:AVMetadataObjectTypeQRCode] && !self.isQRCodeCaptured) {
        //stop detect
        //self.isQRCodeCaptured = YES;

        //return data;
        //[self showAlertViewWithMessage:metadataObject.stringValue];
        NSLog(@"%@",metadataObject.stringValue);
    }
}















@end
