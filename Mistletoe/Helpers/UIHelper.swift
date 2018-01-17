//
//  UIHelper.swift
//  Mistletoe
//
//  Created by Gerson Noboa on 14/1/18.
//  Copyright © 2018 Heavenlapse. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

class UIHelper {
    
    class Loading {
        static func show() {
            let size = CGSize(width: 50, height: 50)
            let data = ActivityData(size: size, message: "Loading...", messageFont: nil, messageSpacing: nil, type: NVActivityIndicatorType.lineScalePulseOutRapid, color: nil, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil, textColor: nil)
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(data)
        }
        
        static func hide(){
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        }
        
        static func changeMessage(message: String) {
            NVActivityIndicatorPresenter.sharedInstance.setMessage(message)
        }
    }
    
    static func showNetworkingError(vc viewController: UIViewController?, retryBlock: (() -> (Void))?) {
        showNetworkingError(vc: viewController, shouldPop: false, retryBlock: retryBlock)
    }
    
    static func showNetworkingError(vc viewController: UIViewController?, shouldPop: Bool?, retryBlock: (() -> (Void))?) {
        
        guard let viewController = viewController else { return  }
        
        var message = "An error has occurred. "
        
        let shouldRetry = retryBlock != nil
        
        if shouldRetry {
            message += "Do you want to retry?"
        }
        else{
            message += "Please try again later."
        }
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        if shouldRetry {
            let cancelButton = UIAlertAction(title: "No", style: UIAlertActionStyle.cancel) { (action) in
                if let _ = shouldPop {
                    if (shouldPop!) {
                        viewController.navigationController?.popViewController(animated: true)
                    }
                }
            };
            alert.addAction(cancelButton)
            let okButton = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) { (action) in
                retryBlock!();
            }
            alert.addAction(okButton)
        }
        else {
            let okayButton = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(okayButton)
        }
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func showSuccessAlert(vc viewController: UIViewController, message: String?, successBlock: (() -> Void)? = nil) {
        
        var message = message
        if let _ = message { }
        else {
            message = "Operation executed successfully."
        }
        
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "Okay", style: .default) { (action) in
            successBlock?()
        }
        
        alert.addAction(okButton)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func showAlert(vc viewController: UIViewController, title: String, message: String, buttonTitle: String = "Okay") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let button = UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.default) { (action) in
            
        }
        alert.addAction(button)
        viewController.present(alert, animated: true, completion: nil)
    }
    static func executeInMainQueue(block: @escaping () -> (Void)) {
        DispatchQueue.main.async {
            block();
        }
    }
    
}
