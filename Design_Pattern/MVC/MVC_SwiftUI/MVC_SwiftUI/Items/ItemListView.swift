//
//  ItemListView.swift
//  MVC_SwiftUI
//
//  Created by Rajkumar Yadav on 29/01/26.
//

import Foundation
import SwiftUI

struct ItemListView: View {
    @ObservedObject var itemListStore: ItemListStore = ItemListStore()
    var body: some View {
        NavigationView {
            ItemListDisplayView(items: itemListStore.items, onDelete: itemListStore.onDelete)
        }.onAppear() {
            itemListStore.fetchItems()
        }
    }
}


struct ItemListDisplayView: View {
    var items:[Item]
    var onDelete: (IndexSet) -> Void
    var body: some View {
        List {
            ForEach(items) { item in
                NavigationLink(destination: Text("Detail for \(item)")) {
                    ItemView(item: item)
                }
            }.onDelete(perform: onDelete)
        }
    }
}
