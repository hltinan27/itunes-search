//
//  PreviewViewController.swift
//  itunes-search
//
//  Created by Halit İnan on 22.04.2022.
//

import Foundation
import UIKit
import SnapKit

class PreviewViewController: BaseViewController {
    lazy var imageView = UIImageView()
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(16)
        }
        
        imageView.image = image
    }
}
