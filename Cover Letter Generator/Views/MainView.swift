//
//  ContentView.swift
//  Cover Letter Generator
//
//  Lays out the main view for the application
//
//  Created by Noah on 2/28/23.
//

import SwiftUI

struct MainView: View {
    @Environment(\.managedObjectContext) var moc
    var screenResChanged = NotificationCenter.default.publisher(for: NSApplication.didChangeScreenParametersNotification)

    @ObservedObject var viewmodel: GeneratorViewModel
    
    @State var showingTextEdit: Bool = false
    
    var colors = ["Red", "Orange", "Green", "Teal", "Blue", "Purple"]
    @State var colorText = "Blue"
    
    var templates = ["Template 1", "Template 2", "Template 3"]
    @State var templateText = "Template 1"
    
    init(viewmodel: GeneratorViewModel) {
        self.viewmodel = viewmodel
    }
            
    var body: some View {
        HStack {
            VStack {
                ZStack {
                    Rectangle()
                        .stroke(Colors.white, lineWidth: 5)
                    Text("Cover Letter Generator")
                        .font(.largeTitle)
                        .bold()
                }
                .frame(height: 50)
                
                Spacer()
                UserInfoView()
                Spacer()
                Divider()
                Spacer()
                LetterInfoView()
                Spacer()
                HStack {
                    Button {
                        showingTextEdit = true
                    } label: {
                        Text("Edit Text")
                    }
                    Button {
                        if let saveURL = viewmodel.showSavePanel() {
                            viewmodel.exportPDF(url: saveURL)
                        } else {
                            print("Invalid save url")
                        }
                        
                    } label : {
                        Label("Export PDF", systemImage: "square.and.arrow.up")
                    }
                }
                
            }
            .padding()
            Spacer()
            VStack (alignment: .trailing) {
                HStack {
                    Toggle("Show Date", isOn: $viewmodel.showDate)
                        .toggleStyle(.checkbox)
                    
                    Spacer()
                    
                    Picker("Color:", selection: $colorText) {
                        ForEach(colors, id: \.self) { color in
                            Text(color)
                        }
                    }
                    .fixedSize()
                    .onAppear { colorText = viewmodel.letterColor }
                    .onChange(of: colorText) { _ in viewmodel.updateColor(colorText, needsUpdate: true) }
                    
                    Spacer()
                    
                    Picker("Template:", selection: $templateText) {
                        ForEach(templates, id: \.self) { template in
                            Text(template)
                        }
                    }
                    .fixedSize()
                    .onAppear { templateText = viewmodel.template }
                    .onChange(of: templateText) { _ in viewmodel.updateTemplate(templateText, needsUpdate: true) }
                }
                .frame(width: 660)
                ScrollView {
                    switch viewmodel.template {
                    case "Template 1":
                        Template1View()
                    case "Template 2":
                        Template2View()
                    case "Template 3":
                        Template3View()
                    default:
                        Template1View()
                    }
                }
                .padding()
                .background(Colors.darkGray)
                .frame(width: 660, height: 575)
                .clipShape(RoundedRectangle(cornerRadius:15))
                .clipped()
            }
            
        }
        .padding()
        .sheet(isPresented: $showingTextEdit) {
            TextEditView()
        }
        .environmentObject(viewmodel)
        .onReceive(screenResChanged) { _ in
            viewmodel.updateView()
        }
    }
        
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = DataController.shared.container.viewContext

        MainView(viewmodel: GeneratorViewModel(moc: viewContext))
    }
}
