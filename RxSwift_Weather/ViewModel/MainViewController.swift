//
//  ViewController.swift
//  RxSwift_Weather
//
//  Created by 최진용 on 2022/12/23.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var humidLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.textField.rx.value.subscribe(onNext: { city in
            if let city = city {
                if city.isEmpty {
                    self.displayWeather(nil)
                } else {
                    self.fetchWeather(by: city)
                }
            }
        }).disposed(by: disposeBag)
    }
    
    func fetchWeather(by city: String) {
        guard let cityEncoder = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed), let url = URL.getUrlForWeatherData(city: cityEncoder) else { return }
        let resource = Resource<WeatherResult>(url: url)
        URLRequest.load(resource: resource )
            .observe(on: MainScheduler.instance)
            .catchAndReturn(WeatherResult.empty)
            .subscribe { result in
                let weather = result.main
                self.displayWeather(weather)
            }
    }
    
    
    func displayWeather(_ weather: Weather?) {
        if let weather = weather {
            
                self.temperatureLabel.text = "temp : \(weather.temp)"
                self.humidLabel.text = "Humidity : \(weather.humidity)"
            
        }
        else {
            self.temperatureLabel.text = "temp : ?"
            self.humidLabel.text = "Humidity : ?"
        }
    }
    
    
    
}

