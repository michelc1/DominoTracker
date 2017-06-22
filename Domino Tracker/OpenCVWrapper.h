//
//  OpenCVWrapper.h
//  Domino Tracker
//
//  Created by Andres Prato on 6/11/17.
//  Copyright © 2017 Andres Prato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OpenCVWrapper : NSObject
    - (void)isThisWorking;
    +(UIImage *)detectDots:(UIImage *)image;
@end
