//
//  openingsfirstpageViewController.swift
//  QR Code Interview Question
//
//  Created by Harsh Patel on 30/01/19.
//  Copyright © 2019 Harsh Patel. All rights reserved.
//

import UIKit
import DataCache
class  Root : NSObject,Decodable,NSCoding{
    
    public var about_position : String
    public var applydate : String
    public var cid : String
    public var number_of_questions : String
    public var opid : String
    public var others_details : String
    public var post : String
    public var skills : String
    public var technology : String
    public var test_date : String
    public var time_of_test : String
    public var vacancy : String
    
    public required init?(coder aDecoder: NSCoder) {
        self.test_date = aDecoder.decodeObject(forKey: "test_date") as! String
        self.technology = aDecoder.decodeObject(forKey: "technology") as! String
        self.about_position = aDecoder.decodeObject(forKey: "about_position") as! String
        self.applydate = aDecoder.decodeObject(forKey: "applydate") as! String
        self.cid = aDecoder.decodeObject(forKey: "cid") as! String
        self.number_of_questions = aDecoder.decodeObject(forKey: "number_of_questions") as! String
        self.opid = aDecoder.decodeObject(forKey: "opid") as! String
        self.others_details = aDecoder.decodeObject(forKey: "others_details") as! String
        self.post = aDecoder.decodeObject(forKey: "post") as! String
        self.skills = aDecoder.decodeObject(forKey: "skills") as! String
        self.time_of_test = aDecoder.decodeObject(forKey: "time_of_test") as! String
        self.vacancy = aDecoder.decodeObject(forKey: "vacancy") as! String
    }
    
    open func encode(with aCoder: NSCoder) {
       /* public var about_position : String
        public var applydate : String
        public var cid : String
        public var number_of_questions : String
        public var opid : String
        public var others_details : String
        public var post : String
        public var skills : String
        public var technology : String
        public var test_date : String
        public var time_of_test : String
        public var vacancy : String
        */
        aCoder.encode(self.test_date, forKey: "test_date")
        aCoder.encode(self.about_position, forKey: "about_position")
        aCoder.encode(self.applydate, forKey: "applydate")
        aCoder.encode(self.cid, forKey: "cid")
        aCoder.encode(self.technology, forKey: "technology")
        aCoder.encode(self.number_of_questions, forKey: "number_of_questions")
        aCoder.encode(self.opid, forKey: "opid")
        aCoder.encode(self.others_details, forKey: "others_details")
        aCoder.encode(self.post, forKey: "post")
        aCoder.encode(self.skills, forKey: "skills")
        aCoder.encode(self.time_of_test, forKey: "time_of_test")
        aCoder.encode(self.vacancy, forKey: "vacancy")
    }
    
    
}

class openingsfirstpageViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)

    
    var Lid = UserDefaults.standard.value(forKey: "lidkey") as! String
    
    @IBOutlet weak var tableview : UITableView!
    
    var arrdata = [Root]()
    
    @IBAction func nextButton(_ sender: Any) {
        
        performSegue(withIdentifier: "throwone", sender: nil)
            
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
        
        openingfunc (lid: Lid )
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 169
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        // Do any additional setup after loading the view.
    }
    
    func openingfunc(lid : String)
    {
        
       /* let u = url + "openings_fetch.php"
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
                        self.arrdata = try JSONDecoder().decode([Root].self, from: resData!)
                   //     print(self.arrdata[0].about_position)
                        for mainarr in self.arrdata{
                            print(mainarr.technology,":",mainarr.time_of_test,":",mainarr.applydate)
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
        let u = url + "openings_fetch.php"
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
                        if((DataCache.instance.readObject(forKey: "companyKey3") as?[ResultFetch])==nil)
                        {
                            self.arrdata = try JSONDecoder().decode([Root].self, from: resData!)
                            status = true
                        }
                        else{
                            self.arrdata = DataCache.instance.readObject(forKey: "companyKey3") as! [Root]
                            status = false
                        }
                        DispatchQueue.main.async(execute:{
                            if(status==true)
                            {
                                DataCache.instance.write(object: self.arrdata as NSCoding , forKey: "companyKey3")
                                
                                
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
    func loadFunc(){
        let response:[Root] = DataCache.instance.readObject(forKey: "companyKey3") as! [Root]
       
        print(response.count)
        indicator.stopAnimating()
        if(self.arrdata.count == 0)
        {
            showalert(title: "Message", message: "No data found", handlerOk: { ACTION in print("result ferch called")})
        }
        
        for mainarr in 0..<(response.count) {
            self.tableview.reloadData()
            
            
        }
    }
    /*
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 
    }
    */
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.arrdata.count)
        return self.arrdata.count
        
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell : Cell__companyopeningTableViewCell = tableView.dequeueReusableCell(withIdentifier: "companyopening") as! Cell__companyopeningTableViewCell

        cell.txtTechnology.text = arrdata[indexPath.row].technology
         print(arrdata[indexPath.row].technology)
        cell.txtVacancy.text = arrdata[indexPath.row].vacancy
         print(arrdata[indexPath.row].vacancy)
        cell.txtTestDate.text = arrdata[indexPath.row].test_date
         print(arrdata[indexPath.row].test_date)
        cell.txtPosition.text = arrdata[indexPath.row].about_position
         print(arrdata[indexPath.row].about_position)
        cell.txtApplydate.text = arrdata[indexPath.row].applydate
         print(arrdata[indexPath.row].applydate)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail:GenerateNewOpeningViewController = self.storyboard?.instantiateViewController(withIdentifier: "throw") as! GenerateNewOpeningViewController
        detail.Technology = arrdata[indexPath.row].technology
        detail.AboutPosition = arrdata[indexPath.row].about_position
        detail.SkilRequired = arrdata[indexPath.row].skills
        detail.TotalTime = arrdata[indexPath.row].time_of_test
        detail.TestDate = arrdata[indexPath.row].test_date
        detail.ApplyDate = arrdata[indexPath.row].applydate
        detail.NumQuestion = arrdata[indexPath.row].number_of_questions
        detail.vacancy = arrdata[indexPath.row].vacancy
        detail.Post = arrdata[indexPath.row].post
        detail.opid = arrdata[indexPath.row].opid
        detail.cid = arrdata[indexPath.row].cid
        self.navigationController?.pushViewController(detail, animated: true)
        
        
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



//       let u = url + "openings_fetch.php"
//        let reqUrl = URL(string: u)
//
//        let reqDict = ["lid ": lid ]
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
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//
//
//            //SESSION
//
//
//
//
//
//            let session = URLSession.shared
//            let task = session.dataTask(with: request, completionHandler: { (resData, response, error) in
//                if (error != nil){
//                    print(error.debugDescription)
//                }else{
//                    do {
//                        self.arrdata = try JSONDecoder().decode([GetDataFromSrv].self, from: resData!)
//                        print(self.arrdata[0].about_position)
//                        for mainarr in self.arrdata{
//                            print(mainarr.technology,":",mainarr.time_of_test,":",mainarr.applydate)
//                            DispatchQueue.main.async {
//                                self.tableview.reloadData()
//                            }
//
//                        }
//                    }catch{
//                        print(exception())
//                    }
//                }
//            })
//            task.resume()
//        }
//        catch{
//
//            print(exception())
//        }
