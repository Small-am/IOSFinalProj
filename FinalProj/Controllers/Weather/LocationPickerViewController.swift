//
//  LocationPickerViewController.swift
//  FinalProj
//
//  Created by MacOS on 2021-12-11.
//

import UIKit
import FirebaseFirestore

class LocationPickerViewController: UIViewController {

    @IBOutlet var place : UITextField!
    var db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.systemBlue
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addLocation(){
        getLonLat()
    }
    
    func getLonLat(){
        let url = URL(string: "https://api.openweathermap.org/geo/1.0/direct?q="+place.text!+"&limit=1&appid=fcb4fbfa729f884eb0e2df29ae31aea0") ?? nil
        
        print(place.text!)
        if(url !=  nil){
            let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
                guard let ret = data else { return }
                let decoder = JSONDecoder()
                let temp : [Location] = try! decoder.decode([Location].self, from: ret)
                if(temp.count > 0){
                    self.sendData(name: temp[0].name, lon: String(temp[0].lon), lat: String(temp[0].lat), country: temp[0].country, state: temp[0].state)
                }
               
                }
            task.resume()
            _ = navigationController?.popToRootViewController(animated: true)
        }
        else{
            let alert = UIAlertController(title: "Error!", message: "Location Invalid!. Please try again", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func sendData(name : String, lon : String, lat : String, country : String, state : String){
        var ref : DocumentReference? = nil
        ref = db.collection("locations").addDocument(data:[
            "name" : name,
            "lon" : lon,
            "lat" : lat,
            "country" : country,
            "state" : state
        ]){
            err in
            if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
        }
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
