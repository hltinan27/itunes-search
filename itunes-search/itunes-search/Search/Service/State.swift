//
//  State.swift
//  itunes-search
//
//  Created by Halit İnan on 17.04.2022.
//

import Foundation

enum State<Data> {
    case loading
    case show(Data?)
    case error(Error)
}
