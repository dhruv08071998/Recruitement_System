//
//  companyDetailViewController.swift
//  QR Code Interview Question
//
//  Created by Harsh Patel on 27/01/19.
//  Copyright © 2019 Harsh Patel. All rights reserved.
//

import UIKit
import DataCache

public struct Schedule_status : Decodable
{
    
    public var status : String!
    
    
}

class StudentSideSeectedCompany: UIViewController
{
    

    override func viewDidLoad() {
        super.viewDidLoad()
        txtAboutPosition.text = AboutPosition
        txtOtherDetails.text = OtherDetails
        txtEstYear.text = yearofEst
        txtAboutCompany.text = AboutCompany
        txtWebSite.text = Website
        txtCompanyName.text = companyName
        txtTechnology.text = Technology
        txtSkillRequres.text = SkilRequired
        txtPostName.text = Post
        txtVacancy.text = vacancy
        txtTestDate.text = TestDate
        txtLocation.text = location
        txtApplyDate.text = ApplyDate
        txtCopanyAddress.text = companyAddress
        //let reqUrl = URL(string: url + image)
        //let data = NSData(contentsOf: reqUrl!)
        //if data != nil
       // {
            txtMyImage.image =  image
        //}

        // Do any additional setup after loading the view.
    }
    
    
   
    
    
    @IBAction func btnback(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
        
    }
    
   
   
    var AboutCompany = ""
    var Website = ""
    var yearofEst = ""
    var companyName = ""
    var Technology = ""
    var SkilRequired = ""
    var Post = ""
    var vacancy = ""
    var TestDate = ""
    var location = ""
    var companyAddress = ""
    var AboutPosition = ""
    var OtherDetails = ""
    var ApplyDate = ""
   // var image = ""
    var image  = UIImage()
    var opid = ""
    var cid = ""
    var lid = ""
    
    @IBOutlet weak var txtAboutPosition: UITextView!
    @IBOutlet weak var txtOtherDetails: UITextView!
    @IBOutlet weak var txtCopanyAddress: UITextView!
    @IBOutlet weak var txtLocation: UILabel!
    @IBOutlet weak var txtApplyDate: UILabel!
    @IBOutlet weak var txtTestDate: UILabel!
    @IBOutlet weak var txtVacancy: UILabel!
    @IBOutlet weak var txtPostName: UILabel!
    @IBOutlet weak var txtSkillRequres: UITextView!
    @IBOutlet weak var txtTechnology: UILabel!
    @IBOutlet weak var txtAboutCompany: UITextView!
    @IBOutlet weak var txtWebSite: UILabel!
    @IBOutlet weak var txtEstYear: UILabel!
    @IBOutlet weak var txtMyImage: UIImageView!
    @IBOutlet weak var txtCompanyName: UILabel!
    
    
    
    
    @IBAction func btnreguster(_ sender: Any) {
        insert_to_Schedule(lid: lid, cid: cid, opid: opid)
        
    }
    
    func insert_to_Schedule(lid: String , cid:String, opid : String)
        
    {
        
        //Make ADDRESS URL
        
        let u = url + "Schedule_insert.php";
        let reqUrl = URL(string: u)
        
        
        
        //GET DATA FROM TEXT FIELD AND PUT INTO DICTIONARY on KEY NAME
        
        let reqDict = ["lid":lid, "cid":cid, "opid":opid]
        
        
        
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
                        let response = try JSONDecoder().decode(Schedule_status.self, from: resData!)
                        print(response.status!)
                        DispatchQueue.main.async(execute:{
                            
                            
                            
                            self.Schedule_St(response: response)
                            
                            
                            
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
    func Schedule_St (response : Schedule_status)
    {
        if(response.status! == "true")
        {
           print("inserted successfully")
            DataCache.instance.clean(byKey: "Key4")
            DataCache.instance.clean(byKey: "myimagess")
            showalert(title: "Message", message: "Booked successfully", handlerOk: { ACTION in self.navigationController?.popViewController(animated: true)})

            
        }
        
    }
    
    
    /*
    // MARK: - Navigation

     @IBOutlet weak var txtWebSite: UILabel!
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
    

