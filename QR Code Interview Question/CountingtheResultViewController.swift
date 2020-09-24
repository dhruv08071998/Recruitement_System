//
//  CountingtheResultViewController.swift
//  QR Code Interview Question
//
//  Created by Harsh Patel on 06/02/19.
//  Copyright © 2019 Harsh Patel. All rights reserved.
//

import UIKit
import DataCache

public struct myresult : Decodable
{
    
    public var  status : String
    
    public var  rid : String
    
}


class CountingtheResultViewController: UIViewController {

    var result = ""
    var Score = ""
    var Lid = ""
    var Cid = ""
    var Set_id = ""
    
    override func viewWillAppear(_ animated: Bool) {
        
        let val = UserDefaults.standard.bool(forKey: "locked")
        
        if val == true
        {
          OutletBtnBack.isEnabled = false
        }
        else
        {
            OutletBtnBack.isEnabled = true
        }
    }
   
    @IBOutlet weak var OutletBtnBack: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Lid = UserDefaults.standard.value(forKey: "lidkey") as! String
        print("this is lid:",self.Lid)
        self.Cid = UserDefaults.standard.value(forKey: "CidKey") as! String
        print("this is cid: ",self.Cid)
        self.Set_id = UserDefaults.standard.value(forKey: "SetidKey") as! String
        print("this is set_ id: ",self.Set_id)
        self.Score = result
        print("this is result: ",self.result)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBack(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func BtnEndTest(_ sender: Any) {
        
        uploadresult(lid: Lid , cid: Cid , set_id: Set_id , score: Score )
        
        
    }
    

    
    func uploadresult(lid: String, cid: String , set_id: String ,score: String )
        
    {
        
        //Make ADDRESS URL
         //UserDefaults.standard.set(url , forKey: "urlkey")
        
        let myurl = UserDefaults.standard.value(forKey: "urlkey") as! String
        
        //let u =  "https://pks83347.000webhostapp.com/student_result_insert.php";
        
        let reqUrl = URL(string: myurl + "student_result_insert.php")
        
        
        
        //GET DATA FROM TEXT FIELD AND PUT INTO DICTIONARY on KEY NAME
        
        let reqDict = ["lid":lid, "cid":cid , "set_id":set_id, "score":score]
        
        
        
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
                        var response = try JSONDecoder().decode(myresult.self, from: resData!)                     //   print(response.status!)
                        DispatchQueue.main.async(execute:{
                            
                            
                            
                            self.insertresult(response: response)
                            
                            
                            
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
    func insertresult(response : myresult)
    {
        print(response.status)
        if(response.status == "success")
        {
            //navigationController?.popToRootViewController(animated: true)
            DataCache.instance.clean(byKey: "Key3")
            DataCache.instance.clean(byKey: "myimages")
            let studenttabbar = self.storyboard?.instantiateViewController(withIdentifier: "endtest")
            self.navigationController?.pushViewController(studenttabbar!, animated: true)
        }
        else
        {
            print ("error in status")
        }
        
    }
    
    
    
    
    
}
