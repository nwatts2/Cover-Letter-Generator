//
//  UserInfoView.swift
//  Cover Letter Generator
//
//  Lays out form for entering user information
//
//  Created by Noah on 2/28/23.
//

import SwiftUI

struct UserInfoView: View {
    @EnvironmentObject var viewmodel: GeneratorViewModel
    
    @State var firstNameText: String = ""
    @State var lastNameText: String = ""
    @State var emailText: String = ""
    @State var phoneText: String = ""
    @State var cityText: String = ""
    @State var stateText: String = "CO"
    @State var zipText: String = ""
    @State var websiteText: String = ""
    @State var titleText: String = ""
    
    var states: [String] = ["None", "AL", "AK", "AS", "AZ", "AR", "CA", "CO", "CT", "DE", "DC", "FM", "FL", "GA", "GU", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MH", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "MP", "OH", "OK", "OR", "PW", "PA", "PR", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VI", "VA", "WA", "WV", "WI", "WY"]
    
    func updateUserInfo() {
        viewmodel.updateUserInfo(firstName: firstNameText, lastName: lastNameText, email: emailText, phone: phoneText, website: websiteText, city: cityText, state: stateText, zip: zipText, title: titleText, needsUpdate: true)
    }

    var body: some View {
        VStack (alignment: .leading) {
            Text("User Info")
                .font(.title)
                .underline()
            HStack {
                Text("First Name:")
                Spacer()
                TextField("Enter first name", text: $firstNameText)
                    .onAppear { firstNameText = viewmodel.firstName == "(first name)" ? "" : viewmodel.firstName }
                    .onChange(of: firstNameText) {_ in updateUserInfo()}
            }
            HStack {
                Text("Last Name:")
                Spacer()
                TextField("Enter last name", text: $lastNameText)
                    .onAppear { lastNameText = viewmodel.lastName == "(last name)" ? "" : viewmodel.lastName }
                    .onChange(of: lastNameText) {_ in updateUserInfo()}
            }
            HStack {
                Text("Title:")
                Spacer()
                TextField("Enter job title", text: $titleText)
                    .onAppear { titleText = viewmodel.title == "(job title)" ? "" : viewmodel.title }
                    .onChange(of: titleText) {_ in updateUserInfo()}

            }
            HStack {
                Text("Email:")
                Spacer()
                TextField("Enter email", text: $emailText)
                    .onAppear { emailText = viewmodel.email == "(email address)" ? "" : viewmodel.email }
                    .onChange(of: emailText) {_ in updateUserInfo()}

            }
            HStack {
                Text("Phone:")
                Spacer()
                TextField("Enter phone number", text: $phoneText)
                    .onAppear { phoneText = viewmodel.phone == "(phone number)" ? "" : viewmodel.phone }
                    .onChange(of: phoneText) {_ in updateUserInfo()}
            }
            HStack {
                Text("Website:")
                Spacer()
                TextField("Enter website", text: $websiteText)
                    .onAppear { websiteText = viewmodel.website == "(website)" ? "" : viewmodel.website }
                    .onChange(of: websiteText) {_ in updateUserInfo()}

            }
            HStack {
                Text("City:")
                Spacer()
                TextField("Enter city", text: $cityText)
                    .onAppear { cityText = viewmodel.city == "(city)" ? "" : viewmodel.city }
                    .onChange(of: cityText) {_ in updateUserInfo()}
            }
            HStack {
                Picker("State:", selection: $stateText) {
                    ForEach(states, id: \.self) { state in
                        Text(state)
                    }
                }
                .onAppear { stateText = viewmodel.state }
                .onChange(of: stateText) {_ in updateUserInfo()}

                
                Text("Zip Code:")
                Spacer()
                TextField("Enter zip", text: $zipText)
                    .onAppear { zipText = viewmodel.zip == "(zip)" ? "" : viewmodel.zip }
                    .onChange(of: zipText) {_ in updateUserInfo()}
            }
        }
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = DataController.shared.container.viewContext

        UserInfoView()
            .environmentObject(GeneratorViewModel(moc: viewContext))
    }
}
