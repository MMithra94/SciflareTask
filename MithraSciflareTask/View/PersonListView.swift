//
//  PersonListView.swift
//  MithraSciflareTask
//
//  Created by Mithra Mohan on 22/02/24.
//

import SwiftUI

struct PersonListView: View {
    // MARK: Core data variables
    @EnvironmentObject var manager: DataManager
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: []) private var personSaved: FetchedResults<PersonData>
    
    @StateObject var viewModel = PersonListModel()
    
    var body: some View {
        
        NavigationView{
            VStack{
                NavigationLink(destination: AddPersonView()) {
                    HStack {
                        Spacer()
                        Image(systemName: "plus")
                        Text("Add New Person")
                    }
                }
                
                List {
                    ForEach(personSaved){ person in
                        NavigationLink {
                            MapDetailView()
                        } label: {
                            VStack(alignment: .leading){
                                HStack{
                                    Text("Name:")
                                        .font(.title3)
                                    Text(person.name ?? "Nil")
                                        .font(.title3).bold()
                                }
                                HStack{
                                    Text("Email:")
                                        .font(.title3)
                                    Text(person.email ?? "Nil")
                                        .font(.title3).bold()
                                }
                                HStack{
                                    Text("Mobile no:")
                                        .font(.title3)
                                    Text(person.mobileNo ?? "Nil")
                                        .font(.title3).bold()
                                }
                                HStack{
                                    Text("Gender:")
                                        .font(.title3)
                                    Text(person.gender ?? "Nil")
                                        .font(.title3).bold()
                                }
                            }
                        }
                    }
                   
                }.listStyle(InsetListStyle())
                .navigationTitle("Person List")
                .navigationBarTitleDisplayMode(.large)
                .onAppear {
                    
                    Task {
                        if let response =  await viewModel.fetchData(){
                            
                            for i in 0..<(response.count )  {
                                let person = PersonData(context: self.viewContext)
                                person.name = response[i].name
                                person.email = response[i].email
                                person.mobileNo = "\(response[i].mobileNo ?? 0)"
                                person.gender = response[i].gender
                                
                                do {
                                    try self.viewContext.save()
                                } catch {
                                    print("whoops \\(error.localizedDescription)")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
    
    
}

#Preview {
    PersonListView()
}







