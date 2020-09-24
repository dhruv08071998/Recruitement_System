//
//  setPapersetViewController.swift
//  QR Code Interview Question
//
//  Created by Harsh Patel on 28/01/19.
//  Copyright © 2019 Harsh Patel. All rights reserved.
//

import UIKit
import DataCache
class PaperSetFetch : NSObject, NSCoding,Decodable
{
 
    public var qr_code_image : String
    public var set_id : String
    public var set_name : String
    public var technology : String
    
    public required init?(coder aDecoder: NSCoder) {
        self.qr_code_image = aDecoder.decodeObject(forKey: "qr_code_image") as! String
        self.technology = aDecoder.decodeObject(forKey: "technology") as! String
        self.set_id = aDecoder.decodeObject(forKey: "set_id") as! String
        self.set_name = aDecoder.decodeObject(forKey: "set_name") as! String
        
        
    }
    
    open func encode(with aCoder: NSCoder) {
        aCoder.encode(self.qr_code_image, forKey: "qr_code_image")
        aCoder.encode(self.set_id, forKey: "set_id")
        aCoder.encode(self.set_name, forKey: "set_name")
        aCoder.encode(self.technology, forKey: "technology")
        
        
    }
    

}

class setPapersetViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    @IBOutlet weak var tabelview: UITableView!
     var Lid = UserDefaults.standard.value(forKey: "lidkey") as! String
      var arrdata = [PaperSetFetch]()
    
    @IBAction func newBtn(_ sender: Any) {
        
        performSegue(withIdentifier: "oneOne", sender: nil)
        
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
        paperfunc(lid: Lid)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
    func loadFunc(){
        let response:[PaperSetFetch] = DataCache.instance.readObject(forKey: "papersetfetch_Key") as! [PaperSetFetch]
        self.thisimages = (DataCache.instance.readObject(forKey: "qr_code_image") as? [UIImage])!
        print(response.count)
        indicator.stopAnimating()
        if(self.arrdata.count == 0)
        {
            showalert(title: "Message", message: "No data found", handlerOk: { ACTION in print("result ferch called")})
        }
        for mainarr in 0..<(response.count) {
            self.tabelview.reloadData()
            
            
        }
    }
   
    var thisimages = [UIImage]()
    
    func paperfunc(lid : String)
    {
        
       
        
        var imgarr = [UIImage]()
        var status = true
        let u = url + "paper_set&qr_fetch.php"
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
                        if((DataCache.instance.readObject(forKey: "papersetfetch_Key") as?[PaperSetFetch])==nil)
                        {
                            self.arrdata = try JSONDecoder().decode([PaperSetFetch].self, from: resData!)
                            status = true
                        }
                        else{
                            self.arrdata = DataCache.instance.readObject(forKey: "papersetfetch_Key") as! [PaperSetFetch]
                            status = false
                        }
                        DispatchQueue.main.async(execute:{
                            if(status==true)
                            {
                                DataCache.instance.write(object: self.arrdata as NSCoding , forKey: "papersetfetch_Key")
                                let total_data=self.arrdata.count
                                for i in  0..<(total_data)
                                {
                                    print(self.arrdata[i].qr_code_image)
                                    let reqUrl = URL(string: url + self.arrdata[i].qr_code_image)
                                    let data = NSData(contentsOf: reqUrl!)
                                    if data != nil
                                    {
                                        let image =  UIImage(data:data as! Data)
                                        imgarr.append(image!)
                                    }
                                    
                                    
                                    
                                    
                                    
                                    
                                }
                                DataCache.instance.write(object: imgarr as NSCoding, forKey: "qr_code_image")
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
        
        let cell : PaperSetFetchTableViewCell = tableView.dequeueReusableCell(withIdentifier: "paperFetch") as! PaperSetFetchTableViewCell
        
        cell.txtTechnology.text = arrdata[indexPath.row].technology
        cell.txtSetid.text = arrdata[indexPath.row].set_id
        cell.txtSetName.text = arrdata[indexPath.row].set_name
        //let reqUrl = URL(string: url + arrdata[indexPath.row].qr_code_image)
        //let data = NSData(contentsOf: reqUrl!)
        //if data != nil
        //{
           cell.QrImage.image =  thisimages[indexPath.row]
       // }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail: FetchInfoFromPaperSetViewController = self.storyboard?.instantiateViewController(withIdentifier: "fetch") as! FetchInfoFromPaperSetViewController
        
        detail.technology = arrdata[indexPath.row].technology
        detail.setno = arrdata[indexPath.row].set_id
        detail.setname = arrdata[indexPath.row].set_name
        detail.QrImage = thisimages[indexPath.row]
       
        self.navigationController?.pushViewController(detail, animated: true)
        
        
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
