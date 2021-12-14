//
//  SignUpViewController.swift
//  FinalProj
//
//  Created by Nabeel Syed on 2021-12-08.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        if emailTF.text?.isEmpty
            == true {
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
            return
        } else if passwordTF.text! != confirmPasswordTF.text! {
            print("Passwords don't match")
            passwordTF.text = ""
            confirmPasswordTF.text = ""
            passwordTF.becomeFirstResponder()
            // Alert here
            let alert = UIAlertController(title: "Error!", message: "Passwords don't match. Please try again", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        } else {
            let alert = UIAlertController(title: "Success!", message: "You've successfully signed up", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: { action in
                self.signUp()
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func signUp() {
        Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!) { (authResult, error) in
            guard let user = authResult?.user, error == nil else {
                print("Error \(error?.localizedDescription)")
                return
            }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "tabBar")
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
}
