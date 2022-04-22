//
//  SearchViewModel.swift
//  itunes-search
//
//  Created by Halit İnan on 17.04.2022.
//

import Foundation
import UIKit

protocol SearchViewModelDelegate: AnyObject {
    func viewModelStateChanged(state: State<SectionImage>)
}

final class SearchViewModel {
    weak var delegate: SearchViewModelDelegate?
    let service = SearchWebService()
    
    func getSearch(with query: String){
        ImageDownloader.shared.suspend()
        self.delegate?.viewModelStateChanged(state: .loading)
        service.getSearch(with: query) { [weak self] (result) in
            switch result {
            case .success(let response):
                let screenshotUrls = response.flatMap { $0.screenshotUrls }
                if screenshotUrls.count > 0 {
                    self?.sendImageToView(screenshotUrls)
                } else {
                    self?.delegate?.viewModelStateChanged(state: .show(nil))
                }
                
            case .failure(let error):
                self?.delegate?.viewModelStateChanged(state: .error(error))
            }
        }
    }
    
    private func setState(state: State<SectionImage>) {
        delegate?.viewModelStateChanged(state: state)
    }
    
    private func sendImageToView(_ screenshotUrls: [String]) {
        for (index, urlString) in screenshotUrls.enumerated() {
            ImageDownloader.shared.downloadImage(with: urlString,index: index, completionHandler: { image, status, size in
                var imageSize = ImageSize.s
                let image_kb = size / 1024
                switch image_kb {
                case 0..<100: imageSize = ImageSize.s;
                case 0..<250: imageSize = ImageSize.m;
                case 0..<500: imageSize = ImageSize.l
                default:
                    imageSize = ImageSize.xl
                    
                }
                self.delegate?.viewModelStateChanged(state: .show(SectionImage(size: imageSize, image: image!)))
                
            }, placeholderImage: UIImage(named: ""))
        }
    }
    
}
