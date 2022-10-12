//
//  Parser.swift
//  MVVM-DovizApp
//
//  Created by Furkan on 12.10.2022.
//

import Foundation

struct Parser{
    func parse(comp:@escaping([Currency])->()){
        let headers = [
          "content-type": "application/json",
          "authorization": "apikey 6Rafjtw7wDBewl4Quv6OAk:17ma04CochSnMbLJdYlRrM"
        ]

        var request = URLRequest(url: URL(string: "https://api.collectapi.com/economy/allCurrency")!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        URLSession.shared.dataTask(with: request, completionHandler: {data,respone,error in
            if error != nil && data == nil{
                print(error as Any)
                return
            }
                do {
                    let result = try JSONDecoder().decode(Currencies.self, from: data!)
                    comp(result.result!)
                } catch {
                    print(error.localizedDescription)
                }
            
        }).resume()
        
    }
}
