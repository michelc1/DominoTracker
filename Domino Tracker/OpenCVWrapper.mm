//
//  OpenCVWrapper.m
//  Domino Tracker
//
//  Created by Andres Prato on 6/11/17.
//  Copyright © 2017 Andres Prato. All rights reserved.
//

#import <opencv2/opencv.hpp>
#import "OpenCVWrapper.h"
#import <opencv2/imgcodecs/ios.h>

#include "opencv2/imgcodecs.hpp"
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/imgproc/imgproc.hpp"



#import <UIKit/UIKit.h>
using namespace std;

@implementation OpenCVWrapper
- (void) isThisWorking {
    cout << "HELLO IT WORKS" << endl;
}
+(UIImage *)detectDots:(UIImage *)image {
    cv::Mat mat;
    UIImageToMat(image, mat);
    
    cv::Mat img;
    cv::medianBlur(img, img, 5);
    cv::cvtColor(mat, img, CV_RGB2GRAY);
    
    
    vector<cv::Vec3f> circles;
    cv::HoughCircles(img, circles, CV_HOUGH_GRADIENT, 1, 10, 100, 30, 1, 30);
    
    cout << "THERE ARE: " << circles.size() << endl;
    
    cv::Mat temp;
    for( size_t i = 0; i < circles.size(); i++ )
    {
        cv::Point center(cvRound(circles[i][0]), cvRound(circles[i][1]));
        int radius = cvRound(circles[i][2]);
        circle( mat, center, 3, cv::Scalar(0,255,0), -1, 8, 0 );
        circle( mat, center, radius, cv::Scalar(0,0,255), 3, 8, 0 );
    }
    
    UIImage *binImg = MatToUIImage(mat);
    return binImg;
}
@end
