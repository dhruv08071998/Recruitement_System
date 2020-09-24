//
//  companiesViewController.swift
//  QR Code Interview Question
//
//  Created by Harsh Patel on 24/01/19.
//  Copyright © 2019 Harsh Patel. All rights reserved.
//

import UIKit
import DataCache
class mycompanies : NSObject,NSCoding, Decodable{
    
    public var lid: String
    public var about_position : String
    public var applydate : String
    public var number_of_questions : String
    public var opid : String
    public var others_details : String
    public var post : String
    public var skills : String
    public var technology : String
    public var test_date : String
    public var time_of_test : String
    public var vacancy : String
    public var email : String
    public var contact_number: String
    public var image : String
    public var company_name : String
    public var address: String
    public var established : String
    public var website_name : String
    public var about_company : String
    public var address_line_1 : String
    
    
    
    
    public required init?(coder aDecoder: NSCoder) {
        self.lid = aDecoder.decodeObject(forKey: "lid") as! String
        self.about_position = aDecoder.decodeObject(forKey: "about_position") as! String
        self.applydate = aDecoder.decodeObject(forKey: "applydate") as! String
        self.number_of_questions = aDecoder.decodeObject(forKey: "number_of_questions") as! String
        self.opid  = aDecoder.decodeObject(forKey: "opid") as! String
        self.others_details = aDecoder.decodeObject(forKey: "others_details") as! String
        self.post = aDecoder.decodeObject(forKey: "post") as! String
        self.skills = aDecoder.decodeObject(forKey: "skills") as! String
        self.technology = aDecoder.decodeObject(forKey: "technology") as! String
        self.test_date = aDecoder.decodeObject(forKey: "test_date") as! String
        self.time_of_test = aDecoder.decodeObject(forKey: "time_of_test") as! String
        self.vacancy = aDecoder.decodeObject(forKey: "vacancy") as! String
        self.email = aDecoder.decodeObject(forKey: "email") as! String
        self.contact_number = aDecoder.decodeObject(forKey: "contact_number") as! String
        self.image = aDecoder.decodeObject(forKey: "image") as! String
        self.company_name = aDecoder.decodeObject(forKey: "company_name") as! String
        self.address = aDecoder.decodeObject(forKey: "address") as! String
        self.established = aDecoder.decodeObject(forKey: "established") as! String
        self.website_name = aDecoder.decodeObject(forKey: "website_name") as! String
        self.about_company = aDecoder.decodeObject(forKey: "about_company") as! String
        self.address_line_1 = aDecoder.decodeObject(forKey: "address_line_1") as! String
        
        
    }
    
    open func encode(with aCoder: NSCoder) {
        aCoder.encode(self.lid, forKey: "lid")
        aCoder.encode(self.about_position, forKey: "about_position")
        aCoder.encode(self.applydate, forKey: "applydate")
        aCoder.encode(self.number_of_questions, forKey: "number_of_questions")
        aCoder.encode(self.opid, forKey: "opid")
        aCoder.encode(self.others_details, forKey: "others_details")
        aCoder.encode(self.post, forKey: "post")
        aCoder.encode(self.skills, forKey: "skills")
        aCoder.encode(self.technology, forKey: "technology")
        aCoder.encode(self.test_date, forKey: "test_date")
        aCoder.encode(self.time_of_test, forKey: "time_of_test")
        aCoder.encode(self.vacancy, forKey: "vacancy")
        aCoder.encode(self.email, forKey: "email")
        aCoder.encode(self.contact_number, forKey: "contact_number")
        aCoder.encode(self.image, forKey: "image")
        aCoder.encode(self.company_name, forKey: "company_name")
        aCoder.encode(self.address, forKey: "address")
        aCoder.encode(self.established, forKey: "established")
        aCoder.encode(self.website_name, forKey: "website_name")
        aCoder.encode(self.about_company, forKey: "about_company")
        aCoder.encode(self.address_line_1, forKey: "address_line_1")
        
        
    }
    
    
}




class companiesViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{
    
