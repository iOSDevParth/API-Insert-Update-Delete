

import UIKit
import Alamofire

class userRegstViewController: UIViewController {
var arrHelp = NSMutableArray()
    
    
    @IBOutlet weak var txtFname: UITextField!
    @IBOutlet weak var txtLname: UITextField!
    @IBOutlet weak var txtMail: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.WBGetHelp()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//Get Data From API
    
func WBGetHelp() -> Void {
        
        let strURL = "http://192.168.0.201/projects/louis/apparel-care/api/?action=user_register"
        print(strURL)
        
        AFWrapper.requestGETURL(strURL, success: {
            (JSONResponse) -> Void in
            
            if let resData = JSONResponse.dictionaryObject {
                
                let status = resData["sb_status"] as! NSNumber
                if status == 1
                {
                    print(resData)
                    if let myArray = resData["data"] as? NSArray {
                        self.arrHelp = myArray.mutableCopy() as! NSMutableArray
                        print(self.arrHelp)
                        
                        
                    }
                }
                else{
                    
                    if let resData = JSONResponse.dictionaryObject {
                        let status = resData["sb_messages"] as! NSString
                        print(status as String)
                    }
                }
            }
            
        })
        {
            (error) -> Void in
            print(error)
        }

}
    
//Send data to API
    
func WBRegst() -> Void {
        
        let strURL = "http://192.168.0.201/projects/louis/apparel-care/api/?action=user_register&v_first_name=\(txtFname.text!)&v_last_name=\(txtLname.text!)&v_email=\(txtMail.text!)&v_password=\(txtPass.text!)&v_phone=\(txtPhone.text!)"
        print(strURL)
        
        AFWrapper.requestGETURL(strURL, success: {
            (JSONResponse) -> Void in
            
            if let resData = JSONResponse.dictionaryObject {
                
                let status = resData["sb_status"] as! NSNumber
                if status == 1
                {
                    print(resData)
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "loginViewController") as? loginViewController
                    self.navigationController!.pushViewController(vc!, animated: true)

                }
                else{
                    
                    if let resData = JSONResponse.dictionaryObject {
                        let status = resData["sb_messages"] as! NSString
                        self.makeToast("Sorry....",toastMessage: status as String)
                        print(status)
                    }
                }
            }
            
        }) {
            (error) -> Void in
            print(error)
        }
        
    }

    @IBAction func btnRegister(_ sender: UIButton) {
        self.view.endEditing(true)
            self.WBRegst()
        clear()
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        clear()
    }
    
    func clear(){
        txtFname.text = ""
        txtLname.text = ""
        txtPhone.text = ""
        txtPass.text = ""
        txtMail.text = ""
    }
    
}
