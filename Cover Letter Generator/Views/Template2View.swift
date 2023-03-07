//
//  Template2View.swift
//  Cover Letter Generator
//
//  Second template for cover letters to follow
//
//  Created by Noah on 3/6/23.
//

import SwiftUI

struct Template2View: View {
    @EnvironmentObject var viewmodel: GeneratorViewModel
    
    var date = Date.now.formatted(date: .complete, time: .omitted)
        
    var width = 612.0
    var height = 792.0
    var nameHeight = 50.0
    var bandHeight = 60.0
    
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
            secondaryColor
            VStack (spacing: 0) {
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
                    .frame(width: width, height: nameHeight)
                    .font(.system(size: nameFont))
                    .foregroundColor(Colors.white)
                    .padding([.top], namePadding)
                    
                Text(viewmodel.title == "(job title)" ? "" : viewmodel.title)
                    .font(.system(size: titleFont))
                    .foregroundColor(Colors.white)
                    .frame(width: width)
                    .padding([.bottom], titlePadding)
                    .lineLimit(1)
                    
                ZStack {
                    primaryColor
                    HStack {
                        Spacer()
                        VStack (alignment: .leading) {
                            Spacer()
                            if viewmodel.phone != "(phone number)" {
                                HStack {
                                    Image(systemName: "phone")
                                    Text("\(viewmodel.phone)")
                                        .lineLimit(1)
                                }
                            }
                            Spacer()
                            if viewmodel.email != "(email address)" {
                                HStack {
                                    Image(systemName: "envelope")
                                    Text("\(viewmodel.email)")
                                        .lineLimit(1)

                                }
                            }
                            Spacer()
                        }
                        Spacer()
                        VStack (alignment: .leading) {
                            Spacer()
                            if viewmodel.state != "None" || viewmodel.city != "(city)" || viewmodel.zip != "(zip)" {
                                HStack {
                                    Image(systemName: "safari")
                                    Text("\(addressText)")
                                        .lineLimit(1)
                                }
                            }
                            Spacer()
                            if viewmodel.website != "(website)" {
                                HStack {
                                    Image(systemName: "link")
                                    Text("\(viewmodel.website)")
                                        .lineLimit(1)
                                }
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                    .font(.system(size: infoFont))
                }
                .frame(width: width, height: bandHeight)
                .foregroundColor(.white)
                
                ZStack {
                    Colors.white
                    Text(viewmodel.showDate == true ? "\(date)\n\n\(viewmodel.text)" : viewmodel.text)
                        .font(.system(size: bodyFont))
                        .foregroundColor(Colors.black)
                        .padding(EdgeInsets(top: bodyPadding2, leading: bodyPadding, bottom: bodyPadding2, trailing: bodyPadding))
                }
                .padding([.top, .bottom], bodyPadding2)
                .frame(width: width - (2 * bodyPadding))
                
            }
            
        }
        .frame(width: width, height: height)
        .minimumScaleFactor(0.4)
            
    }
}

struct Template2View_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = DataController.shared.container.viewContext

        Template2View()
            .environmentObject(GeneratorViewModel(moc: viewContext))
    }
}
