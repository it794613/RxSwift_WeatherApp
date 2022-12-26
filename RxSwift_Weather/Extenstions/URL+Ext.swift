//
//  URL+Ext.swift
//  RxSwift_Weather
//
//  Created by 최진용 on 2022/12/26.
//

import Foundation

extension URL {
    static func getUrlForWeatherData(city: String) -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=21c41e4a5832836a9f243ba0123c6f02")
    }
}
