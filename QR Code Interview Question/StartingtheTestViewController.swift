

import UIKit

public struct Questions : Decodable {
    
    
    public var correct_option : String!
    public var level : String!
    public var option_A : String!
    public var option_B : String!
    public var option_C : String!
    public var option_D : String!
    public var other_detail : String!
    public var question : String!
    
    
    
}

public struct decription : Decodable {
    
    public var msg: String!
    
}

class StartingtheTestViewController: UIViewController {
    
    @IBOutlet weak var startBtnOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startBtnOutlet.isEnabled = false
        self.decode()
        
        Qr_count = UserDefaults.standard.value(forKey: "Qr_count") as? Bool ?? false
        // Do any additional setup after loading the view.
    }
    
    var Lid = ""
    var i = 0
    var Encoded :String = ""
    var Cid  = ""
    var Set_id = ""
    var Set_name = ""
    var arrdata = [Questions]()
    var question : [String] = []
    var option_A : [String] = []
    var option_B : [String] = []
    var option_C : [String] = []
    var option_D : [String] = []
    var correst_option : [String] = []
    var flag : [Bool] = []
    var ans : [String] = []
    var optAns : [String] = []
    var count = 0
    var myurl = UserDefaults.standard.value(forKey: "urlkey") as! String
    var Totaltime = 300
    var i_count = 0
    var Qr_count : Bool!
    
    
    @IBAction func BtnBack(_ sender: Any) {
        //navigationController?.popViewController(animated: true)
        self.dismiss(animated: true)
    }
    
    @IBAction func BtnStart(_ sender: Any) {
        
        
        performSegue(withIdentifier: "ConformTest", sender: nil)
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let maintest = segue.destination as! MainTestViewController
        maintest.test_question = question
        maintest.test_option_A = option_A
        maintest.test_option_B = option_B
        maintest.test_option_C = option_C
        maintest.test_option_D = option_D
        maintest.test_correst_option = correst_option
        maintest.test_flag = flag
        maintest.test_ans = ans
        maintest.test_optAns = optAns
        maintest.totalTime = Totaltime
        print(Totaltime)
        maintest.i = i_count
        
    }
    
    
    func decode()
    {
        self.decriptionFunc()
       
    }
    
    
    func decriptionFunc()
    {
       
        let u = self.myurl + "sha512.php";
        
        let reqUrl = URL(string: u )
        
        
        
        
        //GET DATA FROM TEXT FIELD AND PUT INTO DICTIONARY on KEY NAME
        
        let reqDict = ["action":"decrypt","string":self.Encoded]
        
        
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
                        var response = try JSONDecoder().decode(decription.self, from: resData!)
                        print(response.msg!)
                        DispatchQueue.main.async(execute:{
                            
                            
                            
                            self.getdecryptedData(response: response)
                            
                            
                            
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
    
    func getdecryptedData(response:decription){
        let  str  = response.msg!
        print(str)
        
        let ids = str.characters.split(separator: "#").map(String.init)
        self.Cid = String(ids[0])
        print(self.Cid)
       // UserDefaults.standard.set(self.Cid, forKey: "CidKey")
        self.Set_id = String(ids[1])
        print(self.Set_id)
        //UserDefaults.standard.set(self.Set_id, forKey: "SetidKey")
        self.Set_name = String(ids[2])
        print(self.Set_name)
        //UserDefaults.standard.set(self.Set_name, forKey: "setNameKey")
        print (":::::::",UserDefaults.standard.value(forKey: "SetidKey") as? String)
        if (UserDefaults.standard.value(forKey: "SetidKey") as? String == nil || self.Set_id != UserDefaults.standard.value(forKey: "SetidKey") as? String  )
        {
            Qr_count = false
        }
        else
        {
            Qr_count = true
        }
        
        if(self.Cid == "master" && self.Set_id == "master"  && self.Set_name == "master")
        {
            //UserDefaults.standard.value(forKey: "urlkey") as! String
            UserDefaults.standard.removeObject(forKey: "Qr_count")
            Qr_count = false
            UserDefaults.standard.set(Qr_count, forKey: "Qr_count")
            
            self.question = UserDefaults.standard.value(forKey: "key_question") as? [String] ?? []
            self.option_A = UserDefaults.standard.value(forKey: "key_option_A") as? [String] ?? []
            self.option_B = UserDefaults.standard.value(forKey: "key_option_B") as? [String] ?? []
            self.option_C = UserDefaults.standard.value(forKey: "key_option_C") as? [String] ?? []
            self.option_D = UserDefaults.standard.value(forKey: "key_option_D") as? [String] ?? []
            self.flag = UserDefaults.standard.value(forKey: "key_flag") as? [Bool] ?? []
            self.ans = UserDefaults.standard.value(forKey: "key_ans") as? [String] ?? []
            self.optAns = UserDefaults.standard.value(forKey: "key_optAns") as? [String] ?? []
            self.correst_option = UserDefaults.standard.value(forKey: "key_correct_option") as? [String] ?? []
            self.Totaltime =  UserDefaults.standard.value(forKey: "totalTime") as? Int ?? 300
            print("Timer in this class", self.Totaltime)
            self.i_count = UserDefaults.standard.value(forKey: "i_count") as? Int ?? 0
            print(self.i_count)
            
            
            
            if(self.question.count != 0)
            {
              startBtnOutlet.isEnabled = true
              //performSegue(withIdentifier: "ConformTest", sender: nil)
            }
            else
            {
                let button2Alert: UIAlertView = UIAlertView(title: "Message", message: "Data not found",
                                                            delegate: self as? UIAlertViewDelegate, cancelButtonTitle: "OK")
                button2Alert.show()
            }

        }
        else
        {
            if ( Qr_count == false)
            {
                UserDefaults.standard.removeObject(forKey: "Qr_count")
                Qr_count = true
                UserDefaults.standard.set(Qr_count, forKey: "Qr_count")
                UserDefaults.standard.set(self.Cid, forKey: "CidKey")
                UserDefaults.standard.set(self.Set_id, forKey: "SetidKey")
                UserDefaults.standard.set(self.Set_name, forKey: "setNameKey")
                self.getQuestions(cid: Cid, setid: Set_id, setname: Set_name)
            }
            else
            {
                let button2Alert: UIAlertView = UIAlertView(title: "Message", message: "This is used Qr code, Please scane the new one",
                                                            delegate: self as? UIAlertViewDelegate, cancelButtonTitle: "OK")
                button2Alert.show()
                
            }
        }

    }
    
    
    
    func getQuestions(cid:String, setid :String , setname:String)
    {
        //Make ADDRESS URL
        
        let u = self.myurl + "test_questions_fetch.php";
        print ( "this is cid :", self.Cid )
        print ( "this is Set_id :", self.Set_id )
        print ( "this is set_name :", self.Set_name )
        
        let reqUrl = URL(string:  u )
        //GET DATA FROM TEXT FIELD AND PUT INTO DICTIONARY on KEY NAME
        let reqDict = ["cid":cid , "set_id":setid , "set_name" : setname]
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
                        self.arrdata = try JSONDecoder().decode([Questions].self, from: resData!)
                        //s print(self.arrdata[0].option_A!)
                        DispatchQueue.main.async(execute:{
                            self.parsedata(response: self.arrdata)
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
    
    func parsedata(response : [Questions])
    {
        print(response.count)
        var i = 0
        while(i<response.count)
        {
            question.append(response[i].question!)
            option_A.append(response[i].option_A!)
           // print(option_A[i])
            option_B.append(response[i].option_B!)
           // print(option_B[i])
            option_C.append(response[i].option_C!)
           // print(option_C[i])
            option_D.append(response[i].option_D!)
           // print(option_D[i])
            flag.append(false)
            ans.append("")
            optAns.append("")
            correst_option.append(response[i].correct_option!)
            i = i + 1
            
        }
        if (i == response.count)
        {
            print("Count of the question::::::::::::::::")
            print(question.count)
            startBtnOutlet.isEnabled = true
        }
    }
    
    
    
    
}


