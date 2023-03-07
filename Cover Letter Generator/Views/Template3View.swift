//
//  Template3View.swift
//  Cover Letter Generator
//
//  Third template for cover letters to follow
//
//  Created by Noah on 3/7/23.
//

import SwiftUI

struct Template3View: View {
    @EnvironmentObject var viewmodel: GeneratorViewModel
    
    var date = Date.now.formatted(date: .complete, time: .omitted)
        
    var width = 612.0
    var height = 792.0
    var nameHeight = 70.0
    var recWidth = 200.0
    
    var infoFont = 11.0
    var titleFont = 17.0
    var nameFont = 43.0
    var bodyFont = 12.0
    
    var nameSpacing = 5.0
    var infoSpacing = 20.0
    
    var namePadding = 10.0
    var titlePadding = 10.0
    var infoPadding = 10.0
    var bodyPadding = 30.0
    var bodyPadding2 = 15.0
    
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
        ZStack (alignment: Alignment(horizontal: .center, vertical: .top)) {
            Colors.white.ignoresSafeArea()
            VStack (spacing: 0) {
                ZStack (alignment: Alignment(horizontal: .leading, vertical: .center)) {
                    secondaryColor
                    VStack (alignment: .leading) {
                        HStack {
                            if viewmodel.firstName != "(first name)" {
                                Text(viewmodel.firstName)
                                    .bold()
                                
                            }
                            
                            if viewmodel.lastName != "(last name)" {
                                Text("\(viewmodel.lastName)")
                                    .bold()
                            }
                        }
                            .font(.system(size: nameFont))
                            .padding([.top], namePadding)
                        
                        Text(viewmodel.title == "(job title)" ? "" : viewmodel.title)
                            .font(.system(size: titleFont))
                            .padding([.bottom], titlePadding)
                            .lineLimit(1)
                    }
                    .padding([.leading], namePadding)
                }
                .foregroundColor(Colors.white)
                .frame(width: width, height: nameHeight)
                
                HStack {
                    Text(viewmodel.showDate == true ? "\(date)\n\n\(viewmodel.text)" : viewmodel.text)
                        .font(.system(size: bodyFont))
                        .foregroundColor(Colors.black)
                        .padding(EdgeInsets(top: bodyPadding2, leading: bodyPadding, bottom: bodyPadding2, trailing: bodyPadding))
                        .frame(width: width - recWidth)
                    
                    ZStack (alignment: Alignment(horizontal: .leading, vertical: .top)) {
                        Colors.offWhite
                        VStack (alignment: .leading, spacing: (15)) {
                            Text("Personal Info")
                                .bold()
                                .underline()
                                .foregroundColor(secondaryColor)
                                .font(.system(size: infoFont + 3))
                            if viewmodel.phone != "(phone number)" {
                                VStack (alignment: .leading) {
                                    Text("Phone")
                                        .bold()
                                    Text("\(viewmodel.phone)")
                                        .lineLimit(1)
                                }
                            }
                            if viewmodel.email != "(email address)" {
                                VStack (alignment: .leading) {
                                    Text("Email")
                                        .bold()
                                    Text("\(viewmodel.email)")
                                        .lineLimit(2)

                                }
                            }
                            if viewmodel.state != "None" || viewmodel.city != "(city)" || viewmodel.zip != "(zip)" {
                                VStack (alignment: .leading) {
                                    Text("Address")
                                        .bold()
                                    Text("\(addressText)")
                                        .lineLimit(1)
                                }
                            }
                            if viewmodel.website != "(website)" {
                                VStack (alignment: .leading) {
                                    Text("Website")
                                        .bold()
                                    Text("\(viewmodel.website)")
                                        .lineLimit(1)
                                }
                            }
                        }
                        .font(.system(size: infoFont))
                        .minimumScaleFactor(0.4)
                        .padding(infoPadding)
                    }
                    .frame(width: recWidth, height: height - nameHeight)
                    .foregroundColor(Colors.black)

                }
                
            }
            
        }
        .frame(width: width, height: height)
        .minimumScaleFactor(0.4)
            
    }
}

struct Template3View_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = DataController.shared.container.viewContext

        Template3View()
            .environmentObject(GeneratorViewModel(moc: viewContext))
    }
}
