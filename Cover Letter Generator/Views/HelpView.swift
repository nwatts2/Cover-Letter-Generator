//
//  HelpView.swift
//  Cover Letter Generator
//
//  Modal showing instructions for the application
//
//  Created by Noah on 3/7/23.
//

import SwiftUI

struct HelpView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        HStack (spacing: 30) {
                ZStack {
                    Colors.darkGray
                    VStack (spacing: 7) {
                        Text("Variable List")
                            .font(.title)
                            .underline()
                        Group {
                            HStack {
                                Text("*{firstName}")
                                Spacer()
                                Text("First Name")
                            }
                            HStack {
                                Text("*{lastName}")
                                Spacer()
                                Text("Last Name")
                            }
                            HStack {
                                Text("*{name}")
                                Spacer()
                                Text("Full Name")
                            }
                            HStack {
                                Text("*{phone}")
                                Spacer()
                                Text("Phone Number")
                            }
                            HStack {
                                Text("*{email}")
                                Spacer()
                                Text("Email Address")
                            }
                            HStack {
                                Text("*{website}")
                                Spacer()
                                Text("Website")
                            }
                            HStack {
                                Text("*{city}")
                                Spacer()
                                Text("City")
                            }
                            HStack {
                                Text("*{state}")
                                Spacer()
                                Text("State")
                            }
                            HStack {
                                Text("*{zip}")
                                Spacer()
                                Text("Zip Code")
                            }
                            HStack {
                                Text("*{manager}")
                                Spacer()
                                Text("Hiring Manager")
                            }
                        }
                        HStack {
                            Text("*{position}")
                            Spacer()
                            Text("Position Title")
                        }
                        HStack {
                            Text("*{company}")
                            Spacer()
                            Text("Company Name")
                        }
                        HStack {
                            Text("*{service}")
                            Spacer()
                            Text("Job Service")
                        }
                    }
                    .padding()
                }
                .frame(width: 250, height: 350)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
            VStack (spacing: 10) {
                    Text("Instructions")
                        .font(.title)
                        .underline()
                    Text("In the Edit Text window, you can program variables into specified places within your cover letter. To insert these variables, type out an asterisk followed by the variable name enclosed between two curly braces, such as in the example below:")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    ZStack {
                        Colors.darkGray
                        Text("Dear *{manager},\n\nMy name is *{firstName} *{lastName}, and I am an aspiring front-end web developer specializing in ReactJS. In my search for an entry-level position, I came across your opening for a *{position} on *{service}, and I knew I had to apply. *{company} has a great reputation as an employer, and…")
                            .padding([.leading, .trailing], 10)
                    }
                    .frame(height:160)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Got it")
                            .frame(width:200)
                    }
                }
        }
        .padding()
        .frame(width:680, height:370)
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
