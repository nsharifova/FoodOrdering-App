//
//  AmChamBaseViewController.swift
//  AmCham
//
//  Created by Muslim on 16.12.2019.
//  Copyright © 2019 Emil ismayilov. All rights reserved.
//

import UIKit
import NVActivityIndicatorView


class BaseViewController: UIViewController {
    
     lazy var activityIndicator: NVActivityIndicatorView = {
         let view = NVActivityIndicatorView(frame: CGRect.zero)
         
         view.translatesAutoresizingMaskIntoConstraints = false
         view.padding = 15
         view.layer.cornerRadius = 3
         view.type = .circleStrokeSpin
         view.color = #colorLiteral(red: 0.1529411765, green: 0.2431372549, blue: 0.4784313725, alpha: 1)
         
         return view
     }()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
     func showActivityIndicator(in view: UIView? = nil, with size: CGSize = CGSize(width: 60, height: 60), color: UIColor = #colorLiteral(red: 0.1176470588, green: 0.1490196078, blue: 0.231372549, alpha: 1)) {
        
        if !activityIndicator.isAnimating {
            
            activityIndicator.color = color
            
            self.view.addSubview(activityIndicator)
            activityIndicator.centerXAnchor.constraint(equalTo: (view ?? self.view).centerXAnchor).isActive = true
            activityIndicator.widthAnchor.constraint(equalToConstant: size.width).isActive = true
            activityIndicator.centerYAnchor.constraint(equalTo: (view ?? self.view).centerYAnchor).isActive = true
            activityIndicator.heightAnchor.constraint(equalToConstant: size.height).isActive = true
            activityIndicator.startAnimating()
        }
    }
    
    internal func hideActivityIndicator() {
        view.subviews.forEach { (view) in
            if view == activityIndicator {
                activityIndicator.stopAnimating()
                       activityIndicator.removeConstraints(activityIndicator.constraints)
                       activityIndicator.removeFromSuperview()
            }
        }
       
    }
    

    
    func hideKeyboardOnTap()  {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        view.addGestureRecognizer(tap)
    }
    
    @objc func tapped()   {
        view.endEditing(true)
    }
    
    func showErrorAlert(title: String, message: String) {
        let errorAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        errorAlertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        DispatchQueue.main.async {
            self.present(errorAlertController, animated: true, completion: nil)
        }
    }
 
    
}



