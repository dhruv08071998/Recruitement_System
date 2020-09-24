//
//  personalViewController.swift
//  QR Code Interview Question
//
//  Created by Harsh Patel on 24/01/19.
//  Copyright © 2019 Harsh Patel. All rights reserved.
//

import UIKit
import DataCache
//import LinearProgressBarMaterial
public struct SDregister: Decodable {
    public var status : String!
    public var Insertion: String!
    public var sid : Int!
    
}
class SDfetch: NSObject, Decodable,NSCoding {
    
    public var first_name : String
    public var last_name : String
    public var status: String
    public var highest_qualification: String
    public var technology: String
    public var tenth_mark : String
    public var twelve_mark : String
    public var image : String
    
    public required init?(coder aDecoder: NSCoder) {
        self.first_name = aDecoder.decodeObject(forKey: "first_name") as! String
        self.status = aDecoder.decodeObject(forKey: "status") as! String
        self.last_name = aDecoder.decodeObject(forKey: "last_name") as! String
        self.highest_qualification = aDecoder.decodeObject(forKey: "highest_qualification") as! String
        self.image = aDecoder.decodeObject(forKey: "image") as! String
        self.technology = aDecoder.decodeObject(forKey: "technology") as! String
         self.tenth_mark = aDecoder.decodeObject(forKey: "tenth_mark") as! String
         self.twelve_mark = aDecoder.decodeObject(forKey: "twelve_mark") as! String
       // self.status = aDecoder.decodeObject(forKey: "status") as! String
    }
    
    open func encode(with aCoder: NSCoder) {
        aCoder.encode(self.first_name, forKey: "first_name")
        aCoder.encode(self.last_name, forKey: "last_name")
        aCoder.encode(self.highest_qualification, forKey: "highest_qualification")
        aCoder.encode(self.image, forKey: "image")
        aCoder.encode(self.technology, forKey: "technology")
        aCoder.encode(self.tenth_mark, forKey: "tenth_mark")
        aCoder.encode(self.twelve_mark, forKey: "twelve_mark")
        aCoder.encode(self.status, forKey: "status")
    }
    
}
public struct SDUpdated : Decodable {
    
    public var status : String!
    public var msg : String!
    
}


class personalViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate{

    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)

    @IBOutlet weak var imgprofile: UIImageView!
    
    
    @IBOutlet weak var btnout: roundedBtn!
    ////////////////////////////////////////////////////////////////////////////////////////
    //////// list for picker controller
    let tech = ["Web Development","ios App Deveopment","Android Development","Software Development","All"]
    let qual = ["BE","ME","BSC","MSC"]
    var picker = UIPickerView()
    
    //////////////////////////////////////////////////////////////////////////////////////////////
    var currentTextField = UITextField()
    
    
    @IBAction func BtnlogOut(_ sender: Any) {
        DataCache.instance.cleanAll()
        let logoutstd = self.storyboard?.instantiateViewController(withIdentifier: "logout")
        self.navigationController?.pushViewController(logoutstd!, animated: true)
    }
    
    
    @IBOutlet weak var txtTechnology: Specialfield!
    @IBOutlet weak var txt12th: Specialfield!
    @IBOutlet weak var txt10th: Specialfield!
    @IBOutlet weak var txtQualification: Specialfield!
    @IBOutlet weak var txtLastName: Specialfield!
    @IBOutlet weak var txtFirstName: Specialfield!
    
    
    var st = ""
    
    var lid = UserDefaults.standard.value(forKey: "lidkey") as! String
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        indicator.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        indicator.center = view.center
        let transform: CGAffineTransform = CGAffineTransform(scaleX: 2.5, y: 2.5)
        indicator.transform = transform
       // indicator.color = UIColor.black
        self.view.addSubview(indicator)
        self.view.bringSubviewToFront(indicator)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
       
        //indicator.startAnimating()
        
        btnout.setTitle("Insert", for: .normal)
        if((DataCache.instance.readObject(forKey: "Key2") as? SDfetch)==nil)
        {
            indicator.startAnimating()
            sdfetch(Lid:lid)
            print (st)
        }
        else{
            
            fetchFunc()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        // Do any additional setup after loading the view.
    }
    
    //@IBOutlet weak var scrollView: UIView!
    @IBOutlet weak var sv: UIView!

    
    
    @IBAction func BtnPress(_ sender: Any) {
        var flag : Bool = false
        let v = validation()
        let tech = txtTechnology.text!
        let twel = txt12th.text!
        let ten = txt10th.text!
        let qual = txtQualification.text!
        let lastname = txtLastName.text!
        let firstname = txtFirstName.text!
        
        indicator.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        indicator.center = view.center
        self.view.addSubview(indicator)
        self.view.bringSubviewToFront(indicator)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        if( v.isEmpty(value: tech) == true)
        {
            flag = true
        }
        else
        {
         flag = false
         txtTechnology.text = ""
         txtTechnology.attributedPlaceholder = NSAttributedString(string: "Please enter technology",attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
         }
        if( v.isEmpty(value: twel) == true)
        {
            flag = true
        }
        else
        {
            flag = false
            txt12th.text = ""
            txt12th.attributedPlaceholder = NSAttributedString(string: "Please enter 12th marks ",attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        }
        if( v.isEmpty(value: ten) == true)
        {
            flag = true
        }
        else
        {
            flag = false
            txt10th.text = ""
            txt10th.attributedPlaceholder = NSAttributedString(string: "Please enter 10th marks",attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        }
        if( v.isEmpty(value: firstname) == true)
        {
            flag = true
        }
        else
        {
            flag = false
            txtFirstName.text = ""
            txtFirstName.attributedPlaceholder = NSAttributedString(string: "Please enter first name",attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        }
        if( v.isEmpty(value: lastname) == true)
        {
            flag = true
        }
        else
        {
            flag = false
            txtLastName.text = ""
            txtLastName.attributedPlaceholder = NSAttributedString(string: "Please enter last name ",attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        }
        if( v.isEmpty(value: qual) == true)
        {
            flag = true
        }
        else
        {
            flag = false
            txtQualification.text = ""
            txtQualification.attributedPlaceholder = NSAttributedString(string: "Please enter Qualification",attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        }
        
        
     if (flag == true)
     {
        
        if ( st == "false")
        {
            indicator.startAnimating()
            POST_Data_into_Sd(Lid : lid,firstname: (txtFirstName).text!, lastname: (txtLastName).text!, qualification: (txtQualification).text!, technology: (txtTechnology).text!, ten:  (txt10th).text!, twelve: (txt12th).text!)
           
        }
        if (  st == "true")
        {
            indicator.startAnimating()
            Update_Sd(Lid : lid,firstname:(txtFirstName).text!, lastname:(txtLastName).text!, qualification:(txtQualification).text!, technology:(txtTechnology).text! , ten:( txt10th).text!, twelve:(txt12th).text! )
            
            
        }
     }
     else
     {
        print("Error in data insert")
        }
        
    }
    
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////picker view code
    public func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    
    // returns the # of rows in each component..
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
      if currentTextField == txtTechnology{
            return tech.count
       }
        else if currentTextField == txtQualification{
           return qual.count
        }
        else
        {
          return 0
        }
 
       
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       if currentTextField == txtTechnology{
            return tech[row]
        }
        else if currentTextField == txtQualification
        {
            return qual[row]
        }
        else
        {
            return ""
        }
 
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
       if currentTextField == txtTechnology{
            txtTechnology.text = tech[row]
            self.view.endEditing(true)
        }
        else if currentTextField == txtQualification
        {
            txtQualification.text = qual[row]
            self.view.endEditing(true)
        }
    }
    public func textFieldDidBeginEditing(_ textField: UITextField){
        self.picker.delegate = self as! UIPickerViewDelegate
        self.picker.dataSource = self as! UIPickerViewDataSource
        currentTextField = textField
        if currentTextField == txtTechnology
        {
            currentTextField.inputView = picker
        }
        else if currentTextField == txtQualification
        {
            currentTextField.inputView = picker
        }
        
        
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////picker view code end
    
    
    
///////////////////////////////////////////////////////////////////////////////////////////////// Student_detail insertion api calling
    
    func POST_Data_into_Sd(Lid:String,firstname:String, lastname:String, qualification:String, technology:String , ten:String, twelve:String )
        
    {
        
        //Make ADDRESS URL
        
        let u = url + "student_details_insert.php";
        
        let reqUrl = URL(string: u)
        
        print(Lid)
        
        //GET DATA FROM TEXT FIELD AND PUT INTO DICTIONARY on KEY NAME
        
        let reqDict =
            ["lid":Lid,"first_name":firstname,"last_name":lastname,"highest_qualification":qualification,"technical_skill":technology ,"tenth_marks":ten,"twelth_marks":twelve]
        
        
        
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
                        let response = try JSONDecoder().decode(SDregister.self, from: resData!)
                      print("my insert status",response.status!)
                        DispatchQueue.main.async(execute:{
                            
                            
                            
                            self.parsdata(response: response)
                            
                            
                            
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
    func parsdata(response : SDregister)
    {
        //print(response.status!)
        if(response.status! == "true")
            
        {
            indicator.stopAnimating()
            print("Insertion successful")
            showalert(title: "Message", message: "Data inserted successfully", handlerOk: { ACTION in  self.sdfetch(Lid:self.lid)})
            DataCache.instance.clean(byKey: "Key2")
            DataCache.instance.clean(byKey: "imageKey")
           
            
            //performSegue(withIdentifier: "one", sender: self)
        }
        else{
            showalert(title: "Message", message: "Data is not inserted please try again", handlerOk: { ACTION in  print("not inserted ")})
            
        }
    }
    
//////////////////////////////////////////////////////////////////////////////////////////////////////////calling ends
    
    
/////////////////////////////////////////////////////////////////////////////////////////////////////Student_detail fetch api calling
    
    func sdfetch(Lid:String)
        
    {
        
        //Make ADDRESS URL
        
        
        let u = url + "student_fetch.php";
        
        let reqUrl = URL(string: u)
        
        
        //GET DATA FROM TEXT FIELD AND PUT INTO DICTIONARY on KEY NAME
        
        let reqDict = ["lid":Int(Lid)]
        
        
        
        
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
                        let response = try JSONDecoder().decode(SDfetch.self, from: resData!)
                        print("my Scanning value is",response.status)
                        DispatchQueue.main.async(execute:{
                            let reqUrl = URL(string: url + response.image)
                            let data = NSData(contentsOf: reqUrl!)
                            if data != nil
                            {
                               let image =  UIImage(data:data as! Data)
                                DataCache.instance.write(image: image!, forKey: "imageKey")
                            }
                            
                             DataCache.instance.write(object: response , forKey: "Key2")
                           self.fetchFunc()
                            
                          
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
    
    func fetchFunc()
    {
        let response:SDfetch = DataCache.instance.readObject(forKey: "Key2") as! SDfetch
        st = response.status
        if(response.status == "true")
        {
            indicator.stopAnimating()
            txtFirstName.text = response.first_name
            txtLastName.text = response.last_name
            txtTechnology.text = response.technology
            txtQualification.text = response.highest_qualification
            txt10th.text  = response.tenth_mark
            txt12th.text = response.twelve_mark
        
            imgprofile.image = DataCache.instance.readImageForKey(key: "imageKey")
           // }
            btnout.setTitle("Update", for: .normal)
            print ("Update")
            
            //performSegue(withIdentifier: "one", sender: self)
        }
        else if (response.status == "false")
        {
            
            print ("please insert value now")
            
            indicator.stopAnimating()
            
            showalert(title: "Message", message: "Please insert your personal details", handlerOk: { ACTION in print("Insert your details ")})
            
            
            btnout.setTitle("Insert", for: .normal)
            
            

            
        }
    
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func Update_Sd(Lid:String,firstname:String, lastname:String, qualification:String, technology:String , ten:String, twelve:String )
        
    {
        DataCache.instance.clean(byKey: "Key2")
        //Make ADDRESS URL
        
        let u = url + "student_details_update.php";
        
        let reqUrl = URL(string: u)
        
        
        //GET DATA FROM TEXT FIELD AND PUT INTO DICTIONARY on KEY NAME
        
        let reqDict =
            ["lid":Lid,"first_name":firstname,"last_name":lastname,"highest_qualification":qualification,"technical_skill":technology ,"tenth_marks":ten,"twelth_marks":twelve]
        
        
        
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
                        let response = try JSONDecoder().decode(SDUpdated.self, from: resData!)
                        print("Update status is :",response.status!)
                        DispatchQueue.main.async(execute:{
                            
                            
                            
                            self.Updated(response: response)
                            
                            
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
    func Updated(response : SDUpdated)
    {
        if(response.status! == "true")
        {
            print(response.msg!)
            indicator.stopAnimating()
            showalert(title: "Message", message: "Data updated successfully ", handlerOk: { ACTION in print("updated called")})
            //performSegue(withIdentifier: "one", sender: self)
        }
        else{
            showalert(title: "Message", message: "Data is not updated please try again", handlerOk: { ACTION in  print("not updated ")})
        }
    }
    
   
    

}
//DataCache.instance.clean(byKey: "papersetfetch_Key")

