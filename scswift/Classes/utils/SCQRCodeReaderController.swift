//
//  SCQRCodeReaderController.swift
//  SCSwift
//
//  Created by Timoshenko on 02/08/17.
//  Copyright © 2017 softctrl.com.br. All rights reserved.
//

import UIKit
import AVFoundation

open class SCQRCodeReaderController/*: AVCaptureMetadataOutputObjectsDelegate*/ {
    
    let supportedCodeTypes = [/*AVMetadataObjectTypeUPCECode,
                              AVMetadataObjectTypeCode39Code,
                              AVMetadataObjectTypeCode39Mod43Code,
                              AVMetadataObjectTypeCode93Code,
                              AVMetadataObjectTypeCode128Code,
                              AVMetadataObjectTypeEAN8Code,
                              AVMetadataObjectTypeEAN13Code,
                              AVMetadataObjectTypeAztecCode,
                              AVMetadataObjectTypePDF417Code,*/
                              AVMetadataObjectTypeQRCode]
    
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?

//    var qrCodeFrameView:UIView?
    
    public init() { }

    
    /// <#Description#>
    public func setupCaptureDevice(_ controller : UIViewController!) {

        // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video as the media type parameter.
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Initialize the captureSession object.
            captureSession = AVCaptureSession()
            
            // Set the input device on the capture session.
            captureSession?.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(controller as! AVCaptureMetadataOutputObjectsDelegate, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
            
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoPreviewLayer?.frame = controller.view.layer.bounds
            controller.view.layer.addSublayer(videoPreviewLayer!)
            
            // Start video capture.
            captureSession?.startRunning()
            
            // Move the message label and top bar to the front
//            view.bringSubview(toFront: messageLabel)
//            view.bringSubview(toFront: topbar)
            
            // Initialize QR Code Frame to highlight the QR code
//            qrCodeFrameView = UIView()
//            
//            if let qrCodeFrameView = qrCodeFrameView {
//                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
//                qrCodeFrameView.layer.borderWidth = 2
//                controller.view.addSubview(qrCodeFrameView)
//                controller.view.bringSubview(toFront: qrCodeFrameView)
//            }
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
    }
    
    public func startRunning() {
        captureSession?.startRunning()
    }

    
    /// <#Description#>
    public func stopRunning() {
        captureSession?.stopRunning()
    }
    
    // MARK: - AVCaptureMetadataOutputObjectsDelegate Methods
    
    public func onCaptureData(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!, _ action: (String?) -> ()) {
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0 {
//            qrCodeFrameView?.frame = CGRect.zero
            print("No QR/barcode is detected")
            action(nil)
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if supportedCodeTypes.contains(metadataObj.type) {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
//            qrCodeFrameView?.frame = barCod vcvcc                                             vbeObject!.bounds
            
            if metadataObj.stringValue != nil {
                print("QR/barcode detected: \(metadataObj.stringValue)")
                action(metadataObj.stringValue)
            }
        }
    }

}
