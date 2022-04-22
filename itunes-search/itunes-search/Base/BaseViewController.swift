//
//  BaseViewController.swift
//  itunes-search
//
//  Created by Halit İnan on 17.04.2022.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    var isLoading = false {
        didSet {
            if isLoading {
                Indicator.start(from: self.view)
            } else {
                Indicator.stop()
            }
        }
    }
    
    func alert(message: String, title: String ,actionButtonTitle: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionButton = UIAlertAction(title: actionButtonTitle, style: .default, handler: nil)
        alertController.addAction(actionButton)
        self.present(alertController, animated: true, completion: nil)
    }
}
