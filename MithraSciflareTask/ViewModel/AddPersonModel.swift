//
//  AddPersonModel.swift
//  MithraSciflareTask
//
//  Created by Mithra Mohan on 22/02/24.
//

import Foundation

class AddPersonModel : ObservableObject{
    
    var  responseData : [PersonModel] = []
    
    init() {
        Task.init {
            await addPerson(params: [:])
        }
    }
    
    func addPerson(params : [String:Any]) async {
        guard let downloadedData: [PersonModel] = await WebService().postData(fromURL: "https://crudcrud.com/api/214610bcc9c44fdab1e714d3410f0215/mithra", params: params) else {return}
        self.responseData = downloadedData
        
    }
}
