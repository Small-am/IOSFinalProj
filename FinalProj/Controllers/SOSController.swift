//
//  SOSController.swift
//  FinalProj
//
//  Created by  on 2021-11-24.
//


import UIKit

class SOSController: UIViewController {

    

    @IBAction func sosButton(_ sender: Any) {

        if let phoneCallURL = URL(string: "tel://911") {

           let application:UIApplication = UIApplication.shared
           if (application.canOpenURL(phoneCallURL)) {
               application.open(phoneCallURL, options: [:], completionHandler: nil)
           }
         }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}
