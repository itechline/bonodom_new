//
//  ImageController.m
//  Bonodom
//
//  Created by Attila Dán on 2016. 08. 22..
//  Copyright © 2016. Itechline. All rights reserved.
//

#import "ocvCameraImage-Bridging-Header.h"
#import <opencv2/opencv.hpp>
#import "opencv2/imgcodecs/ios.h"

@interface ImageController()
@property (nonatomic)CVImageBufferRef ibrImageBuffer;
@property (nonatomic)CGColorSpaceRef csrColorSpace;
@property (nonatomic)uint8_t *baseAddress;
@property (nonatomic)size_t sztBytesPerRow;
@property (nonatomic)size_t sztWidth;
@property (nonatomic)size_t sztHeight;
@property (nonatomic)CGContextRef cnrContext;
@property (nonatomic)CGImageRef imrImage;
@property (nonatomic)UIImage* imgCreatedImage;
@end
@implementation ImageController


- (UIImage *) createImageFromBuffer:(CMSampleBufferRef) sbrBuffer
{
    // CVImageBufferRefへの変換.
    _ibrImageBuffer = CMSampleBufferGetImageBuffer(sbrBuffer);
    
    // ピクセルバッファのベースアドレスをロックする.
    CVPixelBufferLockBaseAddress(_ibrImageBuffer, 0);
    
    // ベースアドレスの取得.
    _baseAddress = (uint8_t *)CVPixelBufferGetBaseAddressOfPlane(_ibrImageBuffer, 0);
    _sztBytesPerRow = CVPixelBufferGetBytesPerRow(_ibrImageBuffer);
    
    // サイズの取得.
    _sztWidth = CVPixelBufferGetWidth(_ibrImageBuffer);
    _sztHeight = CVPixelBufferGetHeight(_ibrImageBuffer);
    
    // RGBの色空間.
    _csrColorSpace = CGColorSpaceCreateDeviceRGB();
    
    // ビットマップグラフィックスコンテキストの生成.
    _cnrContext = CGBitmapContextCreate(_baseAddress
                                        , _sztWidth
                                        , _sztHeight
                                        , 8
                                        , _sztBytesPerRow
                                        , _csrColorSpace
                                        , kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    
    // ビットマップグラフィックスコンテキストからCGImageRefの生成.
    _imrImage = CGBitmapContextCreateImage(_cnrContext);
    
    // CGImageRefからUIImageを生成.
    // 一旦デバイスの向きに関わらず画像を右向きに表示.
    _imgCreatedImage = [UIImage imageWithCGImage:_imrImage scale:1.0f
                                     orientation:UIImageOrientationRight];
    
    // 解放
    CGImageRelease(_imrImage);
    CGContextRelease(_cnrContext);
    CGColorSpaceRelease(_csrColorSpace);
    
    
    // ベースアドレスのロックを解除
    CVPixelBufferUnlockBaseAddress(_ibrImageBuffer, 0);
    
    return _imgCreatedImage;
}
@end
