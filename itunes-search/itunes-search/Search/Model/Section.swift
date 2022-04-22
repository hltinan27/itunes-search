//
//  Section.swift
//  itunes-search
//
//  Created by Halit İnan on 17.04.2022.
//

import Foundation
import UIKit

enum ImageSize: Int {
    case s = 0
    case m
    case l
    case xl
}

struct Section {
    var nane:  String
    var size: ImageSize
    var images: [UIImage]
}

struct SectionImage {
    var size: ImageSize
    var image: UIImage
}
