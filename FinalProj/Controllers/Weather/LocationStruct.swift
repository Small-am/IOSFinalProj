//
//  LocationStruct.swift
//  FinalProj
//
//  Created by MacOS on 2021-12-11.
//

import Foundation
public struct Location : Decodable{
    var country : String
    var lat : Double
    var lon : Double
    var name : String
    var state : String
    var temp : Double?
    
    public init(){
        country = ""
        lat = 0
        lon = 0
        name = ""
        state = ""
    }
}

struct Current: Codable {
    var dt : String
    var temp : Double
    var weather: [Weather]
    
    public init(){
        dt = ""
        temp = 20
        weather = [Weather.init(weatherDescription: "", icon: "")]
    
    }
}
struct Weather: Codable {
    let weatherDescription, icon: String
}

