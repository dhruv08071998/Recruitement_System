//
//  CompanySideStudentDetailsViewController.swift
//  QR Code Interview Question
//
//  Created by Harsh Patel on 03/02/19.
//  Copyright © 2019 Harsh Patel. All rights reserved.
//

import UIKit

public struct myStdResult : Decodable {
    
    public var status : String!
    public var score : String!
    
}

class CompanySideStudentDetailsViewController: UIViewController {

    @IBOutlet weak var txtHighQual: UILabel!
    @IBOutlet weak var txtTechnology: UILabel!
    @IBOutlet weak var txtContnum: UILabel!
    @IBOutlet weak var txtEmail: UILabel!
    @IBOutlet weak var txtlastname: UILabel!
    @IBOutlet weak var txtFirstName: UILabel!
    @IBOutlet weak var StdImg: UIImageView!
    @IBOutlet weak var txtResult: UILabel!
    @IBOutlet weak var txt10TH: UILabel!
    @IBOutlet weak var txt12TH: UILabel!
    
    @IBAction func backBtn(_ sender: Any) {
        
        //navigationController?.popViewController(animated: true)
        self.dismiss(animated: true)
    }
    var highQul = ""
    var technology = ""
    var contnum = ""
    var email = ""
    var lastname = ""
    var firstname = ""
    var img = UIImage()
    var tenth = ""
    var twelth = ""
    var sid = ""
    var result = "Panding"
    override func viewWillAppear(_ animated: Bool) {
        newResultFunc(sid: sid)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtTechnology.text = technology
        txtHighQual.text = highQul
        txtContnum.text = contnum
        txtEmail.text = email
        txtlastname.text = lastname
        txtFirstName.text = firstname
        txt10TH.text = tenth
        txt12TH.text = twelth
        txtResult.text = result
        //let reqUrl = URL(string: url + img)
        //let data = NSData(contentsOf: reqUrl!)
        //if data != nil
        //{
            StdImg.image =  img
        //}

        // Do any additional setup after loading the view.
    }
    
    func newResultFunc(sid : String )
        
    {
        
        //Make ADDRESS URL
        
        let u = url + "company_wants_student_result.php";
        let reqUrl = URL(string: u)
        
        
        
        //GET DATA FROM TEXT FIELD AND PUT INTO DICTIONARY on KEY NAME
        
        let reqDict = ["sid":sid]
        
        
        
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
                        var response = try JSONDecoder().decode(myStdResult.self, from: resData!)
                        // print(response.status!)
                        DispatchQueue.main.async(execute:{
                            
                            
                            
                            self.myStdResultFunc(response: response)
                            
                            
                            
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
    
    func myStdResultFunc (response : myStdResult)
    {
        if(response.status == "true")
            
        {
            result = response.score
            
            
            
            //performSegue(withIdentifier: "one", sender: self)
        }
    }

    
    
   
   
}
