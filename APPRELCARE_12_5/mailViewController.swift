

    import Foundation
    import UIKit
    import MessageUI
    
    class mailViewController: UIViewController, MFMailComposeViewControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
        
        @IBOutlet weak var subject: UITextField!
    
        @IBOutlet weak var body: UITextView!
        @IBOutlet weak var btnSend: UIButton!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            subject.delegate = self
            body.delegate = self
        }
        @IBAction func sendMail(sender: AnyObject) {
            let picker = MFMailComposeViewController()
            picker.mailComposeDelegate = self
            picker.setSubject(subject.text!)
            picker.setMessageBody(body.text, isHTML: true)
            
            present(picker, animated: true, completion: nil)
        }
        
        // MFMailComposeViewControllerDelegate
        
        // 1
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            dismiss(animated: true, completion: nil)
        }
        
        // UITextFieldDelegate
        
        // 2
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            
            return true
        }
        
        // UITextViewDelegate
        
        // 3
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            body.text = textView.text
            
            if text == "\n" {
                textView.resignFirstResponder()
                
                return false
            }
            
            return true
        }
}
