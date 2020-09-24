//
//  CompanySideStudentProfileViewController.swift
//  QR Code Interview Question
//
//  Created by Harsh Patel on 28/01/19.
//  Copyright © 2019 Harsh Patel. All rights reserved.
//

import UIKit
import DataCache
class StudentProfile :NSObject,NSCoding,Decodable
{
    public var  first_name : String
    public var  last_name : String
    public var  technical_skill : String
    public var  highest_qualification : String
    public var  tenth_marks: String
    public var  twelveth_marks : String
    public var  email : String
    public var  contact_number : String
    public var  image : String
    public var   sid : String
    public var  test_date :String
   
    public required init?(coder aDecoder: NSCoder) {
        self.test_date = aDecoder.decodeObject(forKey: "test_date") as! String
        self.first_name = aDecoder.decodeObject(forKey: "first_name") as! String
        self.contact_number = aDecoder.decodeObject(forKey: "contact_number") as! String
        self.last_name = aDecoder.decodeObject(forKey: "last_name") as! String
        self.technical_skill = aDecoder.decodeObject(forKey: "technical_skill") as! String
        self.highest_qualification = aDecoder.decodeObject(forKey: "highest_qualification") as! String
        self.tenth_marks = aDecoder.decodeObject(forKey: "tenth_marks") as! String
        
        self.twelveth_marks = aDecoder.decodeObject(forKey: "twelveth_marks") as! String
        self.email = aDecoder.decodeObject(forKey: "email") as! String
         self.image = aDecoder.decodeObject(forKey: "image") as! String
        self.sid = aDecoder.decodeObject(forKey: "sid") as! String
    }
    
    open func encode(with aCoder: NSCoder) {
        aCoder.encode(self.test_date, forKey: "test_date")
        aCoder.encode(self.first_name, forKey: "first_name")
        aCoder.encode(self.contact_number, forKey: "contact_number")
        aCoder.encode(self.last_name, forKey: "last_name")
        aCoder.encode(self.technical_skill, forKey: "technical_skill")
        aCoder.encode(self.highest_qualification, forKey: "highest_qualification")
        aCoder.encode(self.tenth_marks, forKey: "tenth_marks")
        aCoder.encode(self.twelveth_marks, forKey: "twelveth_marks")
        aCoder.encode(self.email, forKey: "email")
        aCoder.encode(self.image, forKey: "image")
        aCoder.encode(self.sid, forKey: "sid")
    }
    
    


}

public struct myResult : Decodable
{
    public var status : String
    public var score : String
    
}



class CompanySideStudentProfileViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    
    var arrdata = [StudentProfile]()
    var StdResult = "Panding"
    var Lid = UserDefaults.standard.value(forKey: "lidkey") as! String
    
    @IBOutlet weak var tableview: UITableView!
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
        
        studentfetch(lid: Lid)
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func loadFunc(){
        let response:[StudentProfile] = DataCache.instance.readObject(forKey: "companyKey4") as! [StudentProfile]
        self.thisimages = (DataCache.instance.readObject(forKey: "company_myimages4") as? [UIImage])!
        indicator.stopAnimating()
        if(self.arrdata.count == 0)
        {
            showalert(title: "Message", message: "No data found", handlerOk: { ACTION in print("result ferch called")})
        }
        print(response.count)
        for mainarr in 0..<(response.count) {
            self.tableview.reloadData()
            
            
        }
    }
    var thisimages = [UIImage]()
    func studentfetch(lid : String)
    {
        
        /*let u = url + "company_side_studentdetails.php"
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
                        self.arrdata = try JSONDecoder().decode([StudentProfile].self, from: resData!)
                       // print(self.arrdata[0].about_position)
                        for mainarr in self.arrdata{
                            //print(mainarr.technology,":",mainarr.time_of_test,":",mainarr.applydate)
                            DispatchQueue.main.async {
                                self.tableview.reloadData()
                            }
                            
                        }
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
        let u = url + "company_side_studentdetails.php"
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
                        if((DataCache.instance.readObject(forKey: "companyKey4") as?[StudentProfile])==nil)
                        {
                            self.arrdata = try JSONDecoder().decode([StudentProfile].self, from: resData!)
                            status = true
                        }
                        else{
                            self.arrdata = DataCache.instance.readObject(forKey: "companyKey4") as! [StudentProfile]
                            status = false
                        }
                        DispatchQueue.main.async(execute:{
                            if(status==true)
                            {
                                DataCache.instance.write(object: self.arrdata as NSCoding , forKey: "companyKey4")
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
                                DataCache.instance.write(object: imgarr as NSCoding, forKey: "company_myimages4")
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.arrdata.count)
        return self.arrdata.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : CompanySidestudentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompanyStudentDetail") as! CompanySidestudentTableViewCell
        
        cell.txtTestDate.text = arrdata[indexPath.row].test_date
       
        cell.txtFullName.text = arrdata[indexPath.row].first_name + arrdata[indexPath.row].last_name
        
        cell.txtTechnology.text = arrdata[indexPath.row].technical_skill
        
         self.ResultFunc(sid: arrdata[indexPath.row].sid)
        
        cell.txtResult.text = StdResult
        
       // let reqUrl = URL(string: url + arrdata[indexPath.row].image)
        //let data = NSData(contentsOf: reqUrl!)
        //if data != nil
        //{
            cell.StudentImage.image =  thisimages[indexPath.row]
        //}
        
    
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail: CompanySideStudentDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "new") as! CompanySideStudentDetailsViewController
        detail.technology = arrdata[indexPath.row].technical_skill
        detail.img = thisimages[indexPath.row]
        detail.firstname = arrdata[indexPath.row].first_name
        detail.lastname = arrdata[indexPath.row].last_name
        detail.email = arrdata[indexPath.row].email
        detail.contnum = arrdata[indexPath.row].contact_number
        detail.highQul = arrdata[indexPath.row].highest_qualification
        detail.tenth = arrdata[indexPath.row].tenth_marks
        detail.twelth = arrdata[indexPath.row].twelveth_marks
        detail.sid = arrdata[indexPath.row].sid
        self.navigationController?.pushViewController(detail, animated: true)
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 169
    }
    
    
    func ResultFunc(sid : String )
        
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
                        var response = try JSONDecoder().decode(myResult.self, from: resData!)
                       // print(response.status!)
                        DispatchQueue.main.async(execute:{
                            
                            
                            
                            self.myResultFunc(response: response)
                            
                            
                            
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
    
    func myResultFunc (response : myResult)
    {
        if(response.status == "true")
            
        {
            StdResult = response.score
            
            //performSegue(withIdentifier: "one", sender: self)
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
