//
//  CompanyDetailsViewController.swift
//  QR Code Interview Question
//
//  Created by Harsh Patel on 28/01/19.
//  Copyright © 2019 Harsh Patel. All rights reserved.
//

import UIKit
import DataCache
public struct Company_Insert:Decodable {
    
    public var status : String!
    
}
public struct CompanyUpdate:Decodable {
    
    public var status : String!
    
}
class fetch : NSObject,NSCoding,Decodable{
    
    public var about_company : String
    public var address : String
    public var address_line_1 : String
    public var company_name : String
    public var established : String
    public var image : String
    public var status : String
    public var website_name : String
    
    public required init?(coder aDecoder: NSCoder) {
        self.about_company = aDecoder.decodeObject(forKey: "about_company") as! String
        self.status = aDecoder.decodeObject(forKey: "status") as! String
        self.address = aDecoder.decodeObject(forKey: "address") as! String
        self.address_line_1 = aDecoder.decodeObject(forKey: "address_line_1") as! String
        self.image = aDecoder.decodeObject(forKey: "image") as! String
        self.company_name = aDecoder.decodeObject(forKey: "company_name") as! String
        self.established = aDecoder.decodeObject(forKey: "established") as! String
        self.website_name = aDecoder.decodeObject(forKey: "website_name") as! String
        
    }
    
    open func encode(with aCoder: NSCoder) {
        aCoder.encode(self.about_company, forKey: "about_company")
        aCoder.encode(self.address_line_1, forKey: "address_line_1")
        aCoder.encode(self.address, forKey: "address")
        aCoder.encode(self.image, forKey: "image")
        aCoder.encode(self.company_name, forKey: "company_name")
        aCoder.encode(self.established, forKey: "established")
        aCoder.encode(self.website_name, forKey: "website_name")
        aCoder.encode(self.status, forKey: "status")
    }
    
    
    
}



