//
//  DetailedViewController.swift
//  FinalProj
//
//  Created by MacOS on 2021-12-11.
//

import UIKit
import SwiftyJSON

class DetailedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView : UITableView!
    @IBOutlet var location : UILabel!
    @IBOutlet var curTemp : UILabel!
    @IBOutlet var weather : UILabel!
    var loc : Location = Location.init()
    var hourlyData : [Current] = [Current.init()]
    
    func setGradientBackground() {
        let hour = Calendar.current.component(.hour, from: Date())
        var colorTop = UIColor(red: 5/255.0, green: 38/255.0, blue: 83/255.0, alpha: 1.0).cgColor
        if hour >= 0 && hour < 17 {
            colorTop =  UIColor(red: 0/255.0, green: 81/255.0, blue: 202/255.0, alpha: 1.0).cgColor
        }
        let colorBottom = UIColor(red: 255.0/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hourlyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailedTableViewCell
        
        let temp = hourlyData[indexPath.row]
        
        cell.time.text = "\(temp.dt)"
        cell.temp.text = "\(temp.temp)"
        cell.img.image = UIImage.init(named: "\(temp.weather[0].icon)")
        return cell;
    }
    
    func parse (lat : String, lon : String, exclude : String, completion: @escaping (([Current]) -> Void)){
        let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=\(exclude)&appid=fcb4fbfa729f884eb0e2df29ae31aea0")!
        let session = URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard let data = data else {return}
            do{
                let json = try JSON(data: data)
                let count = json["hourly"].arrayValue
                var result : [Current] = [Current.init()]
                result.removeAll()
                for i in count{
                    var temp : Current = Current.init()
                    
                    let epochTime = TimeInterval(i["dt"].stringValue)!
                    let date = Date(timeIntervalSince1970: epochTime)
                    let df = DateFormatter()
                    df.dateFormat = "HH:mm"
                    let timeString = df.string(from: date)
                    temp.dt = timeString
                    
                    let formater = NumberFormatter()
                    formater.numberStyle = .decimal
                    formater.maximumFractionDigits = 2
                    let value = Double(i["temp"].stringValue)! - 273.15
                    temp.temp = Double(String(format: "%.2f", value))!
                    let tempWeather = Weather.init(weatherDescription: i["weather"][0]["main"].stringValue, icon: i["weather"][0]["icon"].stringValue )
                    temp.weather.removeAll()
                    temp.weather.append(tempWeather)
                    result.append(temp)
                }
                
                completion(result)
            }catch{
                print("failed")
            }
        }
        session.resume()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setGradientBackground()
        tableView.dataSource = self;
        tableView.delegate = self;
        self.navigationController?.navigationBar.tintColor = UIColor.white
        parse(lat: String(loc.lat), lon: String(loc.lon), exclude: "daily,minutely,current,alert", completion: {
            (data) in self.hourlyData = data
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        location.text = loc.name
        curTemp.text = "\(hourlyData[0].temp)"
        weather.text = hourlyData[0].weather[0].weatherDescription
        tableView.reloadData()
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
