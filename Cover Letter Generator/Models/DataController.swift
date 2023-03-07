//
//  DataController.swift
//  Cover Letter Generator
//
//  Defines data controller for saving/loading through CoreData
//
//  Created by Noah on 3/3/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Generator")
    static let shared = DataController()
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
