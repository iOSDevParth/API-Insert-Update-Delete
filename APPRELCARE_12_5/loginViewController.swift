

import UIKit

class loginViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPass: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Send data to API
    
    func WBLogin() -> Void {
        
        let strURL = "http://192.168.0.201/projects/louis/apparel-care/api/?action=user_login&v_email=\(txtEmail.text!)&v_password=\(txtPass.text!)&v_device_token=parth"
        print(strURL)
        
        AFWrapper.requestGETURL(strURL, success: {
            (JSONResponse) -> Void in
            
            if let resData = JSONResponse.dictionaryObject {
                
                let status = resData["sb_status"] as! NSNumber
                if status == 1
                {
                    print(resData)
                    
                    let userData = resData["sb_response"] as! NSDictionary
                    let usedata = userData["data"] as! NSDictionary
                    print("data=====",usedata["user_id"]! as! String)
                    Global.setUserID(setUserID: usedata["user_id"]! as! String)
                    if let resData = JSONResponse.dictionaryObject {
                        let status = resData["sb_messages"] as! NSString
                        self.makeToast("Sorry....",toastMessage: status as String)
                        print(status)
                    }
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "homeViewController") as? homeViewController
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

    
    
    @IBAction func btnLogin(_ sender: UIButton) {
        self.view.endEditing(true)
        self.WBLogin()
    }

}
