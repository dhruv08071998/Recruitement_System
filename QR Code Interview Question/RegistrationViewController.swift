//
//  RegistrationViewController.swift
//  QR Code Interview Question
//
//  Created by Harsh Patel on 22/01/19.
//  Copyright © 2019 Harsh Patel. All rights reserved.
//

import UIKit
public struct Register: Decodable {
    
    public var lid : Int!
    public var Registration : String!
    
}
class RegistrationViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var txtContact: Specialfield!
    @IBOutlet weak var txtRoll: Specialfield!
    @IBOutlet weak var txtConPass: Specialfield!
    @IBOutlet weak var txtPassword: Specialfield!
    @IBOutlet weak var txtEmail: Specialfield!
 
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    ///////////////////////////////////////////////////////////////////////////////////////////////////picker view
    
    var rol = ["Student","Company"]
    var picker = UIPickerView()
    var currentTextField = UITextField()
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    
    // returns the # of rows in each component..
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if currentTextField == txtRoll{
            return rol.count
        }
        else
        {
            return 0
        }
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextField == txtRoll{
            return rol[row]
        }
        else
        {
            return ""
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if currentTextField == txtRoll{
            txtRoll.text = rol[row]
            self.view.endEditing(true)
        }
        
    }
    public func textFieldDidBeginEditing(_ textField: UITextField){
        self.picker.delegate = self
        self.picker.dataSource = self
        currentTextField = textField
        if currentTextField == txtRoll
        {
            currentTextField.inputView = picker
        }
        else
        {
            
        }
        
        
    }
    
    
    
    //////////////////////////////////////////////////////////////////////////////////////////////
    
    
    // to use return button in keyboard
    
  
    @IBAction func backBtn(_ sender: Any) {
        
     self.dismiss(animated: true)
        // navigationController?.popViewController(animated: true)
    }
