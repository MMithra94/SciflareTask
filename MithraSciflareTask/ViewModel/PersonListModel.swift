//
//  PersonListModel.swift
//  MithraSciflareTask
//
//  Created by Mithra Mohan on 22/02/24.
//

import Foundation


class PersonListModel : ObservableObject{
    
    var persons: [PersonModel] = []
    
    init() {
        Task.init {
            await fetchData()
        }
    }
    
    func fetchData() async -> [PersonModel]? {
        guard let downloadedData: [PersonModel] = await WebService().downloadData(fromURL: "https://crudcrud.com/api/214610bcc9c44fdab1e714d3410f0215/mithra") else {return nil}
        self.persons = downloadedData
        return downloadedData
    }
}
