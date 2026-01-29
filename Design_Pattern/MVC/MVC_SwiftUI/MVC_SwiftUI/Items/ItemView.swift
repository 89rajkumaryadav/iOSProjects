//
//  ItemView.swift
//  MVC_SwiftUI
//
//  Created by Rajkumar Yadav on 29/01/26.
//

import Foundation
import SwiftUI

struct ItemView: View {
    var item: Item
    var body: some View {
        Text(item.title)
    }
}
