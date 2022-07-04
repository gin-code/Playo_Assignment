//
//  NetworkClass.swift
//  playoAssignment
//
//  Created by Sparsh Singh on 04/07/22.
//

import Foundation

class NetworkClass {
    
    static let shared = NetworkClass()
    
    let newsUrl = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=58644279f92a40d290018e61d03baec2"
    
    let decoder = JSONDecoder()
    
    func apiRequest<T:Codable>(url: String, params: [String:Any], method: String, responseObject:T.Type, callBack:Callback<T, String> ) {
        
        // Check Internet Connection
        if !Reachability.isConnectedToNetwork() {
            Extensions.displayAlert(title: "Playo-NewsApp", message: "Internet Not Available." )
            return
        }

        // Convert to URL
        guard let urlComponents = URLComponents(string: url) else { return }
        
        print("Request URL is:\(urlComponents.url!.absoluteString)")
        
        var  request = URLRequest(url: urlComponents.url!)
        request.httpMethod =  method
        
        //MARK Headers
        
        let sessionToken = UserDefaults.standard.value(forKey: "SessionToken") //Check For Token
        
        if sessionToken != nil {
            
            let headers = ["x-custom-token": sessionToken] as [String: Any]
            
            print("Headers \(headers)")
            
            request.allHTTPHeaderFields = headers as? [String : String]
        }
        else {
            let headers = [:] as [String : Any]
            request.allHTTPHeaderFields = headers as? [String : String]
        }
        
        if method == "POST" || method == "PUT" {
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody       =  try? JSONSerialization.data(withJSONObject: params, options: [])
            
        }else{
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        print(params)
        print("URL: \(urlComponents)")
        URLSession.shared.dataTask(with: request) { (data, response, error) -> Void in
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    do{
                        let json = try JSONDecoder().decode(T.self, from: data)
                        print("json \(json)")
                        callBack.onSuccess(json)
                    } catch let error {
                        callBack.onFailure(error.localizedDescription)
                    }
                }else if let response = response as? HTTPURLResponse, 400...499 ~= response.statusCode{
                    
                    do{
                        let json = try JSONDecoder().decode(T.self, from: data)
                        
                        callBack.onSuccess(json)
                    } catch let error {
                        callBack.onFailure(error.localizedDescription)
                    }
                    
                }else if let response = response as? HTTPURLResponse, 500...599 ~= response.statusCode{
                    callBack.onFailure("Currently having some issue on server, Please try again after some time" )
                }
            }else {
                callBack.onFailure(error?.localizedDescription ?? "")
            }
        }.resume()
        
    }
    
    
}
