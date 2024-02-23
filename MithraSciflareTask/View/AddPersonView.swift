//
//  AddPersonView.swift
//  MithraSciflareTask
//
//  Created by Mithra Mohan on 22/02/24.
//

import SwiftUI

struct AddPersonView: View {
    
    @StateObject var viewModel = AddPersonModel()
    
    @State var name  = ""
    @State var email  = ""
    @State var gender  = ""
    @State var mobileNo  = ""
    @State private var isAlert = false
    let limit = 10
    var body: some View {
        NavigationStack{
            VStack(spacing: 20) {
                Group{
                    TextField("Enter the Name",text: $name)
                    TextField("Enter the Email",text: $email)
                    TextField("Enter the Mobile No:",text: $mobileNo).onChange(of: mobileNo) { _ in
                        mobileNo = String(mobileNo.prefix(limit))
                    }.keyboardType(.numberPad)
                    TextField("Enter the Gender",text: $gender)
                }.textFieldStyle(.roundedBorder).border(.gray)
                Button {
                    Task {
                        
                        await addPerson()
                    }
                } label: {
                    HStack{
                        Image(systemName: "plus")
                        Text("Add Person")
                            .font(.title)
                    }
                }
                
                Spacer()
                
                
            }.alert(isPresented: $isAlert, content: {
                Alert(title: Text("Alert!!"),message: Text("Please fill all the fields"))
            })
            .navigationTitle("Add person")
            .navigationBarTitleDisplayMode(.inline)
        }
        
        
        .padding(10)
    }
    
    func addPerson() async   {
        if textFieldValidatorEmail(email) && name != "" && mobileNo != "" && gender != ""  {
            await viewModel.addPerson(params: ["name": name,"email":email,"gender":gender, "mobileNo":(Int(mobileNo) ?? 0)])
        } else {
            isAlert = true
        }
        
        
    }
    func textFieldValidatorEmail(_ string: String) -> Bool {
        if string.count > 100 {
            return false
        }
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
    }
    
    
    
}

#Preview {
    AddPersonView()
}
