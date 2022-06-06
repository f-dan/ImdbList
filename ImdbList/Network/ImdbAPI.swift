//
//  ImdbAPI.swift
//  ImdbList
//
//  Created by Danilo on 02/05/22.
//

import Alamofire
import Foundation

class ImdbAPI{
    
     let basePath = Credentials.baseUrl.rawValue
     let apiKey = Credentials.apiKey.rawValue
    
     func requestMovie(movieName: String, completion: @escaping (Search?) -> Void){
         let url = "\(basePath)Search/\(apiKey)/\(movieName.replacingOccurrences(of: " ", with: "%20"))"
        
        AF.request(url).responseJSON { (response) in
            guard let data = response.data else {
                completion(nil)
                return
            }
            do{
                let search = try JSONDecoder().decode(Search.self, from: data)
                completion(search)
            }catch{
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func requestTrailer(videoID: String, completion: @escaping (Trailer?) -> Void){
        let url = "\(basePath)Trailer/\(apiKey)/\(videoID)"
        
        AF.request(url).responseJSON { (response) in
            guard let data = response.data else {
                completion(nil)
                return
            }
            do{
                let trailer = try JSONDecoder().decode(Trailer.self, from: data)
                completion(trailer)
            }catch{
                print(error.localizedDescription)
                completion(nil)
            }
            
        }
    }
}

