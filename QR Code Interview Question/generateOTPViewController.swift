//
//  generateOTPViewController.swift
//  QR Code Interview Question
//
//  Created by Harsh Patel on 28/01/19.
//  Copyright © 2019 Harsh Patel. All rights reserved.
//

import UIKit

public struct OTPGET: Decodable {
    
    public var msg: String!
    public var status : String!
    public var otp: Int!
    
}

class generateOTPViewController: UIViewController {
    
    var otpvalue  = 0
    let v = validation()
    
    @IBOutlet weak var txtEmail: Specialfield!
    @IBOutlet weak var txtOTP: Specialfield!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func Btnback(_ sender: Any) {
         navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnGenerateOTP(_ sender: Any) {
        
        if( v.isEmpty(value: txtEmail.text!) == true)
        {
                if (v.isEmailValid(value: txtEmail.text!) == true )
                {
                   
                    getOTP(Email: txtEmail.text!)
                }
                else
                {
                    
                    txtEmail.text = ""
                    txtEmail.attributedPlaceholder = NSAttributedString(string: "Please enter valid email",
                                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                }
        }
        else
        {
            txtEmail.text = ""
            txtEmail.attributedPlaceholder = NSAttributedString(string: "Please enter email",
                                                                attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            }
        }
      

    
    
    @IBAction func BtnReset(_ sender: Any) {
        
        if otpvalue ==  Int(txtOTP.text!)
        {
            performSegue(withIdentifier: "setupnewpassword", sender: nil)
            
            
        }
        else
        {
            print ("error")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! SetupnewpasswordViewController
        vc.email = txtEmail.text!
    }
    
    
    func getOTP(Email:String )
        
    {
        
        //Make ADDRESS URL
        
        let u = url + "email_otp/email.php";
        
        let reqUrl = URL(string: u)
        
        
        //GET DATA FROM TEXT FIELD AND PUT INTO DICTIONARY on KEY NAME
        
        let reqDict = ["email":Email]
        
        
        
        do {
            
            
            
            //DICTIONARY  FORMATE CONVERT JSON FORMATE WITH JSONSERIALIZABLE
            
            let reqData = try JSONSerialization.data(withJSONObject: reqDict, options: .prettyPrinted)
            
            
            
            //FOR URL REQUEST
            
            var request = URLRequest(url: reqUrl!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
            
            
            
            //REQUEST HTTP METHOD
            
            request.httpMethod = "POST"
            
            
            
            //REQUEST DATA HTTPBODY JSON
            
            request.httpBody = reqData
            
            
            
            //REQUEST SETVALUE
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            
            
            //SESSION
            
            let session = URLSession.shared
            
            
            
            let task = session.dataTask(with: request, completionHandler: { (resData, response, error) in
                
                if (error != nil){
                    print(error.debugDescription)
                    
                }else{
                    
                    do {
                    
                        let response = try JSONDecoder().decode(OTPGET.self, from: resData!)
                        print(response.status!)
                        print(response.otp!)
                        DispatchQueue.main.async(execute:{
                      
                            
                            
                            self.otpdata(response: response)
                            
                            
                            
                        }
                        )
                        
                        
                        
                        
                    }catch{
                        print(exception())
                    }
                }
            })
            task.resume()
        }
            
        catch{
            
            print(exception())
            
        }
        
        
        
    }
    func otpdata(response : OTPGET)
    {
        if(response.status! == "true")
            
        {
            print("Insertion successful")
            otpvalue = response.otp!
            //performSegue(withIdentifier: "one", sender: self)
        }
        else
        {
            print("no match email")
        }
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
