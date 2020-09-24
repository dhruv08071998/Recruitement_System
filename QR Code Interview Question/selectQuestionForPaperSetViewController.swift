//
//  selectQuestionForPaperSetViewController.swift
//  QR Code Interview Question
//
//  Created by Harsh Patel on 03/02/19.
//  Copyright © 2019 Harsh Patel. All rights reserved.
//

import UIKit
import DataCache
class CompanySideQuestionFetch : NSObject, NSCoding, Decodable{
    
    
    
    public var q_id : String
    public var cid : String
    public var question : String
    public var option_A : String
    public var option_B: String
    public var option_C : String
    public var option_D : String
    public var correct_option : String
    public var other_detail : String
    public var level : String
    
    public required init?(coder aDecoder: NSCoder) {
        self.q_id = aDecoder.decodeObject(forKey: "q_id") as! String
        self.cid = aDecoder.decodeObject(forKey: "cid") as! String
        self.question = aDecoder.decodeObject(forKey: "question") as! String
        self.option_A = aDecoder.decodeObject(forKey: "option_A") as! String
        self.option_B = aDecoder.decodeObject(forKey: "option_B") as! String
        self.option_C = aDecoder.decodeObject(forKey: "option_C") as! String
        
        self.option_D = aDecoder.decodeObject(forKey: "option_D") as! String
        self.correct_option = aDecoder.decodeObject(forKey: "correct_option") as! String
        self.other_detail = aDecoder.decodeObject(forKey: "other_detail") as! String
        self.level = aDecoder.decodeObject(forKey: "level") as! String
    }
    
    open func encode(with aCoder: NSCoder) {
        aCoder.encode(self.q_id, forKey: "q_id")
        aCoder.encode(self.cid, forKey: "cid")
        aCoder.encode(self.question, forKey: "question")
        aCoder.encode(self.option_A, forKey: "option_A")
        aCoder.encode(self.option_B, forKey: "option_B")
        aCoder.encode(self.option_C, forKey: "option_C")
        aCoder.encode(self.option_D, forKey: "option_D")
        aCoder.encode(self.correct_option, forKey: "correct_option")
        aCoder.encode(self.other_detail, forKey: "other_detail")
        aCoder.encode(self.level, forKey: "level")
    }
    
    
    
}

class selectQuestionForPaperSetViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
     var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.arrdata.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 168
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PaperSetQuestionFetchTableViewCell = tableView.dequeueReusableCell(withIdentifier: "QuestionFetch") as! PaperSetQuestionFetchTableViewCell
        
        cell.txtOtherDetails.text = arrdata[indexPath.row].other_detail
        cell.txtQstId.text = arrdata[indexPath.row].q_id
        cell.txtQuestion.text = arrdata[indexPath.row].question
        cell.txtDifficultylevel.text = arrdata[indexPath.row].level
        return cell
    }
    
  
    

    @IBAction func BtnBack(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var btnoutlet: roundedBtn!
    var arrdata = [CompanySideQuestionFetch]()
    
     var Lid = UserDefaults.standard.value(forKey: "lidkey") as! String
    
     var timer = Timer()
    
    
    @IBOutlet weak var txtcount: UILabel!
    @IBOutlet weak var tabelview: UITableView!
    
    @IBAction func btnDoneSelecting(_ sender: Any) {
        performSegue(withIdentifier: "generatepaper", sender: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        companySidequestionfunc(lid: Lid)
        
        
        indicator.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        indicator.center = view.center
        let transform: CGAffineTransform = CGAffineTransform(scaleX: 2.5, y: 2.5)
        indicator.transform = transform
        // indicator.color = UIColor.black
        self.view.addSubview(indicator)
        self.view.bringSubviewToFront(indicator)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        indicator.startAnimating()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }
    
    
    @objc func updateTime() {
        
        txtcount.text = String(count)
    }
    
    func companySidequestionfunc(lid : String)
    {
        var imgarr = [UIImage]()
        var status = true
        let u = url + "question_fetch.php"
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
                        if((DataCache.instance.readObject(forKey: "questions") as?[CompanySideQuestionFetch])==nil)
                        {
                            self.arrdata = try JSONDecoder().decode([CompanySideQuestionFetch].self, from: resData!)
                            status = true
                        }
                        else{
                            self.arrdata = DataCache.instance.readObject(forKey: "questions") as! [CompanySideQuestionFetch]
                            status = false
                        }
                        DispatchQueue.main.async(execute:{
                            if(status==true)
                            {
                                DataCache.instance.write(object: self.arrdata as NSCoding , forKey: "questions")
                                
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
        
        /*let u = url + "question_fetch.php"
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
                        self.arrdata = try JSONDecoder().decode([CompanySideQuestionFetch].self, from: resData!)
                        
                        for mainarr in self.arrdata{
                            // print(mainarr.technology,":",mainarr.time_of_test,":",mainarr.applydate)
                            DispatchQueue.main.async {
                                self.tabelview.reloadData()
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
    }
    
    func loadFunc(){
        let response:[CompanySideQuestionFetch] = DataCache.instance.readObject(forKey: "questions") as! [CompanySideQuestionFetch]
        
        indicator.stopAnimating()
        if(self.arrdata.count == 0)
        {
            showalert(title: "Message", message: "No data found", handlerOk: { ACTION in print("result ferch called")})
        }
        
        for mainarr in 0..<(response.count) {
            self.tabelview.reloadData()
            
            
        }
   /* func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 168
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PaperSetQuestionFetchTableViewCell = tableView.dequeueReusableCell(withIdentifier: "QuestionFetch") as! PaperSetQuestionFetchTableViewCell
        
        cell.txtOtherDetails.text = arrdata[indexPath.row].other_detail
        cell.txtQstId.text = arrdata[indexPath.row].q_id
        cell.txtQuestion.text = arrdata[indexPath.row].question
        cell.txtDifficultylevel.text = arrdata[indexPath.row].level
        return cell
    }*/
    
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    }
}
