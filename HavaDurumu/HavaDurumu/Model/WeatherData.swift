//
//  WeatherData.swift
//  HavaDurumu
//
//  Created by Mehmet  Demir on 7.04.2025.
//

import Foundation

struct WeatherData : Codable {
    let name : String
    let main : Main
    let weather : [Weather]
        
}

struct Main : Codable {
    let temp : Double
}

struct Weather : Codable {
    let id : Int
}
