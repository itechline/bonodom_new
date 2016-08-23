//
//  AgenciesViewController.swift
//  Bonodom
//
//  Created by Attila Dan on 03/06/16.
//  Copyright © 2016 Itechline. All rights reserved.
//

import UIKit
import GLKit
import AVFoundation


class AgenciesViewController: GLKViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    @IBOutlet weak var photoButton: UIButton!
    @IBAction func photoButton_event(sender: AnyObject) {
        if let videoConnection = stillImageOutput!.connectionWithMediaType(AVMediaTypeVideo) {
            videoConnection.videoOrientation = AVCaptureVideoOrientation.Portrait
            stillImageOutput?.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: {(sampleBuffer, error) in
                if (sampleBuffer != nil) {
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                    let dataProvider = CGDataProviderCreateWithCFData(imageData)
                    let cgImageRef = CGImageCreateWithJPEGDataProvider(dataProvider, nil, true, CGColorRenderingIntent.RenderingIntentDefault)
                    
                    let image = UIImage(CGImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.Right)
                    
                    let multiplier = 360 / self.hFov
                    let vertMultiplier = image.size.width / image.size.height
                    //let img_width = image.size.width/CGFloat(multiplier)
                    let img_width = image.size.width/CGFloat(1.5)
                    let img_height = img_width / vertMultiplier
                    
                    self.imageArray.append(self.resizeImage(image, newWidth: img_width, newHeight: img_height))
                    
                    
                    
                    
                    if (self.imageArray.count == 1) {
                        let bottomImage = UIImage(named: "equirectangular-projection-lines_black.png")
                        //var topImage = UIImage(named: "top.png")
                        
                        let size = CGSize(width: 2048, height: 1024)
                        UIGraphicsBeginImageContext(size)
                        
                        
                        
                        let areaSize = CGRect(x: size.width/2-img_width/2,
                            y: size.height/2-img_height/2,
                            width: img_width,
                            height: img_height)
                        
                        self.img_x_main = size.width/2-img_width/2
                        self.img_y_main = size.height/2-img_height/2
                        
                        bottomImage!.drawInRect(areaSize)
                        
                        image.drawInRect(areaSize, blendMode: CGBlendMode.Overlay, alpha: 1)
                        
                        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
                        UIGraphicsEndImageContext()
                        self.panoramaView.setImageFromGallery(self.resizeImage(newImage, newWidth: 2048, newHeight: 1024))
                    } else {
                        self.stitch()
                    }
                }
            })
        }
    }
    
    @IBOutlet weak var previewView: UIView!
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCaptureStillImageOutput!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    var avcaptureoutput: AVCaptureOutput!
    
    var camImage: UIImage!
    var areaSizeMain: CGRect!
    
    
    var imageArray:[UIImage!] = []
    
    var imagePicker = UIImagePickerController()
    var panoramaView = PanoramaView()
    var hFov: Float = 0.0
    
    var cpsSession: AVCaptureSession!
    var imcImageController: ImageController!
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        //previewLayer!.frame = previewView.bounds
        //previewView.layer.addSublayer(previewLayer!)
    }
    
    override func viewDidLoad() {
        imcImageController = ImageController()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AgenciesViewController.takePanoPicture), name: "takePanoPicture", object: nil)
        
        btmImg = UIImage(named: "equirectangular-projection-lines_black.png")
        
        let devices = AVCaptureDevice.devices()
        var captureDevice : AVCaptureDevice?
        for device in devices {
            if (device.hasMediaType(AVMediaTypeVideo)) {
                if(device.position == AVCaptureDevicePosition.Back) {
                    captureDevice = device as? AVCaptureDevice
                }
            }
        }
        if let retrievedDevice = captureDevice {
            print("HFOV is \(retrievedDevice.activeFormat.videoFieldOfView)")
            hFov = retrievedDevice.activeFormat.videoFieldOfView
        }
        
        
        
        panoramaView.setImageWithName("equirectangular-projection-lines_black.png")
        panoramaView.touchToPan = false          // Use touch input to pan
        panoramaView.orientToDevice = true     // Use motion sensors to pan
        panoramaView.pinchToZoom = false         // Use pinch gesture to zoom
        panoramaView.showTouches = true         // Show touches
        self.view = panoramaView
        
        var cpdCaptureDevice: AVCaptureDevice!
        
        for device: AnyObject in AVCaptureDevice.devices()
        {
            if device.position == AVCaptureDevicePosition.Back
            {
                cpdCaptureDevice = device as! AVCaptureDevice
            }
        }
        
        if (cpdCaptureDevice == nil) {
            print("Camera couldn't found")
            return
        }

        cpdCaptureDevice.activeVideoMinFrameDuration = CMTimeMake(1, 30)
        
        var deviceInput: AVCaptureDeviceInput!
        var error: NSError?
        do {
            deviceInput = try AVCaptureDeviceInput.init(device: cpdCaptureDevice)
        } catch let error1 as NSError {
            error = error1
            deviceInput = nil
        }
        
        if error == nil {
            let videoDataOutput:AVCaptureVideoDataOutput = AVCaptureVideoDataOutput()
        
        
            let dctPixelFormatType : Dictionary = [(kCVPixelBufferPixelFormatTypeKey as NSString) : NSNumber(unsignedInt: kCVPixelFormatType_32BGRA)]
            videoDataOutput.videoSettings = dctPixelFormatType
        
            //let dctPixelFormatType : Dictionary = [kCVPixelBufferPixelFormatTypeKey : kCVPixelFormatType_32BGRA]
            //videoDataOutput.videoSettings = dctPixelFormatType
        
        
            //videoDataOutput.videoSettings = [NSDictionary dictionaryWithObject: [NSNumber numberWithInt:kCVPixelFormatType_32BGRA] forKey: (id)kCVPixelBufferPixelFormatTypeKey];
        
            videoDataOutput.setSampleBufferDelegate(self, queue: dispatch_get_main_queue())
            videoDataOutput.alwaysDiscardsLateVideoFrames = true
            self.cpsSession = AVCaptureSession()

            if(self.cpsSession.canAddInput(deviceInput))
            {
                self.cpsSession.addInput(deviceInput as AVCaptureDeviceInput)
            }
            if(self.cpsSession.canAddOutput(videoDataOutput))
            {
                self.cpsSession.addOutput(videoDataOutput)
            }

            self.cpsSession.sessionPreset = AVCaptureSessionPreset640x480
        
            self.cpsSession.startRunning()
        
            stillImageOutput = AVCaptureStillImageOutput()
        
            stillImageOutput.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
        
            if cpsSession.canAddOutput(stillImageOutput) {
                print ("STILL IMAGE OUTPUT ADDED")
                cpsSession.addOutput(stillImageOutput)
            }
        
        
            //photoButton.frame = CGRectMake(self.view.frame.size.height/2, self.view.frame.size.width/2, 300, 500)
        
            //photoButton.translatesAutoresizingMaskIntoConstraints=true
            //self.view.addSubview(photoButton)
        }
        
        
        //takePhoto()
        /*captureSession = AVCaptureSession()
         captureSession.sessionPreset = AVCaptureSessionPresetPhoto
         
         let backCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
         
         var error: NSError?
         var input: AVCaptureDeviceInput!
         do {
         input = try AVCaptureDeviceInput(device: backCamera)
         } catch let error1 as NSError {
         error = error1
         input = nil
         }
         
         if error == nil && captureSession.canAddInput(input) {
         captureSession.addInput(input)
         
         stillImageOutput = AVCaptureStillImageOutput()
         avcaptureoutput = AVCaptureOutput()
         
         stillImageOutput.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
         if captureSession.canAddOutput(stillImageOutput) {
         captureSession.addOutput(stillImageOutput)
         
         previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
         previewLayer.videoGravity = AVLayerVideoGravityResizeAspect
         previewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.Portrait
         previewView.layer.addSublayer(previewLayer)
         
         captureSession.startRunning()
         previewView.translatesAutoresizingMaskIntoConstraints=true
         previewLayer!.frame = previewView.bounds
         
         
         let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AgenciesViewController.buttonPressed))
         previewView!.addGestureRecognizer(tap)
         
         self.view.addSubview(previewView)
         
         
         
         
         
         var videoDataOutput:AVCaptureVideoDataOutput = AVCaptureVideoDataOutput()
         
         videoDataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString) : NSNumber(unsignedInt: kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)]
         videoDataOutput.setSampleBufferDelegate(self, queue: dispatch_get_main_queue())
         videoDataOutput.alwaysDiscardsLateVideoFrames = true
         
         
         
         
         }
         }*/
        
    }
    
    
    var btmImg: UIImage!
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {

        if (sampleBuffer != nil) {
            let img = imcImageController.createImageFromBuffer(sampleBuffer)
            if (img != nil) {
                dispatch_async(dispatch_get_main_queue()) {
                    let size = CGSize(width: 1024, height: 512)
                    UIGraphicsBeginImageContext(size)
                
                
                    let multiplier = 360 / self.hFov
                    let vertMultiplier = img.size.width / img.size.height
                    let img_width = img.size.width/CGFloat(multiplier)*2
                    let img_height = img_width / vertMultiplier
                    
                    //print ("WIDTH: " + String(img.size.width))
                    //print ("HEIGHT: " + String(img.size.height))
                    
                    /*let areaSize = CGRect(x: size.width/2-img.size.width/2,
                                          y: size.height/2-img.size.height/2,
                                          width: img.size.width,
                                          height: img.size.height)*/
                    
                    let areaSize = CGRect(x: size.width/2-img_width/2,
                                          y: size.height/2-img_height/2,
                                          width: img_width,
                                          height: img_height)
                
                    //self.btmImg!.drawInRect(areaSize)
                    img.drawInRect(areaSize, blendMode: CGBlendMode.Overlay, alpha: 1)
                
                    let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                
                    self.panoramaView.setImage(self.resizeImage(newImage, newWidth: 1024, newHeight: 512))
                }
            }
        }
        
        
            
            
        
    }
    func buttonPressed(sender: UIButton!) {
        if let videoConnection = stillImageOutput!.connectionWithMediaType(AVMediaTypeVideo) {
            videoConnection.videoOrientation = AVCaptureVideoOrientation.Portrait
            stillImageOutput?.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: {(sampleBuffer, error) in
                if (sampleBuffer != nil) {
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                    let dataProvider = CGDataProviderCreateWithCFData(imageData)
                    let cgImageRef = CGImageCreateWithJPEGDataProvider(dataProvider, nil, true, CGColorRenderingIntent.RenderingIntentDefault)
                    
                    let image = UIImage(CGImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.Right)
                    
                    let multiplier = 360 / self.hFov
                    let vertMultiplier = image.size.width / image.size.height
                    let img_width = image.size.width/CGFloat(multiplier)
                    let img_height = img_width / vertMultiplier
                    
                    self.imageArray.append(self.resizeImage(image, newWidth: img_width, newHeight: img_height))
                    
                    
                    
                    
                    if (self.imageArray.count == 1) {
                        let bottomImage = UIImage(named: "equirectangular-projection-lines_black.png")
                        //var topImage = UIImage(named: "top.png")
                        
                        let size = CGSize(width: 2048, height: 1024)
                        UIGraphicsBeginImageContext(size)
                        
                        
                        
                        let areaSize = CGRect(x: size.width/2-img_width/2,
                            y: size.height/2-img_height/2,
                            width: img_width,
                            height: img_height)
                        
                        self.img_x_main = size.width/2-img_width/2
                        self.img_y_main = size.height/2-img_height/2
                        
                        bottomImage!.drawInRect(areaSize)
                        
                        image.drawInRect(areaSize, blendMode: CGBlendMode.Overlay, alpha: 1)
                        
                        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
                        UIGraphicsEndImageContext()
                        self.panoramaView.setImageFromGallery(self.resizeImage(newImage, newWidth: 2048, newHeight: 1024))
                        //self.takePhoto()
                    } else {
                        self.stitch()
                    }
                }
            })
        }
    }
    
    override func glkView(view: GLKView, drawInRect rect: CGRect) {
        panoramaView.draw()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var finalImage: [UIImage!] = []
    var finalImageArray:[UIImage!] = []
    
    func stitch() {
        //self.spinner.startAnimating()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            if (!self.finalImage.isEmpty) {
                if (!self.finalImageArray.isEmpty) {
                    self.finalImageArray.removeAll()
                    self.finalImageArray.append(self.finalImage[0])
                    self.finalImageArray.append(self.imageArray.last!)
                }
            } else {
                self.finalImageArray.append(self.imageArray[0])
                self.finalImageArray.append(self.imageArray[1])
            }
            
            let stitchedImage:UIImage = CVWrapper.processWithArray(self.finalImageArray) as UIImage
            
            dispatch_async(dispatch_get_main_queue()) {
                NSLog("stichedImage %@", stitchedImage)
                self.finalImage.removeAll()
                self.finalImage.append(stitchedImage)
                
                let bottomImage = UIImage(named: "equirectangular-projection-lines_black.png")
                //var topImage = UIImage(named: "top.png")
                
                let size = CGSize(width: 2048, height: 1024)
                UIGraphicsBeginImageContext(size)
                
                print ("ASD_0")
                
                
                /*let areaSize = CGRect(x: size.width/2-stitchedImage.size.width/2,
                 y: size.height/2-stitchedImage.size.height/2,
                 width: stitchedImage.size.width,
                 height: stitchedImage.size.height)*/
                
                let areaSize = CGRect(x: self.img_x_main,
                                      y: self.img_y_main,
                                      width: stitchedImage.size.width,
                                      height: stitchedImage.size.height)
                print ("ASD_1")
                
                bottomImage!.drawInRect(areaSize)
                print ("ASD_2")
                
                stitchedImage.drawInRect(areaSize, blendMode: CGBlendMode.Overlay, alpha: 1)
                print ("ASD_3")
                
                let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                
                self.panoramaView.setImageFromGallery(self.resizeImage(newImage, newWidth: 2048, newHeight: 1024))
                //self.takePhoto()
                
                //self.spinner.stopAnimating()
            }
        }
    }
    
    
    func maskImage(image: UIImage, withMask maskImage: UIImage) -> UIImage {
        
        let maskRef = maskImage.CGImage
        
        let mask = CGImageMaskCreate(
            CGImageGetWidth(maskRef),
            CGImageGetHeight(maskRef),
            CGImageGetBitsPerComponent(maskRef),
            CGImageGetBitsPerPixel(maskRef),
            CGImageGetBytesPerRow(maskRef),
            CGImageGetDataProvider(maskRef),
            nil,
            false)
        
        let masked = CGImageCreateWithMask(image.CGImage, mask)
        let maskedImage = UIImage(CGImage: masked!)
        
        // No need to release. Core Foundation objects are automatically memory managed.
        
        return maskedImage
        
    }
    
    
    func pickImage () {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func takePhoto () {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    var img_x_main: CGFloat!
    var img_y_main: CGFloat!
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
        //var imageA : UIImage = UIImage(named:"equirectangular-projection-lines_black.png")!
        //var maskedImage: UIImage = self.maskImage(imageA, withMask: image)
        
        let multiplier = 360 / hFov
        let vertMultiplier = image.size.width / image.size.height
        let img_width = image.size.width/CGFloat(multiplier)
        let img_height = img_width / vertMultiplier
        
        self.imageArray.append(resizeImage(image, newWidth: img_width, newHeight: img_height))
        
        
        
        
        if (imageArray.count == 1) {
            let bottomImage = UIImage(named: "equirectangular-projection-lines_black.png")
            //var topImage = UIImage(named: "top.png")
            
            let size = CGSize(width: 2048, height: 1024)
            UIGraphicsBeginImageContext(size)
            
            
            
            let areaSize = CGRect(x: size.width/2-img_width/2,
                                  y: size.height/2-img_height/2,
                                  width: img_width,
                                  height: img_height)
            
            
            
            
            bottomImage!.drawInRect(areaSize)
            
            image.drawInRect(areaSize, blendMode: CGBlendMode.Overlay, alpha: 1)
            
            let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            panoramaView.setImageFromGallery(resizeImage(newImage, newWidth: 2048, newHeight: 1024))
            takePhoto()
        } else {
            stitch()
            
        }
        
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat, newHeight: CGFloat) -> UIImage {
        
        //let scale = newWidth / image.size.width
        //let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func takePanoPicture() {
        if let videoConnection = stillImageOutput!.connectionWithMediaType(AVMediaTypeVideo) {
            videoConnection.videoOrientation = AVCaptureVideoOrientation.Portrait
            stillImageOutput?.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: {(sampleBuffer, error) in
                if (sampleBuffer != nil) {
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                    let dataProvider = CGDataProviderCreateWithCFData(imageData)
                    let cgImageRef = CGImageCreateWithJPEGDataProvider(dataProvider, nil, true, CGColorRenderingIntent.RenderingIntentDefault)
                    
                    let image = UIImage(CGImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.Right)
                    
                    let multiplier = 360 / self.hFov
                    let vertMultiplier = image.size.width / image.size.height
                    //let img_width = image.size.width/CGFloat(multiplier)
                    let img_width = image.size.width/CGFloat(1.5)
                    let img_height = img_width / vertMultiplier
                    
                    self.imageArray.append(self.resizeImage(image, newWidth: img_width, newHeight: img_height))
                    
                    
                    
                    
                    if (self.imageArray.count == 1) {
                        let bottomImage = UIImage(named: "equirectangular-projection-lines_black.png")
                        //var topImage = UIImage(named: "top.png")
                        
                        let size = CGSize(width: 2048, height: 1024)
                        UIGraphicsBeginImageContext(size)
                        
                        
                        
                        let areaSize = CGRect(x: size.width/2-img_width/2,
                            y: size.height/2-img_height/2,
                            width: img_width,
                            height: img_height)
                        
                        self.img_x_main = size.width/2-img_width/2
                        self.img_y_main = size.height/2-img_height/2
                        
                        bottomImage!.drawInRect(areaSize)
                        
                        image.drawInRect(areaSize, blendMode: CGBlendMode.Overlay, alpha: 1)
                        
                        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
                        UIGraphicsEndImageContext()
                        self.panoramaView.setImageFromGallery(self.resizeImage(newImage, newWidth: 2048, newHeight: 1024))
                    } else {
                        self.stitch()
                    }
                }
            })
        }
    }
    
}
