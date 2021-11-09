//
//  NetworkManager.swift
//  Dark roasted beans
//
//  Created by Luc Daalmeijer on 06/11/2021.
//

import Foundation
import Combine

enum Endpoint: String {
    case coffees
}

class NetworkManager {
    private let urlString = "https://darkroastedbeans.coffeeit.nl/coffee-machine/60ba1ab72e35f2d9c786c610"
    
    var coffeePublisher: AnyPublisher<Coffee, Error> {
        let url = URL(string: urlString)!
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Coffee.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
