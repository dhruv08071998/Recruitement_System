//
//  resultsViewController.swift
//  QR Code Interview Question
//
//  Created by Harsh Patel on 24/01/19.
//  Copyright © 2019 Harsh Patel. All rights reserved.
//

import UIKit
import DataCache
class ResultFetch : NSObject,Decodable,NSCoding
{
    
    public var test_date : String
    public var technology: String
    public var company_name : String
    public var address : String
    public var website_name : String
    public var image : String
    public var score : String
    
    public required init?(coder aDecoder: NSCoder) {
        self.test_date = aDecoder.decodeObject(forKey: "test_date") as! String
        self.technology = aDecoder.decodeObject(forKey: "technology") as! String
        self.company_name = aDecoder.decodeObject(forKey: "company_name") as! String
        self.address = aDecoder.decodeObject(forKey: "address") as! String
        self.image = aDecoder.decodeObject(forKey: "image") as! String
        self.website_name = aDecoder.decodeObject(forKey: "website_name") as! String
        
        self.score = aDecoder.decodeObject(forKey: "score") as! String
        
    }
    
    open func encode(with aCoder: NSCoder) {
        aCoder.encode(self.test_date, forKey: "test_date")
        aCoder.encode(self.company_name, forKey: "company_name")
        aCoder.encode(self.address, forKey: "address")
        aCoder.encode(self.image, forKey: "image")
        aCoder.encode(self.technology, forKey: "technology")
        aCoder.encode(self.website_name, forKey: "website_name")
        aCoder.encode(self.score, forKey: "score")
        
    }
    
    

}


class resultsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 208
    }
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)

    var arrdata = [ResultFetch]()
    
    let Lid = UserDefaults.standard.value(forKey: "lidkey") as! String

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
         no=0
         resultfunc(lid: Lid)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func loadFunc(){
        let response:[ResultFetch] = DataCache.instance.readObject(forKey: "Key3") as! [ResultFetch]
        self.thisimages = (DataCache.instance.readObject(forKey: "myimages") as? [UIImage])!
        print(response.count)
        print("=====")
        indicator.stopAnimating()
        if(self.arrdata.count == 0)
        {
            
            showalert(title: "Message", message: "No data found", handlerOk: { ACTION in print("result ferch called")})
        }
        for mainarr in 0..<(response.count) {
                self.tabelview.reloadData()
            
            
        }
    }
   var no = 0
    @IBOutlet weak var tabelview: UITableView!
    var thisimages = [UIImage]()
    func resultfunc(lid : String)
    {
        var imgarr = [UIImage]()
        var status = true
        let u = url + "student_side_resultshow.php"
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
                        if((DataCache.instance.readObject(forKey: "Key3") as?[ResultFetch])==nil)
                        {
                        self.arrdata = try JSONDecoder().decode([ResultFetch].self, from: resData!)
                            status = true
                        }
                        else{
                           self.arrdata = DataCache.instance.readObject(forKey: "Key3") as! [ResultFetch]
                            status = false
                        }
                        DispatchQueue.main.async(execute:{
                            if(status==true)
                            {
                            DataCache.instance.write(object: self.arrdata as NSCoding , forKey: "Key3")
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
                                  DataCache.instance.write(object: imgarr as NSCoding, forKey: "myimages")
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
        print(":::")
        print(self.arrdata.count)
        return self.arrdata.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : StudentSideResultTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SecondTablecell") as!  StudentSideResultTableViewCell
        
                cell.txtTechnology.text = arrdata[indexPath.row].technology
                cell.txtResult.text = arrdata[indexPath.row].score
                cell.txtWebsite.text = arrdata[indexPath.row].website_name
                cell.txtCompanyName.text = arrdata[indexPath.row].company_name
                cell.txtTestDate.text = arrdata[indexPath.row].test_date
                var abc = arrdata[indexPath.row].address
                print(abc)
        
                    cell.CompanyImage.image = self.thisimages[indexPath.row]
        
        return cell
    }
    
}
//
//if(self.arrdata.count == 0)
//{
//    indicator.stopAnimating()
//    showalert(title: "Message", message: "No data found", handlerOk: { ACTION in print("result ferch called")})
//}
//
