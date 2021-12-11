//
//  SignInViewController.swift
//  FinalProj
//
//  Created by Nabeel Syed on 2021-12-08.
//

import UIKit
import FirebaseAuth


class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTF.becomeFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkUserInfo()
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        validateFields()
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        //                let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //                let vc = storyboard.instantiateViewController(identifier: "signUp")
        //                vc.modalPresentationStyle = .overFullScreen
        //                present(vc, animated: true)
        //                print("Sign Up Tapped")
    }
    
    func validateFields() {
        if emailTF.text?.isEmpty == true {
            print("Email empty")
            // Alert here
            let alert = UIAlertController(title: "Error!", message: "Email cannot be empty. Please try again", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        } else if passwordTF.text?.isEmpty == true {
            print("Password empty")
            // Alert here
            let alert = UIAlertController(title: "Error!", message: "Password cannot be empty. Please try again", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        login()
    }
    
    func login() {
        Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!) { [weak self] authResult, err in
            guard let strongSelf = self else { return }
            if let err = err {
                // Alert here
                let alert = UIAlertController(title: "Error!", message: "Email and/or password are incorrect, or you may not have an account. Please try again", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
                self!.present(alert, animated: true, completion: nil)
                self!.emailTF.text = ""
                self!.passwordTF.text = ""
                self!.emailTF.becomeFirstResponder()
                print(err.localizedDescription)
            } else {
                // Alert here
                let alert = UIAlertController(title: "Success!", message: "You've successfully signed up for Celestial Weather", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: { action in
                    print("close clicked")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(identifier: "weather")
                    vc.modalPresentationStyle = .overFullScreen
                    self!.present(vc, animated: true)
                }))
                self!.present(alert, animated: true, completion: nil)
                
                self!.emailTF.text = ""
                self!.passwordTF.text = ""
                self!.checkUserInfo()
            }
            
            self!.checkUserInfo()
        }
    }
    
    func checkUserInfo() {
        if Auth.auth().currentUser != nil {
            print("Current user ID: ", Auth.auth().currentUser?.uid)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "weather")
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        }
    }
}