class CompanyDetailsViewController: UIViewController {
    
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var address_line_1: UITextView!
    @IBOutlet weak var about_company: UITextView!
    @IBOutlet weak var website_name: UITextField!
    @IBOutlet weak var established: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var company_name: UITextField!
    @IBOutlet weak var BtnOutet: roundedBtn!
    
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)

    
    
    var lid = UserDefaults.standard.value(forKey: "lidkey") as! String
    var stat = ""
    
    @IBAction func BtnlogOut(_ sender: Any) {
         DataCache.instance.cleanAll()
        let logoutcmp = self.storyboard?.instantiateViewController(withIdentifier: "logout")
        self.navigationController?.pushViewController(logoutcmp!, animated: true)
    }
    @IBAction func Btnpress(_ sender: Any) {
        
        if stat == "false" {
              BtnOutet.setTitle("Insert", for: .normal)
            indicator.startAnimating()
        POST_Data(company_name:company_name.text!,lid:lid,established:established.text!,website_name:website_name.text!,about_company:about_company.text!,address:address.text!,address_line_1:address_line_1.text!)
        
        }
        else if stat == "true"
        {
            indicator.startAnimating()
            Update_Data(lid : lid
                ,company_name:company_name.text!,established:established.text!,website_name:website_name.text!,about_company:about_company.text!,address:address.text!,address_line_1:address_line_1.text!)
            
        }
        else
        {
            print("fail")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        indicator.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        indicator.center = view.center
        let transform: CGAffineTransform = CGAffineTransform(scaleX: 2.5, y: 2.5)
        indicator.transform = transform
        // indicator.color = UIColor.black
        self.view.addSubview(indicator)
        self.view.bringSubviewToFront(indicator)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        
        indicator.startAnimating()
        
       // self.about_company.layer.borderColor = UIColor .blue.cgColor
        //self.address_line_1.layer.borderColor = UIColor.blue.cgColor
        self.about_company.layer.borderWidth = 2.0;
        self.about_company.layer.cornerRadius = 8;
        self.address_line_1.layer.borderWidth = 2.0;
        self.address_line_1.layer.cornerRadius = 8 ;
        Fetch_data(lid: lid)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    BtnOutet.setTitle("Insert", for: .normal)

        // Do any additional setup after loading the view.
    }
//////////////////////////////////////////////////////////////////////////////////////////////////fetch parsing
    
    func Fetch_data(lid:String)
    {
        //Make ADDRESS URL
       /* let reqUrl = URL(string: "https://pks83347.000webhostapp.com/company_detail_fetch.php")
        //GET DATA FROM TEXT FIELD AND PUT INTO DICTIONARY on KEY NAME
        let reqDict = ["lid":lid]
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
                        let response = try JSONDecoder().decode(fetch.self, from: resData!)
                        //print(response.Registration)
                        DispatchQueue.main.async(execute:{
                            self.fetchfunc(response: response)
                        }
                        )
                    }
                    catch{
                        print(exception())
                    }
                }
            })
            task.resume()
        }
        catch{
            
            print(exception())
        }*/
        
        let u = url + "company_detail_fetch.php";
        
        let reqUrl = URL(string: u)
        
        
        //GET DATA FROM TEXT FIELD AND PUT INTO DICTIONARY on KEY NAME
        
        let reqDict = ["lid":Int(lid)]
        
        
        
        
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
                        let response = try JSONDecoder().decode(fetch.self, from: resData!)
                        print("my Scanning value is",response.status)
                        DispatchQueue.main.async(execute:{
                            let reqUrl = URL(string: url + response.image)
                            let data = NSData(contentsOf: reqUrl!)
                            if data != nil
                            {
                                let image =  UIImage(data:data as! Data)
                                DataCache.instance.write(image: image!, forKey: "companyside_own_image")
                            }
                            
                            DataCache.instance.write(object: response , forKey: "companyside_own_Key2")
                            self.fetchfunc()
                            
                            
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
    
    //response ma json ane ios ma dictionary ->1
   /* func fetchFunc()
    {
        let response:SDfetch = DataCache.instance.readObject(forKey: "Key2") as! SDfetch
        st = response.status
        if(response.status == "true")
        {
            txtFirstName.text = response.first_name
            txtLastName.text = response.last_name
            txtTechnology.text = response.technology
            txtQualification.text = response.highest_qualification
            txt10th.text  = response.tenth_mark
            txt12th.text = response.twelve_mark
            
            //let reqUrl = URL(string: url + response.image)
            //let data = NSData(contentsOf: reqUrl!)
            //if data != nil
            //{
            imgprofile.image = DataCache.instance.readImageForKey(key: "imageKey")
            // }
            btnout.setTitle("Update", for: .normal)
            print ("Update")
            
            //performSegue(withIdentifier: "one", sender: self)
        }
        else if (response.status == "false")
        {
            
            print ("please insert value now")
            
            btnout.setTitle("Insert", for: .normal)
            
            
            
            
        }
        
    }*/
    func fetchfunc()
    {
         let response:fetch = DataCache.instance.readObject(forKey: "companyside_own_Key2") as! fetch
        stat = response.status
        print (stat )
        print ("my status")
        if response.status == "true"
        {
            indicator.stopAnimating()
            address.text = response.address
            address_line_1.text = response.address_line_1
            established.text = response.established
            about_company.text = response.about_company
            company_name.text = response.company_name
            website_name.text = response.website_name
            //let reqUrl = URL(string: url + response.image)
            //let data = NSData(contentsOf: reqUrl!)
            //if data != nil
            //{
                myImage.image = DataCache.instance.readImageForKey(key: "companyside_own_image")
            //}
            BtnOutet.setTitle("Update", for: .normal)
            
        }
        else if response.status == "false"
        {
            indicator.stopAnimating()
            BtnOutet.setTitle("Insert", for: .normal)
            showalert(title: "Message", message: "Insert your company details", handlerOk: { ACTION in print("insert company detail called")})
        }
    }
    
   //////////////////////////////////////////////////////////////////////////////////////////insert parsing
    
    
    
    func POST_Data (company_name:String,lid:String,established:String,website_name:String,about_company:String,address:String,address_line_1:String)
    {
        //Make ADDRESS URL
        
        let u = url + "company_details_insert.php";
        
        let reqUrl = URL(string: u)
       
        //GET DATA FROM TEXT FIELD AND PUT INTO DICTIONARY on KEY NAME
        let reqDict = ["company_name":company_name,"lid":lid,"established":established,"website_name":website_name,"about_company":about_company,"address":address,"address_line_1":address_line_1]
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
                        let response = try JSONDecoder().decode(Company_Insert.self, from: resData!)
                        
                        DispatchQueue.main.async(execute:{
                           self.InsertFunc(response: response)
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
    
    func InsertFunc(response : Company_Insert)
        {
            if(response.status! == "true")
                
            {
                
                print("Insertion successful")
                
                indicator.stopAnimating()
                
                showalert(title: "Message", message: "Data inserted successfully", handlerOk: { ACTION in  self.Fetch_data(lid: self.lid)})
                DataCache.instance.clean(byKey: "companyside_own_image")
                DataCache.instance.clean(byKey: "companyside_own_Key2")
                
                //performSegue(withIdentifier: "one", sender: self)
            }
            else
            {
                print("Error in update")
                showalert(title: "Message", message: "Data is not inserted please try again", handlerOk: { ACTION in  print("not inserted ")})
                
            }
        }
    
///////////////////////////////////////////////////////////////////////////////////////////
        
    func Update_Data(lid:String,company_name:String,established:String,website_name:String,about_company:String,address:String,address_line_1:String)
    {
        //Make ADDRESS URL
        let reqUrl = URL(string: "https://pks83347.000webhostapp.com/company_details_update.php")
        //GET DATA FROM TEXT FIELD AND PUT INTO DICTIONARY on KEY NAME
        let reqDict = ["lid":lid,"company_name":company_name,"established":established,"website_name":website_name,"about_company":about_company,"address":address,"address_line_1":address_line_1]
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
                        let response = try JSONDecoder().decode(CompanyUpdate.self, from: resData!)
                        print(response.status!)
                        DispatchQueue.main.async(execute:{
                            
                            
                            
                            self.UpdateFunc(response: response)
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
    
    
    
    func UpdateFunc(response : CompanyUpdate)
    {
        if(response.status! == "true")
            
        {
            print("Updated successful")
            indicator.stopAnimating()
            showalert(title: "Message", message: "Data updated successfully ", handlerOk: { ACTION in print("updated called")})
            //performSegue(withIdentifier: "one", sender: self)
        }
        else
        {
            showalert(title: "Message", message: "Data is not updated please try again", handlerOk: { ACTION in print("not updated ")})
            print("Error in update")
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
