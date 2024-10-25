//
//  View+Extension.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 24/10/24.
//

import Foundation
import UIKit

@objc protocol HideKeyboardProtocol {
    func dismissKeyboardView()
}

protocol ShowAlertProtocol {
    func showAlert(with message: String, completion: (()->Void)?)
}

extension HideKeyboardProtocol where Self: UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(dismissKeyboardView))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
}

extension ShowAlertProtocol where Self: UIViewController {
    
    func showAlert(with message: String, completion: (()->Void)?) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { _ in
            completion?()
        }
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
}
