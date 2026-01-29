//
//  ItemDataProvider.swift
//  MVC_SwiftUI
//
//  Created by Rajkumar Yadav on 29/01/26.
//

import Foundation
import Combine
//https://jsonplaceholder.typicode.com/todos
class ItemDataProvider {
    func fetchItems() -> AnyPublisher<[Item], Never> {
        let url =  URL(string: "https://jsonplaceholder.typicode.com/todos")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map{ $0.data }
            .decode(type: [Item].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .eraseToAnyPublisher()
        
    }
}