/////////////////////////////////////////////////////////////////////////////////////////////////////////Image selection from library
    
    @IBAction func myImageBtn(_ sender: Any) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.allowsEditing = true
        myPickerController.sourceType = .photoLibrary

        self.present(myPickerController, animated: true, completion: nil)

        
       
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        myImage.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage

        self.dismiss(animated: true, completion: nil)



    }
   
    
    @IBAction func registrationBtn(_ sender: Any) {
        var flag : Bool = false
        let v = validation()
        let email = txtEmail.text!
        let password = txtPassword.text!
        let contact = txtContact.text!
        let rolename = txtRoll.text!
        let ConformPassword = txtConPass.text!
        
        if( v.isEmpty(value: email) == true)
        {
            if( v.isEmpty(value: password) == true )
            {
              if( v.isEmpty(value: ConformPassword) == true )
                {
                 if (password == ConformPassword)
                 {
                    if(v.isEmpty(value: rolename) == true)
                   {
                    if(v.isEmpty(value: contact) == true)
                    {
                      if (v.isEmailValid(value: email) == true )
                        {
                            flag = true
                           
                        }
                        else
                        {
                            flag = false
                            txtEmail.text = ""
                            txtEmail.attributedPlaceholder = NSAttributedString(string: "Please enter valid email",
                                                                                attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                        }
//                      if(v.isPasswordValid(password: password) == true)
//                      {
//                         flag  = true
//                      }
//                      else
//                      {
//                        txtPassword.text = ""
//                        txtPassword.attributedPlaceholder = NSAttributedString(string: "Please enter valid password",
//                                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
//                        txtConPass.text = ""
//                        txtConPass.attributedPlaceholder = NSAttributedString(string: "Please enter vaild conform password",
//                                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
//                      }
                      if(v.isContactNumberValid(value: contact) == true)
                      {
                         flag = true
                      }
                      else
                      {
                        txtContact.text = ""
                        txtContact.attributedPlaceholder = NSAttributedString(string: "Please enter contact number",
                                                                              attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                      }
                      if(v.isRole(value: rolename) == true )
                      {
                        flag = true
                        
                       }
                      else
                      {
                       flag = false
                       }
                      
                      ////////////////////image validation is remaining
                        
    
                    }
                    else
                    {
                        flag = false
                        txtContact.text = ""
                        txtContact.attributedPlaceholder = NSAttributedString(string: "Please enter contact number",
                                                                              attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                    }
                   }
                  else{
                    
                        flag = false
                        txtRoll.text = ""
                        txtRoll.attributedPlaceholder = NSAttributedString(string: "Please enter Student or Company",
                                                                           attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                    
                        if(v.isEmpty(value: contact) == false)
                        {
                            flag = false
                            txtContact.text = ""
                            txtContact.attributedPlaceholder = NSAttributedString(string: "Please enter contact number",
                                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                        }
                    }
                    
                }
                else
                {
                    txtPassword.text = ""
                    txtPassword.attributedPlaceholder = NSAttributedString(string: "Please Proper password",
                                                                           attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                    txtConPass.text = ""
                    txtConPass.attributedPlaceholder = NSAttributedString(string: "Please Proper Conformation password",
                                                                           attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                }
              }
                else
                {
                    flag = false
                    txtConPass.text = ""
                    txtConPass.attributedPlaceholder = NSAttributedString(string: "Please enter conform password",
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                    if(v.isEmpty(value: contact) == false)
                    {
                        flag = false
                        txtContact.text = ""
                        txtContact.attributedPlaceholder = NSAttributedString(string: "Please enter contact number",
                                                                              attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                    }
                    if(v.isEmpty(value: rolename) == false)
                    {
                        flag = false
                        txtRoll.text = ""
                        txtRoll.attributedPlaceholder = NSAttributedString(string: "Please enter Student or Company",
                                                                           attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                    }
                
                }
            }
            else
            {
                flag = false
                txtPassword.text = ""
                txtPassword.attributedPlaceholder = NSAttributedString(string: "Please enter password",
                                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                if(v.isEmpty(value: ConformPassword) == false)
                {
                    flag = false
                    txtConPass.text = ""
                    txtConPass.attributedPlaceholder = NSAttributedString(string: "Please enter conform password",
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                }
                if(v.isEmpty(value: contact) == false)
                {
                    flag = false
                    txtContact.text = ""
                    txtContact.attributedPlaceholder = NSAttributedString(string: "Please enter contact number",
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                }
                if(v.isEmpty(value: rolename) == false)
                {
                    flag = false
                    txtRoll.text = ""
                    txtRoll.attributedPlaceholder = NSAttributedString(string: "Please enter Student or Company",
                                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                }
                
            }
            
        }
        else
        {
            flag = false
            txtEmail.text = ""
            txtEmail.attributedPlaceholder = NSAttributedString(string: "Please enter email",
                                                                attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            
            if( v.isEmpty(value: password) == false )
            {
                flag = false
                txtPassword.text = ""
                txtPassword.attributedPlaceholder = NSAttributedString(string: "Please enter password",
                                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            }
            if(v.isEmpty(value: ConformPassword) == false)
            {
                flag = false
                txtConPass.text = ""
                txtConPass.attributedPlaceholder = NSAttributedString(string: "Please enter conform password",
                                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            }
            if(v.isEmpty(value: contact) == false)
            {
                flag = false
                txtContact.text = ""
                txtContact.attributedPlaceholder = NSAttributedString(string: "Please enter contact number",
                                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            }
            if(v.isEmpty(value: rolename) == false)
            {
                flag = false
                txtRoll.text = ""
                txtRoll.attributedPlaceholder = NSAttributedString(string: "Please enter Student or Company",
                                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            }
            
        }
        if ( flag == true)
        {
            print("Done")
            

            
            indicator.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            indicator.center = view.center
            let transform: CGAffineTransform = CGAffineTransform(scaleX: 2.5, y: 2.5)
            indicator.transform = transform
            // indicator.color = UIColor.black
            self.view.addSubview(indicator)
            self.view.bringSubviewToFront(indicator)
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
            
            indicator.startAnimating()
            POST_Data(contact: (txtContact).text! , roll: (txtRoll).text! , password: (txtPassword).text! , email: (txtEmail).text!)
        }
        else
        {
            print("error  data Entered")
            
        }
       
    }
    
    
   // @IBAction func imageBtn(_ sender: Any) {
        
    //}
    
    @IBOutlet weak var myImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
         hideKeyboardWhenTappedAround()
        /// to return using return button
        myImage.layer.cornerRadius = myImage.frame.height/2
         self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    
    func POST_Data(contact:String , roll:String , password:String , email:String)
        
    {
        
        //Make ADDRESS URL
        let u = url + "Registration.php";
        
        let reqUrl = URL(string: u)
        
        
        
        //GET DATA FROM TEXT FIELD AND PUT INTO DICTIONARY on KEY NAME
        
        let reqDict = ["email":email, "password":password,
                       "contact_number" : contact, "role":roll]
        
        
        
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
                        let response = try JSONDecoder().decode(Register.self, from: resData!)
                        print(response.Registration!)
                        DispatchQueue.main.async(execute:{
                            
                            
                            
                            self.pardata(response: response)
                            
                            
                            
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
    func pardata(response : Register)
    {
//        if(response.Registration! == "success")
//        {
//            performSegue(withIdentifier: "three", sender: self)
//        }
//
        let ID =  response.lid
    
    let idforupload = String(ID!)
    
    self.postImage(imageId:idforupload )
    }


///////////////////////////////////////////////////////////////////////////////////////////////////// image parsing code
    
func postImage(imageId:String){
    
    let u = url + "image_upload.php?id="
    let reqUrl = URL(string: u+imageId)
    
    
    var request = URLRequest(url: reqUrl! as URL)
    
    request.httpMethod = "POST"
    
    let boundary = "xxxxBoundaryStringxxxx"
    
    request.setValue("multipart/form-data; boundary=\(boundary)",
        
        forHTTPHeaderField: "Content-Type")
    
    if (myImage.image == nil)
        
    { return }
    
    //        let image_data = UIImagePNGRepresentation(imageofProduct.image!)
   // let image_data = UIImagePNGRepresentation(self.compressImage(myImage.image!))
    
    let image_data = self.compressImage(myImage.image!).pngData()
    let body = NSMutableData()
    
    // let fname = "porch-16.png"
    
    let fname = imageId+".png"
    //  let mimetype = "image/png"
    
    body.append("\r\n--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
    
    body.append("Content-Disposition:form-data; name=\"fileUpload\"; filename=\"\(fname)\"\r\n".data(using: String.Encoding.utf8)!)
    
    body.append("Content-Type: application/octet-stream\r\n\r\n".data(using:String.Encoding.utf8)!)
    
    body.append(image_data!)
    
    body.append("\r\n".data(using: String.Encoding.utf8)!)
    
    body.append("--\(boundary)--\r\n".data(using:String.Encoding.utf8)!)
    
    request.httpBody = body as Data
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: request as URLRequest) {
        
        (data, response, error) in
        
        guard let _:Data = data, let _:URLResponse = response , error
            
            == nil else {
                print("error")
                return
        }
        
        let resDict = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments)
        
        print(resDict);
        
        DispatchQueue.main.async(execute:{
            self.parsdata(result: resDict as! [String : Any])
            // self.parsdata(res: resDict as! [String:Any])
            
        }
            
        )
        
    }
    task.resume()
}
    
    
    func parsdata(result : [String:Any])
    {
        print(result["msg"] as? String)
        
        
        
        if result["msg"] as? String == "success"
        {
            indicator.stopAnimating()
            
            showalert(title: "Message", message: "Data inserted successfully", handlerOk: { ACTION in self.navigationController?.popToRootViewController(animated: true) })
            
            
        }
            
       
        
    }
    
 /////////////////////////////////////////////////////////////////////////////////////////////////////// To Compress Image
    

func compressImage(_ image:UIImage) -> UIImage
{
    //        var CompressImage : UIImage = image.correctlyOrientedImage()
    
    var CompressImage : UIImage = image
    var actualHeight = CompressImage.size.height
    var actualWidth = CompressImage.size.width
    let maxHeight:CGFloat
    let maxWidth:CGFloat
    maxHeight = 1080
    maxWidth =  1920
    
    var imageRetio:CGFloat = actualWidth/actualHeight
    let maxRetio:CGFloat = maxWidth/maxHeight
    print(image.imageOrientation)
    
    let compressionQuality:CGFloat = 1.0   // 0 percent compression
    if actualHeight > maxHeight || actualWidth > maxWidth
    {
        if imageRetio < maxRetio
        {
            imageRetio = maxHeight/actualHeight
            actualWidth = imageRetio * actualWidth
            actualHeight = maxHeight
        }
        else if imageRetio > maxRetio
        {
            imageRetio = maxWidth/actualWidth
            actualWidth = imageRetio * actualHeight
            actualHeight = maxWidth
            
        }
        else
        {
            actualHeight = maxHeight
            actualWidth = maxWidth
        }
        let rect = CGRect(x: 0.0, y: 0.0, width: actualWidth, height: actualHeight)
        UIGraphicsBeginImageContext(rect.size)
        CompressImage.draw(in: rect)
        if CompressImage.imageOrientation == .up
        {
            print("True")
        }
        let img = UIGraphicsGetImageFromCurrentImageContext()
       // let imageData = UIImageJPEGRepresentation(img!, compressionQuality)
      let imageData =  img?.jpegData(compressionQuality: compressionQuality)
        
        UIGraphicsEndImageContext()
        CompressImage = UIImage(data:imageData!)!
        CompressImage.imageOrientation
    }
    return CompressImage
}


}


