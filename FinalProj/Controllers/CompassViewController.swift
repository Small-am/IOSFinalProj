//
//  CompassViewController.swift
//  FinalProj
//
//  Created by Zargham Zahid on 2021-12-15.
//

import UIKit
import SwiftUI

class CompassViewController: UIViewController {
    
    @IBOutlet weak var theContainer: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let childView = UIHostingController(rootView: CompassContentView())
        addChild(childView)
        childView.view.frame = theContainer.bounds
        theContainer.addSubview(childView.view)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
