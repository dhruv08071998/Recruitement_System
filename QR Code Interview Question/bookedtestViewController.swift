//
//  bookedtestViewController.swift
//  QR Code Interview Question
//
//  Created by Harsh Patel on 24/01/19.
//  Copyright © 2019 Harsh Patel. All rights reserved.
//

import UIKit
import DataCache
class Bookeddetails : NSObject,NSCoding,Decodable{
    
    public var test_date: String
    public var technology: String
    public var company_name: String
    public var website_name : String
    public var address: String
    public var image: String
   
    
    public required init?(coder aDecoder: NSCoder) {
        self.test_date = aDecoder.decodeObject(forKey: "test_date") as! String
        self.technology = aDecoder.decodeObject(forKey: "technology") as! String
        self.company_name = aDecoder.decodeObject(forKey: "company_name") as! String
        self.address = aDecoder.decodeObject(forKey: "address") as! String
        self.image = aDecoder.decodeObject(forKey: "image") as! String
        self.website_name = aDecoder.decodeObject(forKey: "website_name") as! String
      
        
        
    }
    
    open func encode(with aCoder: NSCoder) {
        aCoder.encode(self.test_date, forKey: "test_date")
        aCoder.encode(self.company_name, forKey: "company_name")
        aCoder.encode(self.address, forKey: "address")
        aCoder.encode(self.image, forKey: "image")
        aCoder.encode(self.technology, forKey: "technology")
        aCoder.encode(self.website_name, forKey: "website_name")
      
        
        
    }
    
    
    
}
class bookedtestViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)

    
    var arrdata = [Bookeddetails]()
    
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
        bookingDetails(lid: Lid)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   // let u = url + "student_apply_fetch.php"
    func bookingDetails (lid : String)
    {
        var imgarr = [UIImage]()
        var status = true
        let u = url + "student_apply_fetch.php"
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
                        if((DataCache.instance.readObject(forKey: "Key4") as?[Bookeddetails])==nil)
                        {
                            self.arrdata = try JSONDecoder().decode([Bookeddetails].self, from: resData!)
                            status = true
                        }
                        else{
                            self.arrdata = DataCache.instance.readObject(forKey: "Key4") as! [Bookeddetails]
                            status = false
                        }
                        DispatchQueue.main.async(execute:{
                            if(status==true)
                            {
                                DataCache.instance.write(object: self.arrdata as NSCoding , forKey: "Key4")
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
                                DataCache.instance.write(object: imgarr as NSCoding, forKey: "myimagess")
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
        let response:[Bookeddetails] = DataCache.instance.readObject(forKey: "Key4") as! [Bookeddetails]
        self.thisimages = (DataCache.instance.readObject(forKey: "myimagess") as? [UIImage])!
        print(response.count)
        indicator.stopAnimating()
        if(self.arrdata.count == 0)
        {
           // indicator.stopAnimating()
            showalert(title: "Message", message: "No data found", handlerOk: { ACTION in print("result ferch called")})
        }
        for mainarr in 0..<(response.count) {
            self.tableview.reloadData()
            
            
        }
    }
    var thisimages = [UIImage]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return self.arrdata.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: BookedclassTableViewCell = tableView.dequeueReusableCell(withIdentifier: "newBooked ") as! BookedclassTableViewCell
        
        cell.txtcompanyName.text = arrdata[indexPath.row].company_name
        cell.txtwebsite.text = arrdata[indexPath.row].website_name
        cell.txtlocation.text = arrdata[indexPath.row].address
        cell.txttechnologyname.text = arrdata[indexPath.row].technology
        cell.txttestdate.text = arrdata[indexPath.row].test_date
       
            cell.companyimage.image =  thisimages[indexPath.row]
        
        return cell
        
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 205
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

//cell.txtcompanyName.text = arrdata[indexPath.row].company_name
//cell.txtwebsite.text = arrdata[indexPath.row].website_name
//cell.txtlocation.text = arrdata[indexPath.row].address
//cell.txttechnologyname .text = arrdata[indexPath.row].technology
//cell.txttestdate.text = arrdata[indexPath.row].test_date
//let reqUrl = URL(string: url + arrdata[indexPath.row].image)
//let data = NSData(contentsOf: reqUrl!)
//if data != nil
//{
//    cell.companyimage.image =  UIImage(data:data! as Data)
//}
//return cell
