//
//  Cover_Letter_GeneratorApp.swift
//  Cover Letter Generator
//
//  Primary container for application
//
//  Created by Noah on 2/28/23.
//

import SwiftUI

@main
struct Cover_Letter_GeneratorApp: App {
    
    let windowWidth = 1050.0
    let windowHeight = 650.0
    
    var body: some Scene {
        WindowGroup {
            let viewContext = DataController.shared.container.viewContext
            
            MainView(viewmodel: GeneratorViewModel(moc: viewContext))
                .frame(minWidth:windowWidth, idealWidth:windowWidth, maxWidth: windowWidth, minHeight: windowHeight, idealHeight: windowHeight, maxHeight: windowHeight, alignment: .center)
                .environment(\.managedObjectContext, viewContext)
        }
        .windowResizability(.contentSize)
    }
}
