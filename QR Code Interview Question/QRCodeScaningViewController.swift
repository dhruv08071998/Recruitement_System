//
//  QRCodeScaningViewController.swift
//  QR Code Interview Question
//
//  Created by Harsh Patel on 06/02/19.
//  Copyright © 2019 Harsh Patel. All rights reserved.
//

import UIKit


class QRCodeScaningViewController: UIViewController {
    
    @IBAction func btn(_ sender: Any) {
        
        self.startOtpTimer()
        
    }
   
    @IBOutlet weak var txtclickme: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    var timer: Timer?
    var totalTime = 60
    
    func startOtpTimer() {
        self.totalTime = 60
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        print(self.totalTime)
        self.txtclickme.text = self.timeFormatted(self.totalTime) // will show timer
        if totalTime != 0 {
            totalTime -= 1  // decrease counter tim
        } else {
            if let timer = self.timer {
                timer.invalidate()
                self.timer = nil
            }
        }
    }
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
   
    
    
}
