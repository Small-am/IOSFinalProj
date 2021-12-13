//
//  SOSController.swift
//  FinalProj
//
//  Created by  on 2021-11-24.
//


import UIKit

class SOSController: UIViewController {

    

    @IBAction func sosButton(_ sender: Any) {
        let formattedNumber = phoneNumberVariable.components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined(separator: "")

        if let url = NSURL(string: ("tel:" + (formattedNumber)!)) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url as URL)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}
