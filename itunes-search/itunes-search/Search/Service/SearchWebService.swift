//
//  SearchWebService.swift
//  itunes-search
//
//  Created by Halit İnan on 17.04.2022.
//

import Foundation
import Alamofire



public enum APIError: Swift.Error {
    case serializationError(internal: Swift.Error)
    case networkError(internal: Swift.Error)
}


public protocol MovieWebServiceProtocol {
    func getSearch(with query: String, completion: @escaping (Result<[MovieData]>) -> Void)
}


public class SearchWebService: MovieWebServiceProtocol {
    
    public func getSearch(with query: String,
                          completion: @escaping (Result<[MovieData]>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return}
        let urlString =  "https://itunes.apple.com/search?term=\(query)&entity=software"
        
        
        AF.request(urlString).responseData { (response) in
            switch response.result {
            case .success(let data):
                let decoder = Decoders.plainDateDecoder
                
                do {
                    let response = try decoder.decode(MovieResponse.self, from: data)
                    completion(.success(response.results))
                } catch {
                    completion(.failure(APIError.serializationError(internal: error)))
                }
            case .failure(let error):
                completion(.failure(APIError.networkError(internal: error)))
            }
        }
    }
    
}

public struct MovieResponse: Codable {
    let results: [MovieData]
}

public struct MovieData: Codable {
    let screenshotUrls: [String]
}
