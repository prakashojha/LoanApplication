//
//  LAUITextField.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 24/10/24.
//

import Foundation
import UIKit

class LAUITextField: UITextField {
    
    let edgeInsets: UIEdgeInsets
    let placeHolderText: String
    
    init(edgeInsets: UIEdgeInsets = .init(top: 0, left: 12, bottom: 0, right: 12), _ placeHolderText: String) {
        self.edgeInsets = edgeInsets
        self.placeHolderText = placeHolderText
        super.init(frame: .zero)
        
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.placeholder = placeHolderText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: edgeInsets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: edgeInsets)
    }
}
