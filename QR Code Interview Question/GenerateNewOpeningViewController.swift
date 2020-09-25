//
//  GenerateNewOpeningViewController.swift
//  QR Code Interview Question
//
//  Created by Harsh Patel on 29/01/19.
//  Copyright © 2019 Harsh Patel. All rights reserved.
//

import UIKit
import DataCache

public struct OpeningInsert : Decodable
{
    
    public var status : String!
    
}
public struct OpeningUpdate : Decodable
{

    public var status : String!
   
}

class GenerateNewOpeningViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {
    
   
    let tech = ["Web Development","ios App Deveopment","Android Development","Software Development","All"]
    var picker = UIPickerView()
    var currentTextField = UITextField()
    
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    
    // returns the # of rows in each component..
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if currentTextField == txtTechnology {
            return tech.count
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
        
    }
    public func textFieldDidBeginEditing(_ textField: UITextField){
        self.picker.delegate = self
        self.picker.dataSource = self
        currentTextField = textField
        if currentTextField == txtTechnology
        {
            currentTextField.inputView = picker
        }
        else
        {
            
        }
        
        
    }

    @IBOutlet weak var btnoutlet: roundedBtn!
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated:true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtTestDate.text = TestDate
        txtNumQuestion.text = NumQuestion
        txttotaltime.text = TotalTime
        txtvacency.text = vacancy
        txtapplydate.text = ApplyDate
        txtpost.text = Post
        txtOtherDetails.text = OtherDetails
        txtSkilsRequired.text = SkilRequired
        txtAboutPosition.text = AboutPosition
        txtTechnology.text = Technology
        
        self.txtOtherDetails.layer.borderWidth = 2.0;
        self.txtOtherDetails.layer.cornerRadius = 8;
        self.txtSkilsRequired.layer.borderWidth = 2.0;
        self.txtSkilsRequired.layer.cornerRadius = 8 ;
        self.txtAboutPosition.layer.borderWidth = 2.0;
        self.txtAboutPosition.layer.cornerRadius = 8 ;
        
