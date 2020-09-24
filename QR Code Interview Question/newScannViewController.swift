//
//  newScannViewController.swift
//  QR Code Interview Question
//
//  Created by Harsh Patel on 06/02/19.
//  Copyright © 2019 Harsh Patel. All rights reserved.
//

//import UIKit
//
//class newScannViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
import UIKit

import AVFoundation



class newScannViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    
    
    
    @IBOutlet weak var square: UIImageView!
    
    var video = AVCaptureVideoPreviewLayer()
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        //Creating seesion
        
        let session = AVCaptureSession()
        
        
        
        //Define capture device
        
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        
        
        do
            
        {
            
            let  input = try AVCaptureDeviceInput(device: captureDevice!)
            
            session.addInput(input)
            
        }
            
        catch
            
        {
            
            print("ERROR")
            
        }
        
        
        
        let output = AVCaptureMetadataOutput()
        
        session.addOutput(output)
        
        
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        
        
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        
        
        video = AVCaptureVideoPreviewLayer(session: session)
        
        video.frame = view.layer.bounds
        
        view.layer.addSublayer(video)
        
        
        
        self.view.bringSubviewToFront(square)
        
        
        
        session.startRunning()
        
    }
    
    
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!)
        
    {
        
        if metadataObjects != nil && metadataObjects.count != 0
            
            
            
        {
            
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject
                
            {
                
                
                
                if object.type == AVMetadataObject.ObjectType.qr
                    
                {
                    
                    let alert = UIAlertController(title: "QR Code", message: object.stringValue , preferredStyle:.alert)
                    
                    alert.addAction(UIAlertAction(title: "Retake",     style: . default , handler: nil))
                    
                    alert.addAction(UIAlertAction(title: "Copy",     style: . default , handler: {
                        
                        Void in  print(object.stringValue)
                        
                    }))
                    
                    present(alert , animated : true , completion: nil)
                    
                }
                
            }
            
        }
        
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
    
    
    
    
    
}
