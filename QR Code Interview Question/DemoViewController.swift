//
//  DemoViewController.swift
//  QR Code Interview Question
//
//  Created by Harsh Patel on 06/02/19.
//  Copyright © 2019 Harsh Patel. All rights reserved.
//

import UIKit
import AVFoundation

class DemoViewController: UIViewController , AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var square: UIImageView!
    var video = AVCaptureVideoPreviewLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Creating session
        let session = AVCaptureSession()
       let captureDevice =  AVCaptureDevice.default(for: AVMediaType.video)
        //Define capture devcie
       // let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do
        {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            session.addInput(input)
        }
        catch
        {
            print ("ERROR")
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
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        end: if metadataObjects != nil && metadataObjects.count != 0
        {
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject
            {
                if object.type == AVMetadataObject.ObjectType.qr
                {
                    print(object.stringValue!)
                    //                    enc = String(object.stringValue!)
                    //                    self.myQrScane()
                    //                    break end
                }
            }
        }
    }
    
    //    func myQrScane()
    //    {
    //
    //        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //
    //            let cell = segue.description as! StartingtheTestViewController
    //
    //            cell.Encoded = enc
    //
    //        }
    //
    //        performSegue(withIdentifier: "TakeTest", sender: nil)
    //
    //    }
    //
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

