//
//  Generator.swift
//  Cover Letter Generator
//
//  Primary model for application
//
//  Created by Noah on 2/28/23.
//

import Foundation

class Generator: ObservableObject {
    // Defines individual variables for all user information
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var phone: String = ""
    @Published var website: String = ""
    @Published var city: String = ""
    @Published var state: String = "None"
    @Published var zip: String = ""
    @Published var title: String = ""
    
    @Published var manager: String = ""
    @Published var position: String = ""
    @Published var service: String = "LinkedIn"
    @Published var company: String = ""
        
    @Published var encodedText: String = ""
    @Published var letterColor: String = "Blue"
    @Published var template: String = "Template 1"
    
    // Returns decoded body of letter
    var text: String {
        get {
            return self.decodeText(encodedText)
        }
    }
    
    // Inserts variables into user entered letter text
    func decodeText(_ newText: String) -> String {
        
        // Splits letter text into array of strings, separated by *{
        let filtered = newText.components(separatedBy: "*{")
        var finalString = filtered[0]
        
        // Determines name of variable in separated string
        for sub in filtered {
            var property = ""
            var remainder = ""
            
            // Separates variable name from rest of text
            for index in 0..<sub.count {
                let subIndex = sub.index(sub.startIndex, offsetBy: index)
                
                if String(sub[subIndex]) != "}" {
                    property += String(sub[subIndex])
                } else {
                    remainder = String(sub[sub.index(after: subIndex)...])
                    break
                }
            }
            
            // Determines which variable to insert into text
            switch property {
            case "name":
                finalString += "\(self.firstName) \(self.lastName)"
            case "firstName":
                finalString += self.firstName
            case "lastName":
                finalString += self.lastName
            case "email":
                finalString += self.email
            case "phone":
                finalString += self.phone
            case "website":
                finalString += self.website
            case "city":
                finalString += self.city
            case "state":
                finalString += self.state
            case "zip":
                finalString += self.zip
            case "manager":
                finalString += self.manager
            case "position":
                finalString += self.position
            case "service":
                finalString += self.service
            case "company":
                finalString += self.company
            default:
                break
            }
            
            finalString += remainder
        }
        
        return finalString
    }
}
