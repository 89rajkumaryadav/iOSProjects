//
//  ItemListStore.swift
//  MVC_SwiftUI
//
//  Created by Rajkumar Yadav on 29/01/26.
//

import Foundation
import Combine

final class ItemListStore: ObservableObject {
    @Published var items: [Item] = []
    let dataProvider: ItemDataProvider = ItemDataProvider()
    var cancellables = Set<AnyCancellable>()
    
    init() {
        
    }
    
    func fetchItems() {
        dataProvider.fetchItems()
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                                    case .failure(let error):
                                        // Handle your error here (e.g., show an alert)
                                        print("Fetch failed: \(error)")
                                    case .finished:
                                        break // Stream finished successfully
                                    }
                },
                receiveValue: { [weak self] items in
                self?.items = items;
                }).store(in: &cancellables)
    }
    
    func onDelete(index:IndexSet) {
        items.remove(atOffsets: index)
    }
}
