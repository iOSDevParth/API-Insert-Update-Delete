

import UIKit

class uploadImageView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var mainView: UIView!

    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
                // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnLoad(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
            
        }
        print("Click")
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            
        }
        picker.dismiss(animated: true, completion: nil);
      
    }
    
    @IBAction func btnSave(_ sender: UIButton) {
      //  myImageUploadRequest()
    }
//    func myImageUploadRequest()
//    {
//        
//        let myUrl = NSURL(string: "http://www.swiftdeveloperblog.com/http-post-example-script/");
//        //let myUrl = NSURL(string: "http://www.boredwear.com/utils/postImage.php");
//        
//        let request = NSMutableURLRequest(url:myUrl! as URL);
//        request.httpMethod = "POST";
//        
//        let param = [
//            "firstName"  : "Sergey",
//            "lastName"    : "Kargopolov",
//            "userId"    : "9"
//        ]
//        
//        let boundary = generateBoundaryString()
//        
//        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//        
//        
//        let imageData = UIImageJPEGRepresentation(imageView.image!, 1)
//        
//        if(imageData==nil)  { return; }
//        
//        request.httpBody = createBodyWithParameters(parameters: param, filePathKey: "file", imageDataKey: imageData! as NSData, boundary: boundary) as Data
//        
//        
//        //myActivityIndicator.startAnimating();
//        
//        let task = URLSession.shared.dataTask(with: request as URLRequest) {
//            data, response, error in
//            
//            if error != nil {
//                print("error=\(error)")
//                return
//            }
//            
//            // You can print out response object
//            print("******* response = \(response)")
//            
//            // Print out reponse body
//            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//            print("****** response data = \(responseString!)")
//            
//            do {
//                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
//                
//                print(json)
//                
//                DispatchQueue.main.asynchronously(execute: {
//                    self.myActivityIndicator.stopAnimating()
//                    self.myImageView.image = nil;
//                });
//                
//            }catch
//            {
//                print(error)
//            }
//            
//        }
//        
//        task.resume()
//    }
//    
//    
//    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
//        let body = NSMutableData();
//        
//        if parameters != nil {
//            for (key, value) in parameters! {
//                body.appendString(string: "--\(boundary)\r\n")
//                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
//                body.appendString(string: "\(value)\r\n")
//            }
//        }
//        
//        let filename = "user-profile.jpg"
//        let mimetype = "image/jpg"
//        
//        body.appendString(string: "--\(boundary)\r\n")
//        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
//        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
//        body.append(imageDataKey as Data)
//        body.appendString(string: "\r\n")
//        
//        
//        
//        body.appendString(string: "--\(boundary)--\r\n")
//        
//        return body
//    }
//    
//    
//    
//    func generateBoundaryString() -> String {
//        return "Boundary-\(NSUUID().uuidString)"
//    }
    
    
}
//extension NSMutableData {
//    
//    func appendString(string: String) {
//        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
//        append(data!)
//    }
//}
