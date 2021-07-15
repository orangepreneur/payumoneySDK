//
//  generateChecksum.swift
//  payumoney_pro_unofficial
//
//  Created by Mukesh Joshi on 15/07/21.
//

import Foundation

func generateChecksum(url:String,string:String,onComplete: @escaping (String) -> Void){
    let Url = String(format: url)
        guard let serviceUrl = URL(string: Url) else { return  }
        let parameters: [String: Any] = [
            "hash" : string,
        ]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            return
        }
        request.httpBody = httpBody
        request.timeoutInterval = 20
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let data = String(data: data!, encoding: .utf8) {
                onComplete(data)
            }
        }.resume()
    
}