        if (opid == "" && cid == "" )
        {
            print(opid)
            print(cid)
         btnoutlet.setTitle( "Insert", for: .normal)
        }
        else {
         btnoutlet.setTitle("Update", for: .normal)
        }
        // Do any additional setup after loading the view.
    }
    
    var NumQuestion = ""
    var TotalTime = ""
    var vacancy = ""
    var ApplyDate = ""
    var TestDate = ""
    var Post = ""
    var OtherDetails = ""
    var SkilRequired = ""
    var AboutPosition = ""
    var Technology = ""
    var opid = ""
    var cid = ""
    
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)

    
    let Lid = UserDefaults.standard.value(forKey: "lidkey") as! String
    
    @IBOutlet weak var txtTechnology: Specialfield!
    @IBOutlet weak var txtOtherDetails: CustomView!
    @IBOutlet weak var txtSkilsRequired: CustomView!
    @IBOutlet weak var txtAboutPosition: CustomView!
    @IBOutlet weak var txtTestDate: Specialfield!
    @IBOutlet weak var txtNumQuestion: Specialfield!
    @IBOutlet weak var txttotaltime: Specialfield!
    @IBOutlet weak var txtpost: Specialfield!
    @IBOutlet weak var txtvacency: Specialfield!
    @IBOutlet weak var txtapplydate: Specialfield!
    
    override func viewWillAppear(_ animated: Bool) {
        
        indicator.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        indicator.center = view.center
        let transform: CGAffineTransform = CGAffineTransform(scaleX: 2.5, y: 2.5)
        indicator.transform = transform
        // indicator.color = UIColor.black
        self.view.addSubview(indicator)
        self.view.bringSubviewToFront(indicator)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        

    }
    
    @IBAction func BtnInsert(_ sender: Any) {
        
    if (opid == "" && cid == "")
    {
        indicator.startAnimating()
        insertOpening(lid: Lid,  vacancy: txtvacency.text!, technology: txtTechnology.text!, test_date: txtTestDate.text!, skills: txtSkilsRequired.text!, applydate: txtapplydate.text!, about_position: txtAboutPosition.text!, others_details: txtOtherDetails.text!, post: txtpost.text!,time_of_test: txttotaltime.text!, number_of_questions: txtNumQuestion.text!)
        }
    else if ( opid != "" && cid != "" )
    {
        indicator.startAnimating()
        UpdateOpening(opid: opid , vacancy: txtvacency.text!, technology: txtTechnology.text!, test_date: txtTestDate.text!, skills: txtSkilsRequired.text! , applydate: txtapplydate.text! , about_position: txtAboutPosition.text!, others_details: txtOtherDetails.text!, post: txtpost.text! , time_of_test: txttotaltime.text!, number_of_questions: txtNumQuestion.text!)
        }
        
    }
    
    func insertOpening(lid :String , vacancy: String, technology: String,test_date: String,skills: String,applydate: String,about_position: String,others_details: String,post: String,time_of_test: String,number_of_questions: String)
        
    {
        
        //Make ADDRESS URL
        
        let u = url + "openings_insert.php";
        
        let reqUrl = URL(string: u)
        
        
        //GET DATA FROM TEXT FIELD AND PUT INTO DICTIONARY on KEY NAME
        
        let reqDict =
             ["lid": lid ,"vacancy": vacancy,"technology": technology,"test_date": test_date,"skills":skills,"applydate": applydate,"about_position": about_position,"other_details": others_details,"post": post,"time_of_test": time_of_test,"number_of_questions": number_of_questions]
        
        
        
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
                        let response = try JSONDecoder().decode(OpeningInsert.self, from: resData!)
                        print(response.status!)
                        DispatchQueue.main.async(execute:{
                            
                            
                            
                            self.InsertOpening(response: response)
                            
                            
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
    func InsertOpening(response : OpeningInsert)
    {
        if(response.status! == "true")
        {
            indicator.stopAnimating()
            print("Status :True Successfully Inserted ")
            showalert(title: "Message", message: "Inserted successfully", handlerOk: { ACTION in self.navigationController?.popViewController(animated: true)})
            DataCache.instance.clean(byKey: "companyKey3")
            
        }
        else
        {
            indicator.stopAnimating()
            showalert(title: "Message", message: "Data not inserted please try again", handlerOk: { ACTION in print("not updated ")})
            
        }
    }
    
    
    
    func UpdateOpening(opid: String, vacancy: String, technology: String,test_date: String,skills: String,applydate: String,about_position: String,others_details: String,post: String,time_of_test: String,number_of_questions: String)
        
    {
        
        //Make ADDRESS URL
        
        let u = url + "openings_update.php";
        
        let reqUrl = URL(string: u)
        
        
        //GET DATA FROM TEXT FIELD AND PUT INTO DICTIONARY on KEY NAME
        
        let reqDict =
            ["opid": opid,"vacancy": vacancy,"technology": technology,"test_date": test_date,"skills":skills,"applydate": applydate,"about_position": about_position,"others_details": others_details,"post": post,"time_of_test": time_of_test,"number_of_questions": number_of_questions]
        
        
        
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
                        let response = try JSONDecoder().decode(OpeningUpdate.self, from: resData!)
                        print(response.status!)
                        DispatchQueue.main.async(execute:{
                            
                            
                            
                            self.UpdatedOpening(response: response)
                            
                            
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
    func UpdatedOpening(response : OpeningUpdate)
    {
        if(response.status! == "true")
        {
            print("Status :True ")
            indicator.stopAnimating()
            showalert(title: "Message", message: "Updated successfully", handlerOk: { ACTION in self.navigationController?.popViewController(animated: true)})
            DataCache.instance.clean(byKey: "companyKey3")
            
        }
        else
        {
            indicator.stopAnimating()
            showalert(title: "Message", message: "Data not updated please try again", handlerOk: { ACTION in print("not updated ")})
            
        }
    }
    
    
    
    
    
}
