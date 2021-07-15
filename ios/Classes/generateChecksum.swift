//
//  generateChecksum.swift
//  payumoney_pro_unofficial
//
//  Created by Mukesh Joshi on 15/07/21.
//

import Foundation
import Alamofire
func generateChecksum(url:String,string:String,onComplete: @escaping (String) -> Void){
    let parameters: [String: String] = [
        "hash": string,
    ]
    // All three of these calls are equivalent
    AF.request(url, method: .post, parameters: parameters).responseString { response in
        onComplete(String(data: response.data!, encoding: .utf8)! )
    }
    
    
}
