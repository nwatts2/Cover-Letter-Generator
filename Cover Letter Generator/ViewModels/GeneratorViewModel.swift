//
//  GeneratorViewModel.swift
//  Cover Letter Generator
//
//  Primary ViewModel for application
//  Handles interacting with model and saving/loading data
//
//  Created by Noah on 2/28/23.
//

import Foundation
import SwiftUI

class GeneratorViewModel: NSObject, ObservableObject {
    // Defines managed object contect, fetched results array, and fetched results controller for saving/loading data with CoreData
    private (set) var moc: NSManagedObjectContext
    private var userInfoArray: [UserInfo] = []
    
    private let fetchedResultsController: NSFetchedResultsController<UserInfo>

    // Initializes model
    @ObservedObject var generator = Generator()
    
    // Computed Variables for accessing user information from the model
    var firstName: String { return generator.firstName }
    var lastName: String { return generator.lastName }
    
    var name: String { return "\(firstName) \(lastName)"}
    
    var email: String { return generator.email }
    var phone: String { return generator.phone }
    var website: String { return generator.website }
    var city: String { return generator.city }
    var state: String { return generator.state }
    var zip: String { return generator.zip }
    var title: String { return generator.title }
    
    var manager: String { return generator.manager }
    var position: String { return generator.position }
    var company: String { return generator.company }
    var service: String { return generator.service }
    
    var letterColor: String { return generator.letterColor }
    var template: String { return generator.template }
    
    @Published var showDate: Bool = true
    
    var text: String { return generator.text }
    var encodedText: String { return generator.encodedText }
    
    // On initialization, define managed object context and use it to set up fetchedResultsController, which fetches all UserInfo data and calls the loadData() function
    init(moc: NSManagedObjectContext) {
        self.moc = moc
        fetchedResultsController = NSFetchedResultsController(fetchRequest: UserInfo.all, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        super.init()
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
            guard let infoArray = fetchedResultsController.fetchedObjects else {
                return
            }
            
            self.userInfoArray = infoArray
        } catch {
            print(error)
        }
        
        loadData()
    }
    
    // Updates all user information with passed in arguments
    func updateUserInfo(firstName: String, lastName: String, email: String, phone: String, website: String, city: String, state: String, zip: String, title: String, needsUpdate: Bool) {
        generator.firstName = firstName == "" ? "(first name)" : firstName
        
        generator.lastName = lastName == "" ? "(last name)" : lastName
        
        generator.email = email == "" ? "(email address)" : email
        
        generator.phone = phone == "" ? "(phone number)" : phone
        
        generator.website = website == "" ? "(website)" : website
        
        generator.city = city == "" ? "(city)" : city
        
        generator.state = state == "" ? "(state)" : state
        
        generator.zip = zip == "" ? "(zip)" : zip
        
        generator.title = title == "" ? "(job title)" : title
                
        if needsUpdate { updateView() }
    }
    
    // Updates all letter information with passed in arguments
    func updateLetterInfo(manager: String, position: String, company: String, service: String, needsUpdate: Bool) {
        generator.manager = manager == "" ? "(manager name)" : manager
        
        generator.position = position == "" ? "(position title)" : position
        
        generator.company = company == "" ? "(company name)" : company
        
        generator.service = service == "" ? "(job service)" : service
        
        if needsUpdate { updateView() }
    }
    
    // Updates letter color scheme with passed in argument
    func updateColor(_ letterColor: String, needsUpdate: Bool) {
        generator.letterColor = letterColor
        
        if needsUpdate { updateView() }
    }
    
    // Updates letter template with passed in argument
    func updateTemplate(_ template: String, needsUpdate: Bool) {
        generator.template = template
        
        if needsUpdate { updateView() }
    }
    
    // Updates encoded letter text with passed in argument
    func updateLetter(newText: String) {
        generator.encodedText = newText

        updateView()
    }
    
    // Forces the main view to update, and determines whether to save a new entry to database or to overwrite existing entry
    func updateView() {
        if userInfoArray.count == 0 {
            saveData(UserInfo(context: moc))

        } else if userInfoArray.count == 1 {
            if let userInfo = try? moc.existingObject(with: userInfoArray[0].objectID) as? UserInfo {
                saveData(userInfo)
                
            }
        }
        
        self.objectWillChange.send()
    }
    
