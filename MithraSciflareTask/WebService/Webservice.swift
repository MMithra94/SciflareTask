//
//  Webservice.swift
//  MithraSciflareTask
//
//  Created by Mithra Mohan on 22/02/24.
//

import Foundation



class WebService {
    func downloadData<T: Codable>(fromURL: String) async -> T? {
        do {
            guard let url = URL(string: fromURL) else { return nil }
            let urlRequest = URLRequest(url: url)
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { return nil }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            print("Error fetching data from Pexels: \(error)")
        }
        return nil
    }
    
    func postData<T:Codable>(fromURL : String,params : [String:Any]) async -> T? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            guard let url = URL(string: fromURL) else { return nil }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let _ = responseJSON as? [String: Any] {
                }
         
            }
            
            task.resume()
            
            
        } catch {
            print("Error fetching data from Pexels: \(error)")
        }
        
        return nil
    }
}


