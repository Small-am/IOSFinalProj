//
//  WeatherController.swift
//  FinalProj
//
//  Created by  on 2021-11-24.
//

import UIKit
import FirebaseFirestore
import SwiftyJSON

class WeatherController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView : UITableView!
    var db = Firestore.firestore()
    var datas : [Location] = []
    var currentData : [Current] = []
    var choose = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeatherTableViewCell
        
        let temp = datas[indexPath.row]
        cell.temp.text = "\(currentData[indexPath.row].temp)"
        cell.city.text = temp.name
        cell.location.text = temp.country+" "+temp.state
        cell.img.image = UIImage.init(named: "\(currentData[indexPath.row].weather[0].icon)") ?? UIImage.init(named: "01d")
        cell.btn.tag = indexPath.row
        return cell;
    }
        
    func update(){
        self.datas = []
        getData(){(data) in
            if let data = data{
                for document in data.documents {
                    var temp : Location = Location.init()
                    temp.country = document.get("country")! as! String
                    temp.lon = Double(document.get("lon") as! String) ?? 0
                    temp.lat = Double(document.get("lat") as! String) ?? 0
                    temp.name = document.get("name")! as! String
                    temp.state = document.get("state")! as! String
                    self.datas.append(temp)
                    self.currentData.append(Current.init())
                    self.getTemp()
                }
            }
            else{
                return
            }
            self.tableView.reloadData()
        }
    }
    
    
    @IBAction func getTemp(){
        var count = 0
        for i in datas{
            parse(lat: String(i.lat), lon: String(i.lon), exclude: "daily,minutely,hourly", completion: {
                (data) in
                self.currentData[count].temp = data.temp
                self.currentData[count].weather = data.weather
                count += 1
            })
        }
        self.tableView.reloadData()
    }
    
    func parse (lat : String, lon : String, exclude : String, completion: @escaping ((Current) -> Void)){
        let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=\(exclude)&appid=fcb4fbfa729f884eb0e2df29ae31aea0")!
        let session = URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard let data = data else {return}
            do{
                let json = try JSON(data: data)
                var temp : Current = Current.init()
                let formater = NumberFormatter()
                formater.numberStyle = .decimal
                formater.maximumFractionDigits = 2
                let value = Double(json["current"]["temp"].stringValue)! - 273.15
                temp.temp = Double(String(format: "%.2f", value))!
                let tempWeather = Weather.init(weatherDescription: json["current"]["weather"][0]["main"].stringValue, icon: json["current"]["weather"][0]["icon"].stringValue )
                temp.weather.removeAll()
                temp.weather.append(tempWeather)
                completion(temp)
            }catch{
                print("failed")
            }
        }
        session.resume()
    }
    
    func getData(_ completion: @escaping (_ data: QuerySnapshot?) -> Void ) {
        let userRef = Firestore.firestore().collection("locations")

        userRef.getDocuments { (documents, error) in
            guard let documents = documents else {
                print("document does not exist")
                completion(nil)
                return
            }
            completion(documents)
        }
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self;
        self.tableView.rowHeight = 222;
        tableView.delegate = self;
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        update()
    }
    
    @IBAction func send(sender: UIButton){
        choose = sender.tag
        self.performSegue(withIdentifier: "DetailedView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender : Any?){
        guard let targetVC = segue.destination as? DetailedViewController else {return}
        targetVC.loc = datas[choose]
    }

}
