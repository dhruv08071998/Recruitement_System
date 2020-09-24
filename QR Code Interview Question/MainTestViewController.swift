//
//  MainTestViewController.swift
//  QR Code Interview Question
//
//  Created by Harsh Patel on 06/02/19.
//  Copyright © 2019 Harsh Patel. All rights reserved.
//

import UIKit

class MainTestViewController: UIViewController {
    
    var test_question : [String] = []
    var test_option_A : [String] = []
    var test_option_B : [String] = []
    var test_option_C : [String] = []
    var test_option_D : [String] = []
    var test_correst_option : [String] = []
    var test_flag : [Bool] = []
    var test_ans : [String] = []
    var test_optAns:[String] = []
    var resultcount = ""
    var i : Int!
    var totalTime :Int!
   // var PP = 0
    
    override func viewWillAppear(_ animated: Bool) {
        UserDefaults.standard.set(true, forKey: "statuskey")
        self.startTimer()
    }

    override func viewDidLoad()
    {
        
        UserDefaults.standard.removeObject(forKey:"key_question")
        UserDefaults.standard.removeObject(forKey:"key_option_A")
        UserDefaults.standard.removeObject(forKey:"key_option_B")
        UserDefaults.standard.removeObject(forKey:"key_option_C")
        UserDefaults.standard.removeObject(forKey:"key_option_D")
        UserDefaults.standard.removeObject(forKey:"key_flag")
        UserDefaults.standard.removeObject(forKey:"key_correct_option")
        UserDefaults.standard.removeObject(forKey:"key_ans")
        UserDefaults.standard.removeObject(forKey:"key_optAns")
        UserDefaults.standard.removeObject(forKey:"totalTime")
        UserDefaults.standard.removeObject(forKey:"i_count")
       // print(UserDefaults.standard.value(forKey: "i_count") as? Int ?? 0)
        UserDefaults.standard.set(test_question , forKey: "key_question")
        UserDefaults.standard.set(test_option_A , forKey: "key_option_A")
        UserDefaults.standard.set(test_option_B , forKey: "key_option_B")
        UserDefaults.standard.set(test_option_C, forKey: "key_option_C")
        UserDefaults.standard.set(test_option_D , forKey: "key_option_D")
        UserDefaults.standard.set(test_flag , forKey: "key_flag")
        UserDefaults.standard.set(test_correst_option , forKey: "key_correct_option")
        UserDefaults.standard.set(test_ans , forKey: "key_ans")
        UserDefaults.standard.set(test_optAns , forKey: "key_optAns")
        UserDefaults.standard.set(i , forKey: "i_count")
        //print(UserDefaults.standard.value(forKey: "i_count") as? Int ?? 0)
        //print(UserDefaults.standard.value(forKey: "key_optAns") as? [String])
        
         UserDefaults.standard.set(false, forKey: "locked")// to lock the result after time out
        
        super.viewDidLoad()
        print(test_option_A)
        
        UserDefaults.standard.set(totalTime, forKey: "totalTime")
        print(totalTime)
        self.showques()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func opsA(_ sender: Any) {
        print("tap A working")
        test_flag[i] = true
        UserDefaults.standard.removeObject(forKey:"key_flag")
        UserDefaults.standard.set(test_flag , forKey: "key_flag")
        test_optAns[i] = "A."
        UserDefaults.standard.removeObject(forKey:"key_optAns")
        UserDefaults.standard.set(test_optAns , forKey: "key_optAns")
        //print("option are",UserDefaults.standard.value(forKey: "key_optAns") as? [String])
        test_ans[i] = test_option_A[i]
        UserDefaults.standard.removeObject(forKey:"key_ans")
        UserDefaults.standard.set(test_ans , forKey: "key_ans")
        txtSelectedOption.text = test_option_A[i]
        OptSelected.text = test_optAns[i]
    }
    @IBAction func opsB(_ sender: Any) {
        print("tap B working")
        test_flag[i] = true
        UserDefaults.standard.removeObject(forKey:"key_flag")
        UserDefaults.standard.set(test_flag , forKey: "key_flag")
        test_optAns[i] = "B."
        UserDefaults.standard.removeObject(forKey:"key_optAns")
        UserDefaults.standard.set(test_optAns , forKey: "key_optAns")
       // print("option are",UserDefaults.standard.value(forKey: "key_optAns") as? [String])
        test_ans[i] = test_option_B[i]
        UserDefaults.standard.removeObject(forKey:"key_ans")
        UserDefaults.standard.set(test_ans , forKey: "key_ans")
        txtSelectedOption.text = test_option_B[i]
        OptSelected.text = test_optAns[i]
    }
    @IBAction func opsC(_ sender: Any) {
        print("tap  C working")
        test_flag[i] = true
        UserDefaults.standard.removeObject(forKey:"key_flag")
        UserDefaults.standard.set(test_flag , forKey: "key_flag")
        test_optAns[i] = "C."
        UserDefaults.standard.removeObject(forKey:"key_optAns")
        UserDefaults.standard.set(test_optAns , forKey: "key_optAns")
       // print("option are",UserDefaults.standard.value(forKey: "key_optAns") as? [String])
        test_ans[i] = test_option_C[i]
        UserDefaults.standard.removeObject(forKey:"key_ans")
        UserDefaults.standard.set(test_ans , forKey: "key_ans")
        txtSelectedOption.text = test_option_C[i]
        OptSelected.text = test_optAns[i]
    }
    @IBAction func opsD(_ sender: Any) {
        print("tap D working")
        test_flag[i] = true
        UserDefaults.standard.removeObject(forKey:"key_flag")
        UserDefaults.standard.set(test_flag , forKey: "key_flag")
        test_optAns[i] = "D."
        UserDefaults.standard.removeObject(forKey:"key_optAns")
        UserDefaults.standard.set(test_optAns , forKey: "key_optAns")
        //print("option are",UserDefaults.standard.value(forKey: "key_optAns") as? [String])
        test_ans[i] = test_option_D[i]
        UserDefaults.standard.removeObject(forKey:"key_ans")
        UserDefaults.standard.set(test_ans , forKey: "key_ans")
        txtSelectedOption.text = test_option_D[i]
        OptSelected.text = test_optAns[i]
    }
    
  
    /////////////////////////////////////timer code ///////////////
    var timer: Timer?
    
    
    func startTimer() {
       // self.totalTime =
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func stoptimer()  {
        
        timer!.invalidate()
        //self.totalTime = Int(StopCountWatch.text!) ?? 300
        UserDefaults.standard.removeObject(forKey:"totalTime")
        UserDefaults.standard.set(totalTime , forKey: "totalTime")
    }

    @objc func updateTimer() {
       // print(self.totalTime)
        self.StopCountWatch.text = self.timeFormatted(self.totalTime) // will show timer
        if totalTime != 0 {
            totalTime -= 1  // decrease counter tim
        } else {
            if let timer = self.timer {
                timer.invalidate()
                UserDefaults.standard.removeObject(forKey: "locked")
                UserDefaults.standard.set(true, forKey: "locked")
                self.timer = nil
                self.resultcalculate()
                
            }
        }
    }
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    
///////////////////////////////timer code ends //////////////////////
    @IBOutlet weak var outletBtnprev: UIButton!
    @IBOutlet weak var EndBtnOutlet: UIButton!
    @IBOutlet weak var OptSelected: UILabel!
    @IBOutlet weak var txtSelectedOption: UITextView!
    @IBOutlet weak var txtOptionD: UITextView!
    @IBOutlet weak var txtOptionC: UITextView!
    @IBOutlet weak var txtOptionB: UITextView!
    @IBOutlet weak var txtOptionA: UITextView!
    @IBOutlet weak var txtQueCount: UILabel!
    @IBOutlet weak var TxtQuestion: UITextView!
    @IBOutlet weak var StopCountWatch: UILabel!
    @IBAction func BtnPrevious(_ sender: Any) {
        if(i>0)
        {
             outletBtnprev.isEnabled = true
            i = i - 1
            UserDefaults.standard.removeObject(forKey:"i_count")
            UserDefaults.standard.set(i , forKey: "i_count")
           // self.totalTime = Int(StopCountWatch.text!) ?? 300
            UserDefaults.standard.removeObject(forKey:"totalTime")
            UserDefaults.standard.set(totalTime , forKey: "totalTime")
            
            //print(UserDefaults.standard.value(forKey: "i_count") as? Int ?? 0)
            self.showques()
        }
        else if i == 0
        {
           // self.totalTime = Int(StopCountWatch.text!) ?? 300
            UserDefaults.standard.removeObject(forKey:"totalTime")
            UserDefaults.standard.set(totalTime , forKey: "totalTime")
            outletBtnprev.isEnabled = false
        }
        
    }
    
    @IBAction func BtnNext(_ sender: Any) {
        
        if(i < test_question.count)
        {
             outletBtnprev.isEnabled = true
            i = i + 1
           // self.totalTime = Int(StopCountWatch.text!) ?? 300
            UserDefaults.standard.removeObject(forKey:"totalTime")
            UserDefaults.standard.set(totalTime , forKey: "totalTime")
            UserDefaults.standard.removeObject(forKey:"i_count")
            UserDefaults.standard.set(i , forKey: "i_count")
           // print(UserDefaults.standard.value(forKey: "i_count") as? Int ?? 0)
             print( "i = ",i)
            //print("Question count ",test_question.count)
            if i != test_question.count
            {
                self.showques()
            }
        }
        if ( i == test_question.count)
        {
             outletBtnprev.isEnabled = true
            stoptimer()
            var i = 0
           // var count = 0
          //  self.totalTime = Int(StopCountWatch.text!) ?? 300
            UserDefaults.standard.removeObject(forKey:"totalTime")
            UserDefaults.standard.set(totalTime , forKey: "totalTime")
            UserDefaults.standard.removeObject(forKey:"i_count")
            UserDefaults.standard.set(i , forKey: "i_count")
            //print(UserDefaults.standard.value(forKey: "i_count") as? Int ?? 0)
            self.resultcalculate()
            
        }
        
    }
    
    func resultcalculate()
    {
        var i = 0
        var count = 0
        while(i<test_ans.count)
        {
            if(test_optAns[i]==test_correst_option[i])
            {
                count = count + 1
            }
            i = i + 1
        }
        
        resultcount = String(count)
        print(resultcount)
        performSegue(withIdentifier: "EndTest", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let res = segue.destination as!  CountingtheResultViewController
        
        res.result = resultcount
        
    }
    
    func showques()
    {
        print(i)
        let a = i+1
        txtQueCount.text = String(a)
        TxtQuestion.text = test_question[i]
        txtOptionA.text = test_option_A[i]
        txtOptionB.text = test_option_B[i]
        txtOptionC.text = test_option_C[i]
        txtOptionD.text = test_option_D[i]
        
        print ("optAns",test_optAns)
        
          print ("ans", test_ans)
        
        if (test_flag[i]==true){
            txtSelectedOption.text = test_ans[i]
            print("this is the test option", test_ans[i])
            OptSelected.text = test_optAns[i]
        }
        else{
            txtSelectedOption.text = nil
            OptSelected.text = nil
        }
        
    }
    
    
    
  

}
