//
//  Extensions.swift
//  OnTheMap
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 16/10/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import SafariServices
extension UIViewController: SFSafariViewControllerDelegate {
    
    public func presentWebPageInSafari(withURLString URLString: String) {
        
        if let url = URL(string: URLString), UIApplication.shared.canOpenURL(url) {
            let vc = SFSafariViewController(url: url)
            vc.delegate = self
            self.present(vc, animated: true)
        }
    }
}
