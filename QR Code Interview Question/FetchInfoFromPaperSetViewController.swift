//
//  FetchInfoFromPaperSetViewController.swift
//  QR Code Interview Question
//
//  Created by Harsh Patel on 03/02/19.
//  Copyright © 2019 Harsh Patel. All rights reserved.
//

import UIKit

class FetchInfoFromPaperSetViewController: UIViewController {

    @IBOutlet weak var txtSetName: UILabel!
    @IBOutlet weak var txtSetNO: UILabel!
    @IBOutlet weak var txtTechnology: UILabel!
    @IBOutlet weak var myQrImage: UIImageView!
    
    var setname  = ""
    var setno = ""
    var technology = ""
    var QrImage = UIImage()
    
    @IBAction func BtnBack(_ sender: Any) {
        self.dismiss(animated: true)
        //navigationController?.popViewController(animated: true)
    }
    @IBAction func BtnSaveImage(_ sender: Any) {
        
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let screenshort = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(screenshort!, nil, nil, nil)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtSetName.text = setname
        txtTechnology.text = technology
        txtSetNO.text = setno
        //let reqUrl = URL(string: url + QrImage )
        //let data = NSData(contentsOf: reqUrl!)
        //if data != nil
        //{
            myQrImage.image =  QrImage
        //}
      
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
