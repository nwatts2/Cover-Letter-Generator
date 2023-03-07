//
//  TextEditView.swift
//  Cover Letter Generator
//
//  Modal for editing the main body of text in the letter
//
//  Created by Noah on 3/2/23.
//

import SwiftUI

struct TextEditView: View {
    @EnvironmentObject var viewmodel: GeneratorViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State var tempLetter: String = ""
    @State var showingHelp: Bool = false
    
    var body: some View {
        VStack (spacing: 0) {
            Text("Edit Letter")
                .font(.title)
            ZStack {
                Colors.darkGray
                TextEditor(text: $tempLetter)
                    .font(.body)
                    .frame(height: 220)
                    .scrollContentBackground(.hidden)
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            }
            .frame(height: 250)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding()
            
            HStack {
                Button {
                    showingHelp = true
                } label: {
                    Label("Help", systemImage: "questionmark.circle")
                }
                Spacer()
                Button ("Cancel", role: .cancel, action: {presentationMode.wrappedValue.dismiss()})
                Button {
                    viewmodel.updateLetter(newText: tempLetter)
                    presentationMode.wrappedValue.dismiss()
                    
                } label: {
                    Text("Save Letter")
                }
            }
            .padding([.leading, .trailing])
        }
        .frame(width: 500, height: 350)
        .onAppear { tempLetter = viewmodel.encodedText }
        .sheet(isPresented: $showingHelp) {
            HelpView()
        }
    }
}

struct TextEditView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = DataController.shared.container.viewContext

        TextEditView().environmentObject(GeneratorViewModel(moc: viewContext))
    }
}
