//
//  LetterInfoView.swift
//  Cover Letter Generator
//
//  Lays out form for entering letter information
//
//  Created by Noah on 2/28/23.
//

import SwiftUI

struct LetterInfoView: View {
    @EnvironmentObject var viewmodel: GeneratorViewModel
    
    @State var managerText: String = ""
    @State var positionText: String = ""
    @State var companyText: String = ""
    @State var serviceText: String = "LinkedIn"
    
    var services: [String] = ["LinkedIn", "Indeed"]
    
    func updateLetterInfo () {
        viewmodel.updateLetterInfo(manager: managerText, position: positionText, company: companyText, service: serviceText, needsUpdate: true)
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Position Info")
                .font(.title)
                .underline()
            HStack {
                Text("Position Title:")
                Spacer()
                TextField("Enter position title", text: $positionText)
                    .onAppear { positionText = viewmodel.position == "(position title)" ? "" : viewmodel.position }
                    .onChange(of: positionText) { _ in updateLetterInfo() }
            }
            HStack {
                Text("Company:")
                Spacer()
                TextField("Enter company name", text: $companyText)
                    .onAppear { companyText = viewmodel.company == "(company name)" ? "" : viewmodel.company }
                    .onChange(of: companyText) { _ in updateLetterInfo() }
            }
            HStack {
                Text("Hiring Manager:")
                Spacer()
                TextField("Enter manager name", text: $managerText)
                    .onAppear { managerText = viewmodel.manager == "(manager name)" ? "" : viewmodel.manager }
                    .onChange(of: managerText) { _ in updateLetterInfo() }
            }
            Picker("Job Service:", selection: $serviceText) {
                ForEach(services, id: \.self) { service in
                    Text(service)
                }
            }
            .onAppear { serviceText = viewmodel.service == "(job service)" ? "" : viewmodel.service }
            .onChange(of: serviceText) { _ in updateLetterInfo() }
        }
    }
}

struct LetterInfoView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = DataController.shared.container.viewContext
        
        LetterInfoView()
            .environmentObject(GeneratorViewModel(moc: viewContext))
    }
}
