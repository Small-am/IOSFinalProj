//
//  ClockController.swift
//  FinalProj
//
//  Created by  on 2021-11-24.
//

import UIKit


class ClockController: UIViewController {

    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var timeZoneLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    let months:[String] = ["January", "February", "March", "April" , "May", "June", "July", "August", "September", "October", "November", "December"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
            let date = Date()
            
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "hh:mm:ss a"
            
            let currentTime = dateformatter.string(from: date)
            
            dateformatter.dateFormat = "dd/MM/yyyy"
            
            let calendar = Calendar.current
            let month = calendar.component(.month, from: date)
            let day = calendar.component(.day, from: date)
            let monthInWords = self.months[month - 1]
                        
            let dayString = String(day)
                        
                        
            let year = calendar.component(.year, from: date)
                        
            let currentDate = "\(dayString) \(monthInWords), \(year)"
            
            
            let timeZoneformattor = DateFormatter()
            timeZoneformattor.dateFormat = "zzzz"
            
            let currentTimeZone = timeZoneformattor.string(from: date)
            
            
            self.timeZoneLabel.text = currentTimeZone
            self.dateLabel.text = currentDate
            self.timeLabel.text = currentTime
            
        }
    }

}
