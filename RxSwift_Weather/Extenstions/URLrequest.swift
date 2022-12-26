//
//  URLrequest.swift
//  RxSwift_Weather
//
//  Created by 최진용 on 2022/12/23.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

struct Resource<T> {
    let url: URL
}

extension URLRequest {
    static func load<T: Decodable>(resource: Resource<T>) -> Observable<T> {
        return Observable.from([resource.url])
            .flatMap { url -> Observable<Data> in
                let request  = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
            }.map { data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            }.asObservable()
    }
}
