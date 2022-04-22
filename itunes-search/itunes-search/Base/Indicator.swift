//
//  Indicator.swift
//  itunes-search
//
//  Created by Halit İnan on 17.04.2022.
//

import Foundation
import UIKit

final class Indicator {
    
    fileprivate static var activityIndicator: UIActivityIndicatorView?
    fileprivate static var style: UIActivityIndicatorView.Style = .whiteLarge
    fileprivate static var baseBackColor = UIColor(white: 0, alpha: 0.15)
    fileprivate static var baseColor = UIColor.white
    
    
    public static func start(from view: UIView,
                           style: UIActivityIndicatorView.Style = Indicator.style,
                           backgroundColor: UIColor = Indicator.baseBackColor,
                           baseColor: UIColor = Indicator.baseColor) {
        
        guard Indicator.activityIndicator == nil else { return }
        
        let spinner = UIActivityIndicatorView(style: style)
        spinner.backgroundColor = backgroundColor
        spinner.color = baseColor
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)
        spinner.accessibilityIdentifier = "indicator"
        addConstraints(to: view, with: spinner)
        
        Indicator.activityIndicator = spinner
        Indicator.activityIndicator?.startAnimating()
    }
    
    public static func stop() {
        Indicator.activityIndicator?.stopAnimating()
        Indicator.activityIndicator?.removeFromSuperview()
        Indicator.activityIndicator = nil
    }
    
    fileprivate static func addConstraints(to view: UIView, with spinner: UIActivityIndicatorView) {
        spinner.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        spinner.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        spinner.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        spinner.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
}
