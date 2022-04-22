//
//  Result.swift
//  itunes-search
//
//  Created by Halit İnan on 17.04.2022.
//

import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(Error)
}
