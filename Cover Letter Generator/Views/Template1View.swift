//
//  LetterTextView.swift
//  Cover Letter Generator
//
//  First template for cover letters to follow
//
//  Created by Noah on 2/28/23.
//

import SwiftUI

struct Template1View: View {
    @EnvironmentObject var viewmodel: GeneratorViewModel
    
    var date = Date.now.formatted(date: .complete, time: .omitted)
        
    var width = 612.0
    var height = 792.0
    var recWidth = 170.0
    var nameHeight = 132.0
    var bandHeight = 31.0
    
    var infoFont = 11.0
    var titleFont = 17.0
    var nameFont = 43.0
    var bodyFont = 12.0
    
    var nameSpacing = 5.0
    var infoSpacing = 20.0
    
    var namePadding = 24.0
    var titlePadding = 12.0
    var infoPadding = 10.0
    var infoPadding2 = 5.0
    var bodyPadding = 20.0
    
    var primaryColor: Color {
        switch viewmodel.letterColor {
        case "Red":
            return Colors.red
        case "Orange":
            return Colors.orange
        case "Green":
            return Colors.green
        case "Teal":
            return Colors.teal
        case "Blue":
            return Colors.blue
        case "Purple":
            return Colors.purple
        default:
            return Colors.blue
        }
    }
    
    var secondaryColor: Color {
        switch viewmodel.letterColor {
        case "Red":
            return Colors.darkRed
        case "Orange":
            return Colors.darkOrange
        case "Green":
            return Colors.darkGreen
        case "Teal":
            return Colors.darkTeal
        case "Blue":
            return Colors.darkBlue
        case "Purple":
            return Colors.darkPurple
        default:
            return Colors.darkBlue
        }
    }
    
    var addressText: String {
        var tempString = ""
        
        if viewmodel.city != "(city)" {
            tempString += "\(viewmodel.city)"
            
            if viewmodel.state != "None" || viewmodel.zip != "(zip)" {tempString += ", "}

        }
        
        if viewmodel.state != "None" {
            tempString += "\(viewmodel.state)"
            if viewmodel.zip != "(zip)" {tempString += ", "}
        }
        
        if viewmodel.zip != "(zip)" {tempString += "\(viewmodel.zip)"}
        
        return tempString
    }
    
    var body: some View {
        ZStack {
            Colors.white.ignoresSafeArea()
            HStack {
                VStack (spacing: 0) {
                    ZStack (alignment: Alignment(horizontal: .center, vertical: .center)) {
                        primaryColor
                        if viewmodel.firstName != "(first name)" || viewmodel.lastName != "(last name)" {
                            VStack (alignment: .leading, spacing: nameSpacing) {
                                if viewmodel.firstName != "(first name)" {
                                    Text(viewmodel.firstName)
                                        .bold()
                                        .frame(width: recWidth - (2 * namePadding), alignment: .leading)

                                }
                                
                                if viewmodel.lastName != "(last name)" {
                                    Text("\(viewmodel.lastName)")
                                        .bold()
                                        .frame(width: recWidth - (2 * namePadding), alignment: .trailing)
                                }
                            }
                            .padding([.top, .bottom], namePadding)
                            .padding([.leading, .trailing], 10)
                        }
                        
                    }
                    .frame(width: recWidth, height: nameHeight)
                    .font(.system(size: nameFont))
                    
                    ZStack (alignment: Alignment(horizontal: .leading, vertical: .center)) {
                        secondaryColor
                        Text(viewmodel.title == "(job title)" ? "" : viewmodel.title)
                            .padding([.leading, .trailing], titlePadding)
                            .lineLimit(1)
                            .minimumScaleFactor(0.4)
                    }
                    .frame(width: recWidth, height: bandHeight)
                    .font(.system(size: titleFont))
                    .bold()
                    .multilineTextAlignment(.leading)
                    
                    ZStack (alignment: Alignment(horizontal: .leading, vertical: .top)) {
                        primaryColor
                        VStack (alignment: .leading, spacing: infoSpacing) {
                            Text("Personal Info")
                                .font(.system(size: infoFont + 3))
                                .underline()
                                .bold()
                            if viewmodel.phone != "(phone number)" {
                                VStack (alignment: .leading) {
                                    Text("Phone:")
                                        .bold()
                                    Text("\(viewmodel.phone)")
                                        .lineLimit(1)
                                        .padding([.leading], infoPadding2)
                                }
                            }
                            
                            if viewmodel.email != "(email address)" {
                                VStack (alignment: .leading) {
                                    Text("Email:")
                                        .bold()
                                    Text("\(viewmodel.email)")
                                        .lineLimit(1)
                                        .padding([.leading], infoPadding2)

                                }
                            }
                            
                            if viewmodel.state != "None" || viewmodel.city != "(city)" || viewmodel.zip != "(zip)" {
                                VStack (alignment: .leading) {
                                    Text("Address:")
                                        .bold()
                                    Text("\(addressText)")
                                        .padding([.leading], infoPadding2)
                                }
                            }
                            
                            if viewmodel.website != "(website)" {
                                VStack (alignment: .leading) {
                                    Text("Website:")
                                        .bold()
                                    Text("\(viewmodel.website)")
                                        .lineLimit(1)
                                        .padding([.leading], infoPadding2)
                                }
                            }
                            
                        }
                        .font(.system(size: infoFont))
                        .padding(.all, infoPadding)
                        .multilineTextAlignment(.leading)
                    }
                    .frame(width: recWidth, height: height - nameHeight - bandHeight)

                }
                .foregroundColor(.white)
                VStack {
                    Text(viewmodel.showDate == true ? "\(date)\n\n\(viewmodel.text)" : viewmodel.text)
                        .foregroundColor(Colors.black)
                        .font(.system(size: bodyFont))
                }
                .padding([.leading, .trailing], bodyPadding)
                .frame(width: width - recWidth)
            }
            
        }
        .frame(width: width, height: height)
        .minimumScaleFactor(0.4)
            
    }
}

struct Template1View_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = DataController.shared.container.viewContext

        Template1View()
            .environmentObject(GeneratorViewModel(moc: viewContext))
    }
}
