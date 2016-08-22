//
//  ocvCameraImage-Bridging-Header.h
//  Bonodom
//
//  Created by Attila Dán on 2016. 08. 22..
//  Copyright © 2016. Itechline. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ImageController : NSObject
- (UIImage *) createImageFromBuffer:(CMSampleBufferRef) sbrBuffer;
@end
