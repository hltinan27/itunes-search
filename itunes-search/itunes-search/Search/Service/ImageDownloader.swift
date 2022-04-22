//
//  ImageDownloader.swift
//  itunes-search
//
//  Created by Halit İnan on 17.04.2022.
//

import Foundation
import UIKit

final class ImageDownloader {
    
    static let shared = ImageDownloader()
    
    let queue = DispatchQueue.global(qos: .background)
    let semaphore = DispatchSemaphore(value: 3)
    
    private init() { }
    
    func suspend() {
        queue.suspend()
    }
    
    func downloadImage(with imageUrlString: String?, index: Int,
                       completionHandler: @escaping (UIImage?, Bool, Int) -> Void,
                       placeholderImage: UIImage?) {
        
        guard let imageUrlString = imageUrlString else {
            completionHandler(placeholderImage, false, 0)
            return
        }
        
        guard let url = URL(string: imageUrlString) else {
            completionHandler(placeholderImage, false, 0)
            return
        }
        
        self.queue.async {
            self.semaphore.wait()
            
            defer {
                self.semaphore.signal()
            }
            
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completionHandler(image, true, data.count)
                    }
                }
            }
            
        }
        
    }
}
