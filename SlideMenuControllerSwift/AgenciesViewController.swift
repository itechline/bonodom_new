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
        
        
        
        //panoramaView.setImageWithName("equirectangular-projection-lines_black.png")
        panoramaView.touchToPan = false          // Use touch input to pan
        panoramaView.orientToDevice = true     // Use motion sensors to pan
        panoramaView.pinchToZoom = false         // Use pinch gesture to zoom
        panoramaView.showTouches = true         // Show touches
        self.view = panoramaView
        
        
        
        
        var cpdCaptureDevice: AVCaptureDevice!
        
        // 背面カメラの検索.
        for device: AnyObject in AVCaptureDevice.devices()
        {
            if device.position == AVCaptureDevicePosition.Back
            {
                cpdCaptureDevice = device as! AVCaptureDevice
            }
        }
        // カメラが見つからなければリターン.
        if (cpdCaptureDevice == nil) {
            print("Camera couldn't found")
            return
        }
        // FPSの設定.
        cpdCaptureDevice.activeVideoMinFrameDuration = CMTimeMake(1, 30)
        
        // 入力データの取得. 背面カメラを設定する.
        var deviceInput: AVCaptureDeviceInput!
        var error: NSError?
        do {
            deviceInput = try AVCaptureDeviceInput.init(device: cpdCaptureDevice)
        } catch let error1 as NSError {
            error = error1
            deviceInput = nil
        }
        
        // 出力データの取得.
        var videoDataOutput:AVCaptureVideoDataOutput = AVCaptureVideoDataOutput()
        
        // カラーチャンネルの設定.
        
        
        let dctPixelFormatType : Dictionary = [(kCVPixelBufferPixelFormatTypeKey as NSString) : NSNumber(unsignedInt: kCVPixelFormatType_32BGRA)]
        videoDataOutput.videoSettings = dctPixelFormatType
        
        //let dctPixelFormatType : Dictionary = [kCVPixelBufferPixelFormatTypeKey : kCVPixelFormatType_32BGRA]
        //videoDataOutput.videoSettings = dctPixelFormatType
        
        
        //videoDataOutput.videoSettings = [NSDictionary dictionaryWithObject: [NSNumber numberWithInt:kCVPixelFormatType_32BGRA] forKey: (id)kCVPixelBufferPixelFormatTypeKey];
        
        // デリゲート、画像をキャプチャするキューを指定.
        videoDataOutput.setSampleBufferDelegate(self, queue: dispatch_get_main_queue())
        
        // キューがブロックされているときに新しいフレームが来たら削除.
        videoDataOutput.alwaysDiscardsLateVideoFrames = true
        
        // セッションの使用準備.
        self.cpsSession = AVCaptureSession()
        
        // Input、Outputの追加.
        if(self.cpsSession.canAddInput(deviceInput))
        {
            self.cpsSession.addInput(deviceInput as AVCaptureDeviceInput)
        }
        if(self.cpsSession.canAddOutput(videoDataOutput))
        {
            self.cpsSession.addOutput(videoDataOutput)
        }
        // 解像度の指定.
        self.cpsSession.sessionPreset = AVCaptureSessionPresetMedium
        
        self.cpsSession.startRunning()
        
        
        
        
        
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
    
    func UIImageFromCMSamleBuffer(buffer:CMSampleBuffer)-> UIImage {
        // サンプルバッファからピクセルバッファを取り出す
        let pixelBuffer:CVImageBufferRef = CMSampleBufferGetImageBuffer(buffer)!
        
        // ピクセルバッファをベースにCoreImageのCIImageオブジェクトを作成
        let ciImage = CIImage(CVPixelBuffer: pixelBuffer)
        
        //CIImageからCGImageを作成
        let pixelBufferWidth = CGFloat(256)
        let pixelBufferHeight = CGFloat(128)
        let imageRect:CGRect = CGRectMake(0,0,pixelBufferWidth, pixelBufferHeight)
        let ciContext = CIContext.init()
        let cgimage = ciContext.createCGImage(ciImage, fromRect: imageRect )
        
        // CGImageからUIImageを作成
        let image = UIImage(CGImage: cgimage)
        return image
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        print ("LOOOOOFASZ")
        ///imgCameraView.image = imcImageController.createImageFromBuffer(sampleBuffer)
        
        //let image:UIImage = self.captureImage(sampleBuffer)
        //let image = self.UIImageFromCMSamleBuffer(sampleBuffer)
        if (sampleBuffer != nil) {
            print ("LOOOOOFASZ_1")
            let img = imcImageController.createImageFromBuffer(sampleBuffer)
            print ("LOOOOOFASZ_2")
            if (img != nil) {
                self.panoramaView.setPreviewImage(self.resizeImage(img, newWidth: 1024, newHeight: 512))
            }
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            
            
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
        //UIGraphicsBeginImageContextWithOptions(previewView.bounds.size, true, 0)
        //previewView.drawViewHierarchyInRect(previewView.bounds, afterScreenUpdates: true)
        //let image = UIGraphicsGetImageFromCurrentImageContext()
        //UIGraphicsEndImageContext()
        //self.panoramaView.setImage(self.resizeImage(camImage, newWidth: 2048, newHeight: 1024))
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
    
}
