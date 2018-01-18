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
    
    class Alert {
        
        static func error(vc viewController: UIViewController?) {
            show(vc: viewController, title: "Error", message: "An error has occurred. Please try again later.")
        }
        
        static func error(vc viewController: UIViewController?, retryBlock: @escaping (() -> (Void))) {
            error(vc: viewController, shouldPop: false, retryBlock: retryBlock)
        }
        
        static func error(vc viewController: UIViewController?, shouldPop: Bool?, retryBlock: @escaping (() -> (Void))) {
            let title = "Error"
            let message = "An error has occurred. Do you want to retry?"
            confirmation(vc: viewController, title: title, message: message, shouldPop: shouldPop, confirmAction: retryBlock)
        }
        
        static func confirmation(vc viewController: UIViewController?, message: String, confirmAction: @escaping (() -> Void)) {
            confirmation(vc: viewController, title: "Attention", message: message, shouldPop: false, confirmAction: confirmAction)
        }
        
        static func confirmation(vc viewController: UIViewController?, title: String, message: String, shouldPop: Bool?, confirmAction: @escaping (() -> Void)) {
            guard let viewController = viewController else { return }
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            let cancelButton = UIAlertAction(title: "No", style: UIAlertActionStyle.cancel) { (action) in
                if let _ = shouldPop {
                    if (shouldPop!) {
                        viewController.navigationController?.popViewController(animated: true)
                    }
                }
            };
            alert.addAction(cancelButton)
            let okButton = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) { (action) in
                confirmAction();
            }
            alert.addAction(okButton)
            
            viewController.present(alert, animated: true, completion: nil)
        }
        
        static func success(vc viewController: UIViewController?, message: String?, successBlock: (() -> Void)? = nil) {
            guard let viewController = viewController else { return }
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
        
        static func show(vc viewController: UIViewController?, title: String, message: String, buttonTitle: String = "Okay") {
            
            guard let viewController = viewController else { return }
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            let button = UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.default) { (action) in
                
            }
            alert.addAction(button)
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    static func executeInMainQueue(block: @escaping () -> (Void)) {
        DispatchQueue.main.async {
            block();
        }
    }
    
}
