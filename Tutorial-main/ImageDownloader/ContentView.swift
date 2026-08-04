//
//  ContentView.swift
//  SwiftConcurrency
//
//  Created by Rajkumar Yadav on 31/07/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack{
                NavigationLink("What is the best way of download large number of images and save it locally in iOS swift") {
                    ImageDownloadView()
                }
                
                NavigationLink("What is the best way of download large number of images and save it locally in iOS swift") {
                    ImageDownloadView()
                }
               
            }
        }
    }
}

#Preview {
    ContentView()
}
