////
////  generateQRcodeViewController.swift
////  QR Code Interview Question
////
////  Created by Harsh Patel on 28/01/19.
////  Copyright © 2019 Harsh Patel. All rights reserved.
////
//
//
//
//import UIKit
//import DataCache
//public struct AckFile : Decodable
//{
//    public var status : String!
//    public var qrid : Int!
//    public var set_id : String!
//
//}
//public struct rootClass: Decodable {
//
//    public var Insertion : String!
//
//}
//
//class generateQRcodeViewController: UIViewController ,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate{
//
//
//    var img:UIImage!
//    var finalImage : UIImage!
//    var Data : String = ""
//    var Cid = UserDefaults.standard.value(forKey: "lidkey") as! String// global company lid
//    var Set_id = ""
//    var Set_name = ""
//    var Qr_id = ""
//    var strBase64=""
//    var internalStatus : Bool  = false
//    @IBOutlet weak var myQrCode: UIImageView!
//    @IBOutlet weak var txtSetName: Specialfield!
//    @IBOutlet weak var txtTechnology: Specialfield!
//    @IBAction func BtnBack(_ sender: Any) {
//        navigationController?.popViewController(animated: true)
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//
//    let tech = ["Web Development","ios App Deveopment","Android Development","Software Development","All"]
//    var picker = UIPickerView()
//    var currentTextField = UITextField()
//
//
//    public func numberOfComponents(in pickerView: UIPickerView) -> Int
//    {
//        return 1
//    }
//
//
//    // returns the # of rows in each component..
//
//    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
//    {
//        if currentTextField == txtTechnology {
//            return tech.count
//        }
//        else
//        {
//            return 0
//        }
//
//
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        if currentTextField == txtTechnology{
//            return tech[row]
//        }
//        else
//        {
//            return ""
//        }
//
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//
//        if currentTextField == txtTechnology{
//            txtTechnology.text = tech[row]
//            self.view.endEditing(true)
//        }
//
//    }
//    public func textFieldDidBeginEditing(_ textField: UITextField){
//        self.picker.delegate = self as UIPickerViewDelegate
//        self.picker.dataSource = self as UIPickerViewDataSource
//        currentTextField = textField
//        if currentTextField == txtTechnology
//        {
//            currentTextField.inputView = picker
//        }
//        else
//        {
//
//        }
//
//
//    }
//
//    @IBAction func BtnGenerateQr(_ sender: Any) {
//
//
//        if txtSetName.text! == "" && txtTechnology.text! == ""
//        {
//            print ("error")
//            // allert part
//
//        }
//        else
//        {
//            Set_name = txtSetName.text!
//
//            UploadData(cid: Cid , set_name: txtSetName.text! , technology: txtTechnology.text! , array: arr)
//
//        }
//
//    }
//
//
//    func encode()
//    {
//
//      /////  Encode to send to Qr code
//        if Set_id != "" && Set_name != ""
//        {
//            let str = Cid+"#"+Set_id+"#"+Set_name
//
//            Data = str.toBase64()
//
//            //////////generate and assign Qr Code to the image view
//
//            let  myString  = Data
//            let data = myString.data(using: .ascii , allowLossyConversion : false )
//            let  filter = CIFilter(name: "CIQRCodeGenerator")
//            filter?.setValue( data, forKey: "InputMessage")
//            let ciImage = filter?.outputImage
//            let transform = CGAffineTransform(scaleX: 10, y: 10)
//            let transformimage = ciImage?.transformed(by: transform)
//            let ximage = UIImage( ciImage: transformimage!)
//            myQrCode.image = ximage
//            internalStatus = true// Update internal Status
//            finalImage = myQrCode.image!
//            UIGraphicsBeginImageContextWithOptions(myQrCode.frame.size, false, 1)
//            myQrCode.layer.render(in: UIGraphicsGetCurrentContext()!)
//            let image = UIGraphicsGetImageFromCurrentImageContext()
//            let imageData = image!.pngData()
//            print(imageData!)
//            strBase64 = imageData!.base64EncodedString(options: .lineLength64Characters)
//            print(strBase64)
//        }
//        else
//        {
//            print ("error in getting data")
//        }
//
//
//    }
//
//
//
//    func UploadData(cid:String , set_name:String , technology:String , array: [String])
//
//    {
//
//        //Make ADDRESS URL
//        let u = url + "paper_set&qr_insert.php";
//        let reqUrl = URL(string: u)
//    //GET DATA FROM TEXT FIELD AND PUT INTO DICTIONARY on KEY NAME
//        let reqDict = ["cid":cid,"set_name":set_name,"technology":technology,"q_id": array ] as [String : Any]
//        do {
//            //DICTIONARY  FORMATE CONVERT JSON FORMATE WITH JSONSERIALIZABLE
//            let reqData = try JSONSerialization.data(withJSONObject: reqDict, options: .prettyPrinted)
//            //FOR URL REQUEST
//            var request = URLRequest(url: reqUrl!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
//            //REQUEST HTTP METHOD
//            request.httpMethod = "POST"
//            //REQUEST DATA HTTPBODY JSON
//            request.httpBody = reqData
//            //REQUEST SETVALUE
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            let session = URLSession.shared
//            let task = session.dataTask(with: request, completionHandler: { (resData, response, error) in
//                if (error != nil){
//                    print(error.debugDescription)
//                }else{
//                    do {
//                        let response = try JSONDecoder().decode(AckFile.self, from: resData!)
//                        //print(response.Registration!)
//                        DispatchQueue.main.async(execute:{
//                            self.setinqrtable(response: response)
//                        }
//                        )
//                    }catch{
//                        print(exception())
//                    }
//                }
//            })
//            task.resume()
//        }
//
//        catch{
//
//            print(exception())
//
//        }
//
//
//
//    }
//    func setinqrtable(response : AckFile)
//    {
//       if response.status! == "true"
//       {
//            Set_id  = response.set_id!
//            Qr_id   = String(response.qrid!)
//            print("Successfully Added Set_id And Qr_id")
//
//            self.encode()
//
//            }
//    }
//
//
//    @IBAction func BtnDone(_ sender: Any) {
//    //    navigationController?.popToViewController(setPapersetViewController() as! UIViewController, animated: true)
//
//        if internalStatus == true
//        {
//            self.inserttoQRImage(imageId: Qr_id)
//        }
//        else
//        {
//            print("Error in generating Qr Code")
//        }
//
//
//
//
//    }
//
//
//
//    func inserttoQRImage(imageId:String){
//
//        let u = url + "qr_upload.php"
//        let reqUrl = URL(string: u)
//
//
//
//        //GET DATA FROM TEXT FIELD AND PUT INTO DICTIONARY on KEY NAME
//
//        let reqDict = ["qr_id":imageId,"image":strBase64]
//
//
//
//        do {
//
//
//
//            //DICTIONARY  FORMATE CONVERT JSON FORMATE WITH JSONSERIALIZABLE
//
//            let reqData = try JSONSerialization.data(withJSONObject: reqDict, options: .prettyPrinted)
//
//
//
//            //FOR URL REQUEST
//
//            var request = URLRequest(url: reqUrl!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
//
//
//
//            //REQUEST HTTP METHOD
//
//            request.httpMethod = "POST"
//
//
//
//            //REQUEST DATA HTTPBODY JSON
//
//            request.httpBody = reqData
//
//
//
//            //REQUEST SETVALUE
//
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//
//
//            //SESSION
//
//            let session = URLSession.shared
//
//
//
//            let task = session.dataTask(with: request, completionHandler: { (resData, response, error) in
//
//                if (error != nil){
//                    print(error.debugDescription)
//
//                }else{
//
//                    do {
//                        var response = try JSONDecoder().decode(rootClass.self, from: resData!)
//                        print(response.Insertion)
//                        DispatchQueue.main.async(execute:{
//
//
//
//                            self.mydata(response: response)
//
//
//
//                        }
//                        )
//
//
//
//
//                    }catch{
//                        print(exception())
//                    }
//                }
//            })
//            task.resume()
//        }
//
//        catch{
//
//            print(exception())
//
//        }
//    }
//
//    func mydata(response : rootClass)
//    {
//
//        if response.Insertion == "success"
//        {
//            //let logoutstd = self.storyboard?.instantiateViewController(withIdentifier: "logout")
//            DataCache.instance.clean(byKey: "papersetfetch_Key")
//            DataCache.instance.clean(byKey: "qr_code_image")
//            let logoutstd = self.storyboard?.instantiateViewController(withIdentifier: "identifierone")
//            self.navigationController?.pushViewController(logoutstd!, animated: true)
//
//        }
//
//    }
//
//
//}
//
//extension String
//{
//
//
//
//        func toBase64() -> String
//        {
//                        return Data(self.utf8).base64EncodedString()
//        }
//
//}
//
//



import UIKit
import DataCache
public struct AckFile : Decodable
{
    public var status : String!
    public var qrid : Int!
    public var set_id : String!
    
}
public struct rootClass: Decodable {
    
    public var Insertion : String!
    
}

public struct encryption : Decodable {
    
    public var msg: String!
    
}

class generateQRcodeViewController: UIViewController ,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate{
    
    
    var img:UIImage!
    var finalImage : UIImage!
    var Data : String = ""
    var Cid = UserDefaults.standard.value(forKey: "lidkey") as! String// global company lid
    var Set_id = ""
    var Set_name = ""
    var Qr_id = ""
    var strBase64=""
    var internalStatus : Bool  = false
    @IBOutlet weak var myQrCode: UIImageView!
    @IBOutlet weak var txtSetName: Specialfield!
    @IBOutlet weak var txtTechnology: Specialfield!
    @IBAction func BtnBack(_ sender: Any) {
//        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
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
        self.picker.delegate = self as UIPickerViewDelegate
        self.picker.dataSource = self as UIPickerViewDataSource
        currentTextField = textField
        if currentTextField == txtTechnology
        {
            currentTextField.inputView = picker
        }
        else
        {
            
        }
        
        
    }
    
    @IBAction func BtnGenerateQr(_ sender: Any) {
        
        
        if txtSetName.text! == "" && txtTechnology.text! == ""
        {
            print ("error")
            // allert part
            
        }
        else
        {
            Set_name = txtSetName.text!
            
            UploadData(cid: Cid , set_name: txtSetName.text! , technology: txtTechnology.text! , array: arr)
            
        }
        
    }
    
    
    func encode()
    {
        
        /////  Encode to send to Qr code
        if Set_id != "" && Set_name != ""
        {
            let str = Cid+"#"+Set_id+"#"+Set_name
            
           // let str = "master#master#master"
            
            
            print (str)
            
            self.Data = str
            
            
            self.encryptFunc()
            
            
        }
        else
        {
            print ("error in getting data")
        }
        
        
    }
    
    
    
    func UploadData(cid:String , set_name:String , technology:String , array: [String])
        
    {
        
        //Make ADDRESS URL
        let u = url + "paper_set&qr_insert.php";
        let reqUrl = URL(string: u)
        //GET DATA FROM TEXT FIELD AND PUT INTO DICTIONARY on KEY NAME
        let reqDict = ["cid":cid,"set_name":set_name,"technology":technology,"q_id": array ] as [String : Any]
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
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { (resData, response, error) in
                if (error != nil){
                    print(error.debugDescription)
                }else{
                    do {
                        let response = try JSONDecoder().decode(AckFile.self, from: resData!)
                        //print(response.Registration!)
                        DispatchQueue.main.async(execute:{
                            self.setinqrtable(response: response)
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
    func setinqrtable(response : AckFile)
    {
        if response.status! == "true"
        {
            Set_id  = response.set_id!
            Qr_id   = String(response.qrid!)
            print("Successfully Added Set_id And Qr_id")
            
            self.encode()
            
        }
    }
    
    
    @IBAction func BtnDone(_ sender: Any) {
        //    navigationController?.popToViewController(setPapersetViewController() as! UIViewController, animated: true)
        
        if internalStatus == true
        {
            self.inserttoQRImage(imageId: Qr_id)
        }
        else
        {
            print("Error in generating Qr Code")
        }
        
        
        
        
    }
    
    
    
    func inserttoQRImage(imageId:String){
        
        let u = url + "qr_upload.php"
        let reqUrl = URL(string: u)
        
        
        
        //GET DATA FROM TEXT FIELD AND PUT INTO DICTIONARY on KEY NAME
        
        let reqDict = ["qr_id":imageId,"image":strBase64]
        
        
        
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
                        var response = try JSONDecoder().decode(rootClass.self, from: resData!)
                        print(response.Insertion)
                        DispatchQueue.main.async(execute:{
                            
                            
                            
                            self.mydata(response: response)
                            
                            
                            
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
    
    func mydata(response : rootClass)
    {
        
        if response.Insertion == "success"
        {
            DataCache.instance.clean(byKey: "papersetfetch_Key")
            DataCache.instance.clean(byKey: "qr_code_image")
            let logoutstd = self.storyboard?.instantiateViewController(withIdentifier: "identifierone")
            self.navigationController?.pushViewController(logoutstd!, animated: true)

        }
        
    }
    
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    
    
    func encryptFunc()
    {
        
        
        indicator.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        indicator.center = view.center
        let transform: CGAffineTransform = CGAffineTransform(scaleX: 2.5, y: 2.5)
        indicator.transform = transform
        // indicator.color = UIColor.black
        self.view.addSubview(indicator)
        self.view.bringSubviewToFront(indicator)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        indicator.startAnimating()
        //Make ADDRESS URL
        let u = url + "sha512.php";
        
        let reqUrl = URL(string: u )
        
        
        
        
        //GET DATA FROM TEXT FIELD AND PUT INTO DICTIONARY on KEY NAME
        
        let reqDict = ["action":"encrypt","string":self.Data]
        //for decryption  let reqDict = ["action":"decrypt","string":"UEZUYXpDMTY5ODVtTnRBS3p3R3dBZz09"]
        
        
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
                        var response = try JSONDecoder().decode(encryption.self, from: resData!)
                        print(response.msg!)
                        DispatchQueue.main.async(execute:{
                            
                            
                            
                            self.getencryptedData(response: response)
                            
                            
                            
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
    
    func getencryptedData(response:encryption){
        let  myString  = response.msg!
        let data = myString.data(using: .ascii , allowLossyConversion : false )
        let  filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue( data, forKey: "InputMessage")
        let ciImage = filter?.outputImage
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let transformimage = ciImage?.transformed(by: transform)
        let ximage = UIImage( ciImage: transformimage!)
        myQrCode.image = ximage
        internalStatus = true// Update internal Status
        finalImage = myQrCode.image!
        UIGraphicsBeginImageContextWithOptions(myQrCode.frame.size, false, 1)
        myQrCode.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        let imageData = image!.pngData()
        print(imageData!)
        strBase64 = imageData!.base64EncodedString(options: .lineLength64Characters)
        indicator.stopAnimating()
        print(strBase64)
    }
    
    
    
}
