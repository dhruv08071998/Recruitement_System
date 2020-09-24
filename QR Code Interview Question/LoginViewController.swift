//
//  LoginViewController.swift
//  QR Code Interview Question
//
//  Created by Harsh Patel on 22/01/19.
//  Copyright © 2019 Harsh Patel. All rights reserved.
//

import UIKit

public struct RootClass: Decodable {
    
    public var status : String!
    public var lid : String!
    public var email : String!
    public var image : String!
    public var role : String!
    
}


class LoginViewController: UIViewController, UITextFieldDelegate {

    ////////////////////////////////////////////////////////////////////////////////////////////// api calling
    
    @IBAction func actionBtn(_ sender: Any) {
        
        var flag : Bool = true
        let v = validation()
        let email = Emailtxt.text!
        let password = Passwordtxt.text!
        
        if( v.isEmpty(value: email) == true)
        {
            if( v.isEmpty(value: password) == true )
            {
                if (v.isEmailValid(value: email) == true )
                {
                    flag = true
                    POST_Data(username:(Emailtxt).text!, password:(Passwordtxt).text!)
                }
                else
                {
                    flag = false
                    Emailtxt.text = ""
                    Emailtxt.attributedPlaceholder = NSAttributedString(string: "Please enter valid email",
                                                                           attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                    
                    
                }
            }
            else
            {
                flag = false
                Passwordtxt.text = ""
                Passwordtxt.attributedPlaceholder = NSAttributedString(string: "Please enter password",
                                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                
            }
            
        }
        else
        {
            flag = false
            Emailtxt.text = ""
            Emailtxt.attributedPlaceholder = NSAttributedString(string: "Please enter email",
                                                                attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            //Emailtxt.placeholder = "Please enter email"
            if( v.isEmpty(value: password) == false )
            {
                flag = false
                Passwordtxt.text = ""
                // Passwordtxt.placeholder = "Please enter Password"
                Passwordtxt.attributedPlaceholder = NSAttributedString(string: "Please enter password",
                                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            }
        }
        
        
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    
    // to use return button in keyboard
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    //////////////////////////////////////////////////////////////////////////////////////////////
    @IBAction func registrstionBtn(_ sender: Any) {
        
        performSegue(withIdentifier: "two", sender: nil)
        
        
    }
    
    //////////////////////////////////////////////////////////////////////////////////////////////
    
    @IBOutlet weak var Passwordtxt: Specialfield!
    @IBOutlet weak var Emailtxt: Specialfield!
    
    ////////////////////////////////////////////////////////////////////////////////////////////view did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    /////////////////////////////////////////////////////////////////////////////////////////////
    @IBAction func forgotBtn(_ sender: Any) {
        
        
        performSegue(withIdentifier: "changepassword", sender: nil)
        
    }
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////// api parsing ///////////////////////////////////////////



    func POST_Data(username:String , password:String)
        
    {
        
        //Make ADDRESS URL
   
        let u = url + "login.php";
        
        UserDefaults.standard.set(url , forKey: "urlkey")
        
        let reqUrl = URL(string: u)
        
        
        
        //GET DATA FROM TEXT FIELD AND PUT INTO DICTIONARY on KEY NAME
        
        let reqDict = ["email":username, "password":password]
        
        
        
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
                        var response = try JSONDecoder().decode(RootClass.self, from: resData!)
                        print(response.status!)
                        DispatchQueue.main.async(execute:{
                            
                            
                            
                            self.loginparsdata(response: response)
                            
                            
                            
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
    func loginparsdata(response : RootClass)
    {
        if(response.status! == "true")
        {
            commonLid = response.lid!
            UserDefaults.standard.set(commonLid , forKey: "lidkey")
            
            if ( response.role! == "Student")
            {
                performSegue(withIdentifier: "one", sender: self)
            }
            else if (response.role! == "Company")
            {
                performSegue(withIdentifier: "Company", sender: self)
            }
            else
            {
                print("Error in selecting")
            }
        }
        else
        {
            showalert(title: "alert", message: "You have entered wrong email or password", handlerOk: { ACTION in print("alert called")})
            print ("error in status")
        }
            
    }
    
    
 /////////////////////////////////////////////////////////////////////////////////////////////////parsing ends
    
}

//response ma json ane ios ma dictionary ->





