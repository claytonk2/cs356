//
//  FeedbackViewController.swift
//  Startup_App
//
//  Created by Benjamin Walter on 7/18/18.
//  Copyright © 2018 Clayton kingsbury. All rights reserved.
//
import MessageUI
import UIKit

class FeedbackViewController: UIViewController, UITextViewDelegate, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var RoundedView: UIView!
    
    @IBOutlet weak var FeedbackTextBox: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.RoundedView.layer.cornerRadius = 15
        self.RoundedView.layer.masksToBounds = true
        
        self.hideKeyboardWhenTappedAround()
        
        FeedbackTextBox.text = "Let us know what you like or don't like, or if you have any suggestions for future additions!"
        FeedbackTextBox.textColor = UIColor.lightGray
        
        self.FeedbackTextBox.layer.borderColor = UIColor.lightGray.cgColor
        self.FeedbackTextBox.layer.borderWidth = 1
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if  textView.text == "Let us know what you like or don't like, or if you have any suggestions for future additions!" {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
   
    @IBAction func SubmitFeedback(_ sender: UIButton) {
        if FeedbackTextBox.hasText{
            message = FeedbackTextBox.text!
            self.sendEmail()
        }
        //dismiss(animated: true)
    }
    @IBAction func closeFeedback(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var message: String = ""
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["info@havenlyhealth.com"])
            mail.setMessageBody(message, isHTML: false)
            mail.setSubject("In-App Feedback")
            
            self.present(mail, animated: true)
            
            
        } else {
            // show failure alert
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        // Check the result or perform other tasks.
        
        
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
        //Put Feedback View Controller inside completion
    }
    
    @IBAction func TouchOutside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            textView.textColor = UIColor.lightGray
        }
        return true
    }
}

extension FeedbackViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FeedbackViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