    var lid = UserDefaults.standard.value(forKey: "lidkey") as! String
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.arrdata.count)
       
       
         return self.arrdata.count
    }
    
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : companyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "companycell") as! companyTableViewCell
        
        cell.txtCompanyName.text = arrdata[indexPath.row].company_name
        cell.txtappliDate.text = arrdata[indexPath.row].applydate
        cell.txttestDate.text = arrdata[indexPath.row].test_date
        cell.txtlocation.text = arrdata[indexPath.row].address
        cell.txtwebsite.text = arrdata[indexPath.row].website_name
        //let reqUrl = URL(string: url + arrdata[indexPath.row].image)
        //let data = NSData(contentsOf: reqUrl!)
        //if data != nil
        //{
        cell.imgCompanylogo.image =  thisimages[indexPath.row]
        //}
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail:StudentSideSeectedCompany = self.storyboard?.instantiateViewController(withIdentifier: "detail") as! StudentSideSeectedCompany
        detail.Technology = arrdata[indexPath.row].technology
        detail.AboutPosition = arrdata[indexPath.row].about_position
        detail.SkilRequired = arrdata[indexPath.row].skills
        detail.TestDate = arrdata[indexPath.row].test_date
        detail.ApplyDate = arrdata[indexPath.row].applydate
        detail.AboutCompany = arrdata[indexPath.row].about_company
        detail.location = arrdata[indexPath.row].address
        detail.OtherDetails = arrdata[indexPath.row].others_details
        detail.image = thisimages[indexPath.row]
        detail.vacancy = arrdata[indexPath.row].vacancy
        detail.Post = arrdata[indexPath.row].post
        detail.opid = arrdata[indexPath.row].opid
        detail.cid = arrdata[indexPath.row].lid
        detail.Website = arrdata[indexPath.row].website_name
        detail.yearofEst = arrdata[indexPath.row].established
        detail.companyName = arrdata[indexPath.row].company_name
        detail.companyAddress = arrdata[indexPath.row].address_line_1
        detail.lid = lid
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    
    var arrdata = [mycompanies]()
    
    @IBOutlet weak var tabelview: UITableView!
    
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
        companyfunc (lid: lid )
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 215
    }
    
    var thisimages = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
   func loadFunc(){
        /* let response:[mycompanies] = DataCache.instance.readObject(forKey: "Key4") as! [mycompanies]
         self.thisimages = (DataCache.instance.readObject(forKey: "myimages1") as? [UIImage])!
         print(response.count)
         for mainarr in 0..<(response.count) {
         self.tabelview.reloadData()
         
         
         }*/
        let response:[mycompanies] = DataCache.instance.readObject(forKey: "studentseide_company") as! [mycompanies]
        self.thisimages = (DataCache.instance.readObject(forKey: "my") as? [UIImage])!
        print(response.count)
        indicator.stopAnimating()
        if(self.arrdata.count == 0)
        {
            indicator.stopAnimating()
            showalert(title: "Message", message: "No data found", handlerOk: { ACTION in print("result ferch called")})
        }
        for mainarr in 0..<(response.count) {
            self.tabelview.reloadData()
            
            
        }
    }
 
    //var status = true
    func companyfunc(lid : String)
    {
       
       /*var imgarr = [UIImage]()
        
        let u = url + "company_fetch.php"
        let reqUrl = URL(string: u)
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
                        
                            self.arrdata = try JSONDecoder().decode([mycompanies].self, from: resData!)
                            //status = true
                        
                        DispatchQueue.main.async(execute:{
                          
                                let total_data=self.arrdata.count
                            if(DataCache.instance.readObject(forKey: "myimages2") as? [UIImage]==nil)
                            {
                            for i in  0..<(total_data)
                                {
                                    print(self.arrdata[i].image)
                                    
                                    let reqUrl = URL(string: url + self.arrdata[i].image)
                                    let data = NSData(contentsOf: reqUrl!)
                                    if data != nil
                                    {
                                        let image =  UIImage(data:data as! Data)
                                        imgarr.append(image!)
                                    }
                                     DataCache.instance.write(object: imgarr as NSCoding, forKey: "myimages2")
                                      //  self.status = false
                                    
                                    
                                    
                                    
                                }
                            }
                            
                            self.thisimages = (DataCache.instance.readObject(forKey: "myimages2") as? [UIImage])!
                            // print(response.count)
                            for mainarr in 0..<(self.arrdata.count) {
                                self.tabelview.reloadData()
                            }
                               
                            
                            
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
        }*/
        
        
       var imgarr = [UIImage]()
        var status = true
        let u = url + "company_fetch.php"
        let reqUrl = URL(string: u)
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
                        if((DataCache.instance.readObject(forKey: "studentseide_company") as?[mycompanies])==nil)
                        {
                            self.arrdata = try JSONDecoder().decode([mycompanies].self, from: resData!)
                            status = true
                        }
                        else{
                            self.arrdata = DataCache.instance.readObject(forKey: "studentseide_company") as! [mycompanies]
                            status = false
                        }
                        DispatchQueue.main.async(execute:{
                            if(status==true)
                            {
                                DataCache.instance.write(object: self.arrdata as NSCoding , forKey: "studentseide_company")
                                let total_data=self.arrdata.count
                                for i in  0..<(total_data)
                                {
                                    print(self.arrdata[i].image)
                                    let reqUrl = URL(string: url + self.arrdata[i].image)
                                    let data = NSData(contentsOf: reqUrl!)
                                    if data != nil
                                    {
                                        let image =  UIImage(data:data as! Data)
                                        imgarr.append(image!)
                                    }
                                    
                                    
                                    
                                    
                                    
                                    
                                }
                                DataCache.instance.write(object: imgarr as NSCoding, forKey: "my")
                            }
                            self.loadFunc()
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
    
    
    
    
    
    
    
    
    
}

