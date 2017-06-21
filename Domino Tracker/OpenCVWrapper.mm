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
#import <UIKit/UIKit.h>
using namespace std;

@implementation OpenCVWrapper
- (void) isThisWorking {
    cout << "HELLO IT WORKS" << endl;
}
+(UIImage *)ConvertImage:(UIImage *)image {
    cv::Mat mat;
    UIImageToMat(image, mat);
    
    cv::Mat gray;
    cv::cvtColor(mat, gray, CV_RGB2GRAY);
    
//    circles = cv::HoughCircles(gray, CV_HOUGH_GRADIENT, int method, <#double dp#>, <#double minDist#>);
//    vector< vector<Point> > contours;
//    vector<cv::Vec4i> hierarchy;
//    cv::findContours(gray, contours, hierarchy, CV_RETR_CCOMP, CV_CHAIN_APPROX_SIMPLE);
//    double refArea = 0;
//    bool objectFound = false;
//    int numObjects = hierarchy.size();
//    //if number of objects greater than MAX_NUM_OBJECTS we have a noisy filter
//    if(numObjects < 100){
//        for (int index = 0; index >= 0; index = hierarchy[index][0]) {
//            
//            cv::Moments moment = moments((cv::Mat)contours[index]);
//            double area = moment.m00;
//            
//            //if the area is less than 20 px by 20px then it is probably just noise
//            //if the area is the same as the 3/2 of the image size, probably just a bad filter
//            //we only want the object with the largest area so we safe a reference area each
//            //iteration and compare it to the area in the next iteration.
//            if(area>5){
//                
//                cv::Ball yellowBall;
//                
//                yellowBall.setXPos(moment.m10/area);
//                yellowBall.setYPos(moment.m01/area);
//                yellowBall.setType(yellowBall.getType());
//                yellowBall.setColour(yellowBall.getColour());
//                yBalls.push_back(yellowBall);
//                
//                objectFound = true;
//                
//            }else objectFound = false;
//            
//            
//        }
//        //let user know you found an object
//        if(objectFound ==true){
//            //draw object location on screen
//            drawObject(yBalls,cameraFeed);}
//        
//    }else putText(cameraFeed,"TOO MUCH NOISE! ADJUST FILTER",Point(0,50),1,2,cvScalar(0,0,255),2);
//    
//    cv::Mat bin;
//    cv::threshold(gray, bin, 0, 255, cv::THRESH_BINARY | cv::THRESH_OTSU);
    
    UIImage *binImg = MatToUIImage(gray);
    return binImg;
    
}
@end
