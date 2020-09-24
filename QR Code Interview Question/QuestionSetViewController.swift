//
//  QuestionSetViewController.swift
//  QR Code Interview Question
//
//  Created by Harsh Patel on 31/01/19.
//  Copyright © 2019 Harsh Patel. All rights reserved.
//

import UIKit
import DataCache

public struct Ack : Decodable{
    
    public var status : String!
}

public struct updateAck : Decodable{
    
    public var status : String!
}



class QuestionSetViewController: UIViewController ,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate{
    @IBOutlet weak var btnoutlet: roundedBtn!
    @IBAction func backbtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    var Lid = UserDefaults.standard.value(forKey: "lidkey") as! String// company lid that is to be inserted
    var diff = ["Easy","Medium","High"]
    var opt = ["A.","B.","C.","D."]
    
    var lid = "" // company lid that is to be fetched
    var txtQst = ""
    var txtopA = ""
    var txtopB = ""
    var txtopC = ""
    var txtopD = ""
    var txtAns = ""
    var txtDiff = ""
    var txtother = ""
    var Qid = ""
    
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)

    @IBOutlet weak var txtDifficulty: Specialfield!
    @IBOutlet weak var txtOtherDetails: CustomView!
    @IBOutlet weak var txtoptionFour: CustomView!
    @IBOutlet weak var txtoptionThree: CustomView!
    @IBOutlet weak var txtoptionOne: CustomView!
    @IBOutlet weak var txtoptionTwo: CustomView!
    @IBOutlet weak var txtquestion: CustomView!
    @IBOutlet weak var txtCorrectAns: Specialfield!
    @IBAction func BtnAddQuestion(_ sender: Any) {
        
     if Qid != ""
     {
        indicator.startAnimating()
        btnoutlet.setTitle("Update  this Question", for: .normal)
        updateQuestion(lid: lid , qid: Qid , txtQ:(txtquestion).text!, txta: (txtoptionOne).text! , txtb:(txtoptionTwo).text!, txtc: (txtoptionThree).text!, txtd: (txtoptionFour).text!, txtAns: (txtCorrectAns).text!, txtDiff:(txtDifficulty).text!, txtother:(txtOtherDetails).text!)
        }
        else
     {
        indicator.startAnimating()
         inputQuestion(lid: Lid, txtQ: (txtquestion).text!, txta: (txtoptionOne).text!, txtb: (txtoptionTwo).text!, txtc: (txtoptionThree).text!, txtd: (txtoptionFour).text!, txtAns: (txtCorrectAns).text!, txtDiff: (txtDifficulty).text!, txtother: (txtOtherDetails).text!)
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
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtquestion.text = txtQst
        txtoptionOne.text = txtopA
        txtoptionTwo.text = txtopB
        txtoptionThree.text = txtopC
        txtoptionFour.text = txtopD
        txtCorrectAns.text = txtAns
        txtDifficulty.text = txtDiff
        txtOtherDetails.text = txtother
        self.txtquestion.layer.borderWidth = 2.0;
        self.txtquestion.layer.cornerRadius = 8 ;
        self.txtoptionOne.layer.borderWidth = 2.0;
        self.txtoptionOne.layer.cornerRadius = 8 ;
        self.txtoptionTwo.layer.borderWidth = 2.0;
        self.txtoptionTwo.layer.cornerRadius = 8 ;
        self.txtoptionThree.layer.borderWidth = 2.0;
        self.txtoptionThree.layer.cornerRadius = 8 ;
        self.txtoptionFour.layer.borderWidth = 2.0;
        self.txtoptionFour.layer.cornerRadius = 8 ;
        self.txtOtherDetails.layer.borderWidth = 2.0;
        self.txtOtherDetails.layer.cornerRadius = 8 ;
        // Do any additional setup after loading the view.
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////
    var picker = UIPickerView()
    var currentTextField = UITextField()
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }

    
    // returns the # of rows in each component..
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if currentTextField == txtDifficulty{
            return diff.count
        }
        else if currentTextField == txtCorrectAns{
            return opt.count
        }
        else
        {
            return 0
        }
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextField == txtDifficulty{
            return diff[row]
        }
        else if currentTextField == txtCorrectAns
        {
            return opt[row]
        }
        else
        {
            return ""
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if currentTextField == txtDifficulty{
            txtDifficulty.text = diff[row]
            self.view.endEditing(true)
        }
        else if currentTextField == txtCorrectAns
        {
            txtCorrectAns.text = opt[row]
            self.view.endEditing(true)
        }
    }
    public func textFieldDidBeginEditing(_ textField: UITextField){
        self.picker.delegate = self
        self.picker.dataSource = self
        currentTextField = textField
        if currentTextField == txtDifficulty
        {
            currentTextField.inputView = picker
        }
        else if currentTextField == txtCorrectAns
        {
            currentTextField.inputView = picker
        }
        
        
    }

    
    
    
    
    
    
    func inputQuestion( lid : String , txtQ : String ,txta : String ,txtb :String , txtc :String,txtd :  String , txtAns :String , txtDiff : String , txtother :String )
    {
        
        let u = url + "question_insert.php";
        
        let reqUrl = URL(string: u)
        
        let reqDict = ["lid": lid,"question":txtQ,"option_A":txta,"option_B":txtb,"option_C":txtc,"option_D":txtd,"correct_option":txtAns,"other_detail":txtother,"level":txtDiff]
        do{
            let reqData = try JSONSerialization.data(withJSONObject: reqDict, options: .prettyPrinted)
            
        var request = URLRequest(url: reqUrl!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
            
        request.httpMethod = "POST"
            
        request.httpBody = reqData
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let sesson = URLSession.shared.dataTask(with: request, completionHandler: {(resData, response , error) in
                do{
                    
                    if error != nil
                    {
                        print(error.debugDescription)
                    }
                    else
                    {
                        let response = try JSONDecoder().decode(Ack.self, from: resData!)
                        self.funcStatus (response : response)
                        
                    }
                }
                catch{
                    print("Error")
                }
                
                
            })
            sesson.resume()
        }
        catch
        {
            print("error")
        }
        
        
        
        
    }
    func funcStatus( response : Ack)
    {
        if response.status! == "true"
        {
            print("Inset Successfully")
            indicator.stopAnimating()
            showalert(title: "Message", message: "Inserted successfully", handlerOk: { ACTION in self.navigationController?.popViewController(animated: true)})
            DataCache.instance.clean(byKey: "questions")
            
            
            
        }
        else
        {
            indicator.stopAnimating()
            showalert(title: "Message", message: "Data not Inserted please try again", handlerOk: { ACTION in print("not Inserted ")})
            print("Error in Insert")
        }
        
    }
    
    func updateQuestion( lid : String, qid : String , txtQ : String ,txta : String ,txtb :String , txtc :String,txtd :  String , txtAns :String , txtDiff : String , txtother :String )
    {
        
        let u = url + "question_update.php";
        
        let reqUrl = URL(string: u)
        
        let reqDict = ["cid": lid,"question":txtQ,"option_A":txta,"q_id":qid ,"option_B":txtb,"option_C":txtc,"option_D":txtd,"correct_option":txtAns,"other_detail":txtother,"level":txtDiff]
        do{
            let reqData = try JSONSerialization.data(withJSONObject: reqDict, options: .prettyPrinted)
            
            var request = URLRequest(url: reqUrl!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
            
            request.httpMethod = "POST"
            
            request.httpBody = reqData
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let sesson = URLSession.shared.dataTask(with: request, completionHandler: {(resData, response , error) in
                do{
                    
                    if error != nil
                    {
                        print(error.debugDescription)
                    }
                    else
                    {
                        let response = try JSONDecoder().decode(updateAck.self, from: resData!)
                        self.funcUpdateStatus (response : response)
                        
                        
                    }
                }
                catch{
                    print("Error")
                }
                
                
            })
            sesson.resume()
        }
        catch
        {
            print("error")
        }
        
        
        
        
    }
    func funcUpdateStatus( response : updateAck)
    {
        print (response.status!)
        
        if response.status! == "true"
        {
            indicator.stopAnimating()
            print("update Successfully")
            showalert(title: "Message", message: "Updated successfully", handlerOk: { ACTION in self.navigationController?.popViewController(animated: true)})
            DataCache.instance.clean(byKey: "questions")
            
        }
        else
        {
            indicator.stopAnimating()
            showalert(title: "Message", message: "Data not updated please try again", handlerOk: { ACTION in print("not updated ")})
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
