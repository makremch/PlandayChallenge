//
//  Agent.swift
//  Challenge
//
//  Created by Makrem Hammani on 18/7/2021.
//

import Foundation
import Combine

struct Agent {
    
    
    func performRequest<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    
    
}

