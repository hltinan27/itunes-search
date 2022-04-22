//
//  SectionHeader.swift
//  itunes-search
//
//  Created by Halit İnan on 22.04.2022.
//

import Foundation
import UIKit

class SectionHeader: UICollectionReusableView {
     var label: UILabel = {
         let label: UILabel = UILabel()
         label.textColor = .black
         label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
         label.sizeToFit()
         return label
     }()

     override init(frame: CGRect) {
         super.init(frame: frame)

         addSubview(label)
         label.backgroundColor = UIColor.lightGray
         label.snp.makeConstraints { make in
             make.topMargin.equalToSuperview()
             make.leading.equalToSuperview()
             make.trailing.equalToSuperview()
             
         }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
