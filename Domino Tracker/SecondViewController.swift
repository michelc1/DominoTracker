//
//  SecondViewController.swift
//  Domino Tracker
//
//  Created by Andres Prato on 5/10/17.
//  Copyright © 2017 Andres Prato. All rights reserved.
//

import UIKit
import AVFoundation


class SecondViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    var session : AVCaptureSession!
    var device : AVCaptureDevice!
    var output : AVCaptureVideoDataOutput!
    var taken: Bool = false
    let openCVWrapper = OpenCVWrapper()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.addTarget(self, action: #selector(SecondViewController.take), for: .touchUpInside)
        
        if initCamera() {
            session.startRunning()
        }
    }

    func take(){
        if !self.taken {
            self.taken = true
            self.imageView.image = OpenCVWrapper.detectDots(self.imageView.image)
        }
    }
    
    func initCamera() -> Bool {
        session = AVCaptureSession()
        session.sessionPreset = AVCaptureSessionPresetMedium
        
        
        device = AVCaptureDevice.defaultDevice(withDeviceType: .builtInWideAngleCamera, mediaType: AVMediaTypeVideo, position: .back)

//        let devices = AVCaptureDeviceDiscoverySession().devices
//        
//        for d in devices! {
//            if((d as AnyObject).position == AVCaptureDevicePosition.back){
//                device = d as! AVCaptureDevice
//            }
//        }
        if device == nil {
            return false
        }
        
        do {
            let myInput: AVCaptureDeviceInput?
            try myInput = AVCaptureDeviceInput(device: device)
            
            if session.canAddInput(myInput) {
                session.addInput(myInput)
            } else {
                return false
            }
            
            output = AVCaptureVideoDataOutput()
            output.videoSettings = [ kCVPixelBufferPixelFormatTypeKey as AnyHashable: Int(kCVPixelFormatType_32BGRA) ]
            
            try device.lockForConfiguration()
            device.activeVideoMinFrameDuration = CMTimeMake(1, 15)
            device.unlockForConfiguration()
            
            let queue: DispatchQueue = DispatchQueue(label: "myqueue", attributes: [])
            output.setSampleBufferDelegate(self, queue: queue)
            
            output.alwaysDiscardsLateVideoFrames = true
        } catch let error as NSError {
            print(error)
            return false
        }
        
        if session.canAddOutput(output) {
            session.addOutput(output)
        } else {
            return false
        }
        
        for connection in output.connections {
            if let conn = connection as? AVCaptureConnection {
                if conn.isVideoOrientationSupported {
                    conn.videoOrientation = AVCaptureVideoOrientation.portrait
                }
            }
        }
        
        return true
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!,
                       from connection: AVCaptureConnection!) {
        DispatchQueue.main.async(execute: {
            if !self.taken {
                let image: UIImage = CameraUtil.imageFromSampleBuffer(buffer: sampleBuffer)
                self.imageView.image = image;
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