    // Loads data from userInfoArray into predefined variables
    func loadData() {
        if userInfoArray.count == 1 {
            let userInfo = userInfoArray[0]
            
            updateUserInfo(
                firstName: userInfo.firstName ?? "Unknown",
                lastName: userInfo.lastName ?? "Unknown",
                email: userInfo.email ?? "Unknown",
                phone: userInfo.phone ?? "Unknown",
                website: userInfo.website ?? "Unknown",
                city: userInfo.city ?? "Unknown",
                state: userInfo.state ?? "Unknown",
                zip: userInfo.zip ?? "Unknown",
                title: userInfo.title ?? "Unknown",
                needsUpdate: false
            )
            
            updateLetterInfo(
                manager: userInfo.manager ?? "Unknown",
                position: userInfo.position ?? "Unknown",
                company: userInfo.company ?? "Unknown",
                service: userInfo.service ?? "Unknown",
                needsUpdate: false
            )
            
            updateColor(userInfo.letterColor ?? "Blue", needsUpdate: false)
            updateTemplate(userInfo.template ?? "Template 1", needsUpdate: false)
            
            showDate = userInfo.showDate
            generator.encodedText = userInfo.encodedText ?? "Unknown"
            
        } else {
            print("No data to load")
        }
    }
    
    // Saves data from predefined variables to managed object context
    func saveData(_ userInfo: UserInfo) {
    
        if firstName != "" { userInfo.firstName = firstName }
        if lastName != "" { userInfo.lastName = lastName }
        if email != "" { userInfo.email = email }
        if phone != "" { userInfo.phone = phone }
        if website != "" { userInfo.website = website }
        if city != "" { userInfo.city = city }
        if state != "" { userInfo.state = state }
        if zip != "" { userInfo.zip = zip }
        if title != "" { userInfo.title = title }
        
        if manager != "" { userInfo.manager = manager }
        if position != "" { userInfo.position = position }
        if service != "" { userInfo.service = service }
        if company != "" { userInfo.company = company }
        
        if encodedText != "" { userInfo.encodedText = encodedText }
        if letterColor != "" { userInfo.letterColor = letterColor }
        if template != "" { userInfo.template = template }
        
        userInfo.showDate = showDate
        
        try? moc.save()
    }
    
    // Runs a save panel, and returns the selected pathway as a URL
    func showSavePanel() -> URL? {
        let savePanel = NSSavePanel()
        savePanel.allowedContentTypes = [.pdf]
        savePanel.canCreateDirectories = true
        savePanel.isExtensionHidden = false
        savePanel.allowsOtherFileTypes = false
        savePanel.title = "Save your Cover Letter"
        savePanel.message = "Choose a folder and a name to save your cover letter."
        savePanel.nameFieldLabel = "File name:"
        savePanel.nameFieldStringValue = "\(name) \(company) Cover Letter"
        
        let response = savePanel.runModal()
        
        return response == .OK ? savePanel.url : nil
    }
    
    // Exports a PDF to the passed in URL argument depending on selected template
    func exportPDF(url: URL) {
        let templateRenderer1 = ImageRenderer(content: Template1View().environmentObject(self))
        let templateRenderer2 = ImageRenderer(content: Template2View().environmentObject(self))
        let templateRenderer3 = ImageRenderer(content: Template3View().environmentObject(self))

        if template == "Template 1" {
            templateRenderer1.render {size, context in
                var box = CGRect(origin: .zero, size: size)
                
                guard let consumer = CGDataConsumer(url: url as CFURL), let pdf = CGContext(consumer: consumer, mediaBox: &box, nil) else { return }
                
                pdf.beginPDFPage(nil)
                
                context(pdf)
                
                pdf.endPDFPage()
                pdf.closePDF()
            }
            
        } else if template == "Template 2" {
            templateRenderer2.render {size, context in
                var box = CGRect(x: 0, y: 0, width: size.width, height: size.height)
                
                guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil) else { return }
                
                pdf.beginPDFPage(nil)
                
                context(pdf)
                
                pdf.endPDFPage()
                pdf.closePDF()
            }
            
        } else if template == "Template 3" {
            templateRenderer3.render {size, context in
                var box = CGRect(x: 0, y: 0, width: size.width, height: size.height)
                
                guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil) else { return }
                
                pdf.beginPDFPage(nil)
                
                context(pdf)
                
                pdf.endPDFPage()
                pdf.closePDF()
            }
            
        }
        
        return
    }

}

// Extends ViewModel to update userInfoArray when fetchedResultsController changes
extension GeneratorViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let userInfoArray = controller.fetchedObjects as? [UserInfo] else {
            return
        }
        
        self.userInfoArray = userInfoArray
    }
}

// Extends UserInfo (defined in data model) to define a fetch request
extension UserInfo {
    static var all: NSFetchRequest<UserInfo> {
        let request = UserInfo.fetchRequest()
        request.sortDescriptors = []
        return request
    }
}
