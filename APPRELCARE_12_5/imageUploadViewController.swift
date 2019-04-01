

import UIKit

class imageUploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var isProfilePic:Bool = Bool()
        
    
        @IBOutlet weak var imgProfile: UIImageView!
        @IBOutlet weak var btnSubmit: UIButton!
    
        var isProfileImageSet = false
        var isIDImageSet = false
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.setUpUI()
        }
        
        func setUpUI() -> Void
        {
            
            imgProfile.layer.cornerRadius = 50.0
            imgProfile.layer.masksToBounds = true
            
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            
        }
        
        @IBAction func btnProfileClicked(_ sender: AnyObject)
        {
            isProfilePic = true
            let ImagePicker = UIImagePickerController()
            ImagePicker.delegate = self
            ImagePicker.allowsEditing = true
            ImagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            self.present(ImagePicker, animated: true, completion: nil)
        }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            if isProfilePic {
                
                if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                    
                    imgProfile?.image = pickedImage
                    isProfileImageSet = true
                }
            }

            self.dismiss(animated: true, completion: nil)
        }
        //MARK:- setLanguage
    
        func WBUploadImages()
        {
            let strURL = "http://192.168.0.201/projects/louis/apparel-care/api/?action=upload_images"
            
            let url = URL(string: "\(strURL)&i_user_id=\(Global.getUserID())&v_image=body")
            
            let request = NSMutableURLRequest(url: url!)
            request.httpMethod = "POST"
            
            let boundary = generateBoundaryString()
            
            //define the multipart request type
            
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            if (imgProfile.image == nil)
            {
                return
            }
            
          
            let profile_image_data = UIImagePNGRepresentation(imgProfile.image!)
            
            
            if(profile_image_data == nil)
            {
                return
            }
         
            
            let body = NSMutableData()
            
            let image1name = "\(randomStringWithLength(8)).png"
            
            let image1tag = "v_image"
            
            let mimetype = "image/png"
            
            //define the data post parameter
            
            body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
            body.append("Content-Disposition:form-data; name=\"test1\"\r\n\r\n".data(using: String.Encoding.utf8)!)
            body.append("hi\r\n".data(using: String.Encoding.utf8)!)
            body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
            body.append("Content-Disposition:form-data; name=\"\(image1tag)\"; filename=\"\(image1name)\"\r\n".data(using: String.Encoding.utf8)!)
            body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
            body.append(profile_image_data!)
            body.append("\r\n".data(using: String.Encoding.utf8)!)
            
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
                    
                    //let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    //print(dataString)
                    let goToLogin = self.storyboard?.instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
                    self.navigationController?.pushViewController(goToLogin, animated: true)
                })
                task.resume()
            }
            else{
                print("Please_check_your_internet_connection_and_try_again")
            }
        }
        func generateBoundaryString() -> String
        {
            return "Boundary-\(UUID().uuidString)"
        }
    
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
        
        @IBAction func btnSubmitClicked(_ sender: AnyObject) {
            
          
                self.WBUploadImages()
          
        }
        
}

