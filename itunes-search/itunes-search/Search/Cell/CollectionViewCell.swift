//
//  CollectionViewCell.swift
//  itunes-search
//
//  Created by Halit İnan on 16.04.2022.
//

import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static var identifier = "CollectionViewCell"
    
    let cellImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode  = .scaleAspectFit
        iv.backgroundColor = UIColor.black
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cellImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
    
    override func layoutSubviews() {
        cellImageView.frame = contentView.bounds
    }
    
    public func configure(with image: UIImage){
        cellImageView.image = nil
        cellImageView.image = image

    }
}
