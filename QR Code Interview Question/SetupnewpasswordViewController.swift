//
//  SetupnewpasswordViewController.swift
//  QR Code Interview Question
//
//  Created by Harsh Patel on 28/01/19.
//  Copyright © 2019 Harsh Patel. All rights reserved.
//

import UIKit
public struct  passchange : Decodable
{
    public var message : String!
 
}

class SetupnewpasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var txtconformpass: Specialfield!
    @IBOutlet weak var txtnewPass: Specialfield!
    
    var email : String?
    
    
    
    
    @IBAction func btnsubmit(_ sender: Any) {
        print (email)
        if (txtnewPass.text! == txtconformpass.text! && txtnewPass.text! != "" && txtconformpass.text! != "")
        {
            updatepass( Email:email!  , pass: (txtnewPass).text! )
        }
        else
        {
            print("enter corredt password")
        }
        
    }
    
    func updatepass(Email:String,pass:String)
        
    {
        
        //Make ADDRESS URL
        
        let u = url + "password_update.php";
        
        let reqUrl = URL(string: u)
        
        
        //GET DATA FROM TEXT FIELD AND PUT INTO DICTIONARY on KEY NAME
        
        let reqDict = ["email":Email,"password":pass ]
        
        
        
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
                        
                        let response = try JSONDecoder().decode(passchange.self, from: resData!)
                      //  print(response.status!)
                        //print(response.otp!)
                        print(response.message!)
                        DispatchQueue.main.async(execute:{
                            
                            
                            
                            self.passwordchange(response: response)
                            
                            
                            
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
    func passwordchange(response : passchange)
    {
        if(response.message! == "true")
            
        {
            print("transfered ")
           
            performSegue(withIdentifier: "loginagain", sender: nil)
        }
        else
        {
            print("no password change")
        }
    }
    
    // password_update.php
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
