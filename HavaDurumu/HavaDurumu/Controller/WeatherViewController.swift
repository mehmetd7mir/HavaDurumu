//
//  ViewController.swift
//  HavaDurumu
//
//  Created by Mehmet  Demir on 5.04.2025.
//
import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        searchTextField.delegate = self
    }
}

// MARK: - UITextFieldDelegate

    extension WeatherViewController : UITextFieldDelegate{
        
        @IBAction func searchPressed(_ sender: UIButton) {
            searchTextField.endEditing(true)
            print(searchTextField.text!)
        }
        
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            searchTextField.endEditing(true)
            print(searchTextField.text!)
            return true
        }
        
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            if textField.text != "" {
                return true
            } else {
                textField.placeholder = "Type something"
                return false
            }
        }
        func textFieldDidEndEditing(_ textField: UITextField) {
            
            if let cityName = textField.text {
                weatherManager.fetchWeather(cityName: cityName)
            }
            searchTextField.text = ""
        }
        
    }
    
// MARK: WeatherManagerDelegate

extension WeatherViewController : WeatherManagerDelegate {
   
    func didUpdateWeather(_ weatherManager : WeatherManager, weather : WeatherModel){
        DispatchQueue.main.async{
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

