

import UIKit

class homeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var arrHelp = NSMutableArray()
  
    @IBOutlet weak var txtFname: UITextField!
    @IBOutlet weak var txtLname: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var btnEditButton: UIButton!
    @IBOutlet weak var btnCancelButton: UIButton!
    @IBOutlet weak var topconstraint: NSLayoutConstraint!
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //for image load in image view
        imagePicker.delegate = self
        
        self.WBGetData()
        Cancel()

        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    //Code for Go To Library For Pick Image
    @IBAction func btnLoad(_ sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
            
        }
        print("Click")
        
    }
    
   
    //Code for Pick selected image from galary to image view
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
        } else{
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    //Get Data From API
    
    func WBGetData() -> Void {
        
        let strURL = "http://192.168.0.201/projects/louis/apparel-care/api/?action=user_profile&i_user_id=\(Global.getUserID())"
        print(strURL)
        
        AFWrapper.requestGETURL(strURL, success: {
            (JSONResponse) -> Void in
            
            if let resData = JSONResponse.dictionaryObject {
                
                let status = resData["sb_status"] as! NSNumber
                if status == 1
                {
                    let userData = resData["sb_response"] as! NSDictionary
                    let usedata = userData["user_data"] as! NSDictionary
                    
                   
                    self.txtFname.text = usedata["v_first_name"]! as? String
                    self.txtLname.text = usedata["v_last_name"]! as? String
                    self.txtEmail.text = usedata["v_email"]! as? String
                    self.txtPhone.text = usedata["v_phone"]! as? String
                    
            //Code for replace URL for get image to image view
                    let originalString = usedata["v_image"]! as? String
                    let escapedString = originalString?.replacingOccurrences(of: "//", with: "/")
                    
                    let url = NSURL(string:escapedString!)
                    let data = NSData(contentsOf:url! as URL)
                    if data != nil {
                        self.imageView.image = UIImage(data:data! as Data)
                    }
                }
                else{
                    
                    if let resData = JSONResponse.dictionaryObject {
                        let status = resData["sb_messages"] as! NSString
                        print(status as String)
                    }
                }
            }
            
        }) {
            (error) -> Void in
            print(error)
        }
        
    }

    @IBAction func btnEdit(_ sender: UIButton) {
        if btnEditButton.currentTitle == "Save" {
            WBUploadImages()
            Cancel()
        }
        else{
            Editshow()
        }
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        Cancel()
    }
    
    
    
  /*
    //Send data to API
  
    func WBEdit() -> Void {
        
        let strURL = "http://192.168.0.201/projects/louis/apparel-care/api/?action=edit_user_info&i_user_id=\(Global.getUserID())&v_first_name=\(txtFname.text!)&v_last_name=\(txtLname.text!)&v_email=\(txtEmail.text!)&v_phone=\(txtPhone.text!)&v_image=parth"
        print(strURL)
      print("aavi gyu....",Global.getUserImage())
        AFWrapper.requestGETURL(strURL, success: {
            (JSONResponse) -> Void in
            
            if let resData = JSONResponse.dictionaryObject {
                
                let status = resData["sb_status"] as! NSNumber
                if status == 1
                {
                    print(resData)
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
    
    */
    
    //code for edit details
    
    func WBUploadImages()
    {
        let url = URL(string: "http://192.168.0.201/projects/louis/apparel-care/api/?action=edit_user_info&i_user_id=\(Global.getUserID())&v_first_name=\(txtFname.text!)&v_last_name=\(txtLname.text!)&v_email=\(txtEmail.text!)&v_phone=\(txtPhone.text!)")
        print(url!)
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "POST"
        
        let boundary = generateBoundaryString()
        
        //define the multipart request type
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        if (imageView.image == nil)
        {
            return
        }
        
        let profile_image_data = UIImagePNGRepresentation(imageView.image!)
        
        let body = NSMutableData()
        
        let imagename = "\(randomStringWithLength(8)).png"
        let imagetag = "v_image"
        
        let mimetype = "image/png"
        
        //define the data post parameter
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"test1\"\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append("hi\r\n".data(using: String.Encoding.utf8)!)
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"\(imagetag)\"; filename=\"\(imagename)\"\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append(profile_image_data!)
        body.append("\r\n".data(using: String.Encoding.utf8)!)
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)

        request.httpBody = body as Data
        
        let session = URLSession.shared
        
        if Reachability.isConnectedToNetwork() {
            
            Miscellaneous.APPDELEGATE.window!.makeToastActivity(.center)
            
            let task = session.dataTask(with: request as URLRequest, completionHandler: {
                (
                data, response, error) in
                
                Miscellaneous.APPDELEGATE.window!.hideToastActivity()
                guard let _:Data = data, let _:URLResponse = response  , error == nil else {
                    print("error")
                    return
                }
                Miscellaneous.APPDELEGATE.window!.hideToastActivity()
                print("uploaded")
                let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print(dataString!)
            })
            task.resume()
        }
        else{
           self.makeToast("Sorry....",toastMessage:"No Image Found...")
        }
    }
    func generateBoundaryString() -> String
    {
        return "Boundary-\(UUID().uuidString)"
    }
    
//Generate a unique rendom name for image
    
    func randomStringWithLength (_ len : Int) -> NSString
    {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString : NSMutableString = NSMutableString(capacity: len)
        for _ in 0..<len
        {
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.character(at: Int(rand)))
        }
        return randomString
    }

//Controls For Edit Update
    func Editshow(){
        txtFname.isEnabled = true
        txtLname.isEnabled = true
        txtPhone.isEnabled = true
        txtEmail.isEnabled = true
        btnSelect.isEnabled = true
        btnCancelButton.isHidden = false
        btnEditButton.setTitle("Save",for: .normal)
        }
    
    func Cancel() {
        txtFname.isEnabled = false
        txtLname.isEnabled = false
        txtPhone.isEnabled = false
        txtEmail.isEnabled = false
        btnSelect.isEnabled = false
        btnCancelButton.isHidden = true
        btnEditButton.setTitle("Edit Profile",for: .normal)
        WBGetData()
    }
    
}

