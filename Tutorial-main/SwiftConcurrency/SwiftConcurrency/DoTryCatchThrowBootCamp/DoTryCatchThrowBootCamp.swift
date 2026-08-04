//
//  DoTryCatchThrowBootCamp.swift
//  SwiftConcurrency
//
//  Created by Rajkumar Yadav on 04/08/26.
//https://www.youtube.com/watch?v=ss50RX7F7nE&list=PLwvDm4Vfkdphr2Dl4sY4rS9PLzPdyi8PM&index=2

import Foundation
import SwiftUI
import Combine

struct DoTryCatchThrowBootCamp: View {
     @ObservedObject private var vm = DoTryCatchThrowBootCampViewModel()
    var body: some View {
        Text(vm.text)
            .onTapGesture {
                // vm.fetchTitle()
               // vm.fetchTitle2()
                vm.fetchFinalTitle()
            }
    }
}


class DoTryCatchThrowsDataManager {
    var isActive = true
    func getTitle() -> (title: String?, error: Error?){
        if isActive {
            return ("New Text", nil)
        }else{
            return (nil, URLError(.badURL))
        }
    }
    
    func getTitle2() -> Result<String, Error> {
        if isActive {
            return Result.success("New Text2!")
        }else{
            return Result.failure(URLError(.appTransportSecurityRequiresSecureConnection))
        }
    }
    
    func getTitle3() throws -> String {
        
        if isActive {
            return "New Text3!"
        }else{
            throw URLError(.appTransportSecurityRequiresSecureConnection)
        }
    }
    
    func getTitle4() throws -> String {
        
        if isActive {
            return "New Text4!"
        }else{
            throw URLError(.backgroundSessionInUseByAnotherProcess)
        }
    }
    
}


class DoTryCatchThrowBootCampViewModel: ObservableObject {

   @Published var text: String = "Starting text."
    let manager = DoTryCatchThrowsDataManager()
    
    func fetchTitle(){
        let newTitle = manager.getTitle()
        if let title = newTitle.title{
            
            text = title
        }else{
            text = newTitle.error?.localizedDescription ?? "Failed to fetch title."
        }
    }
    
    func fetchTitle2(){
        let result = manager.getTitle2()
        switch result {
        case .success(let text):
            self.text = text
        case .failure(let error):
            self.text = error.localizedDescription
        
        }
    }
    
    func fetchTitle3() {
        do{
            let newTitle = try manager.getTitle3()
            text = newTitle
        }catch let error{
            text = error.localizedDescription
        }
    }
    
    func fetchFinalTitle(){
        do{
            let newTitle = try? manager.getTitle3()
            if let title = newTitle{
                text = title
            }
            
            let finalTitle = try manager.getTitle4()
            text = finalTitle
            
        }catch let error{
            text = error.localizedDescription
        }
    }
    
}





