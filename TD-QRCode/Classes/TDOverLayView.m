//
//  QRScanView.m
//  Pods
//
//  Created by tutitutituti on 11/1/16.
//
//

#import "TDOverLayView.h"

@interface TDOverLayView ()

@property (nonatomic, assign) CGRect scanRect;

@end

@implementation TDOverLayView

- (instancetype)initWithScanRect:(CGRect)rect {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _scanRect = rect;
        [self updateUI];
    }
    return self;
}

- (void)updateUI
{
    UIImageView *top_left = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    top_left.image = [UIImage imageNamed:@"ScanQR1"];
    top_left.backgroundColor = [UIColor redColor];
     [self addSubview:top_left];
    // align top_Left from the left
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[top_left]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(top_left)]];
    // align top_Left from the top
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[top_left]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(top_left)]];



    UIImageView *top_right = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    top_right.image = [UIImage imageNamed:@"ScanQR2"];
     [self addSubview:top_right];
    // align top_right from the right
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[top_right]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(top_right)]];
    // align top_right from the top
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[top_right]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(top_right)]];



    UIImageView *bottom_left = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    bottom_left.image = [UIImage imageNamed:@"ScanQR3"];
    [self addSubview:bottom_left];
    // align bottom_left from the left
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[bottom_left]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(bottom_left)]];
    // align bottom_left from the bottom
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[bottom_left]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(bottom_left)]];


    UIImageView *bottom_right = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    bottom_right.image = [UIImage imageNamed:@"ScanQR4"];
     [self addSubview:bottom_right];
    // align bottom_right from the right
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[bottom_right]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(bottom_right)]];
    // align bottom_right from the bottom
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[bottom_right]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(bottom_right)]];


}


- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    [[[UIColor blackColor] colorWithAlphaComponent:0.5] setFill];

    CGMutablePathRef screenPath = CGPathCreateMutable();
    CGPathAddRect(screenPath, NULL, self.bounds);

    CGMutablePathRef scanPath = CGPathCreateMutable();
    CGPathAddRect(scanPath, NULL, self.scanRect);

    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddPath(path, NULL, screenPath);
    CGPathAddPath(path, NULL, scanPath);

    CGContextAddPath(ctx, path);
    CGContextDrawPath(ctx, kCGPathEOFill);

    CGPathRelease(screenPath);
    CGPathRelease(scanPath);
    CGPathRelease(path);
}

@end
