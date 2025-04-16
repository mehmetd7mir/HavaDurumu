//
//  WeatherManager.swift
//  HavaDurumu
//
//  Created by Mehmet  Demir on 7.04.2025.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager : WeatherManager, weather : WeatherModel)
    func didFailWithError(error : Error)
}

struct WeatherManager {
    
    let weatherURL =
    
    "https://api.openweathermap.org/data/2.5/weather?appid=48a68fb045f7f8b0e497639e913e90e1&units=metric"
    
    var delegate : WeatherManagerDelegate?
    func fetchWeather(cityName : String) {
        
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with : urlString)
        
    }
    
    func performRequest(with urlString : String) {
        //firstly create a url
        if let url = URL(string: urlString) {
            // secondly create a urlsessi
            
            let session = URLSession(configuration: .default)
            
            // give session a task
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self , weather : weather)
                    }
                }
            }
            
            // start the task
            
            task.resume()
            
        }
    }
    
    func parseJSON(_ weatherData : Data ) -> WeatherModel? {
        let decoder = JSONDecoder(
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
    
    
   
}
