//
//  Decoder.swift
//  itunes-search
//
//  Created by Halit İnan on 17.04.2022.
//

import Foundation

public enum Decoders {
    
    public static let plainDateDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
}
