//
//  LAUIInputField.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 25/10/24.
//

import Foundation
import UIKit

class LAUIInputField: UIView {
    let edgeInsets: UIEdgeInsets
    let placeHolderText: String
    let textFieldText: String?
    let labelText: String
    
    let labelViewHeight: CGFloat = 18
    let labelFontSize: CGFloat = 14
    
    lazy var textField: LAUITextField = {
        let view = LAUITextField(edgeInsets: self.edgeInsets, self.placeHolderText, self.textFieldText)
        return view
    }()
    
    lazy var textLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = self.labelText
        view.font = UIFont.systemFont(ofSize: labelFontSize, weight: .regular)
        view.textColor = .lightGray
        return view
    }()
    
    init(edgeInsets: UIEdgeInsets = .init(top: 0, left: 12, bottom: 0, right: 12), _ placeHolderText: String, _ textFieldText: String? = nil, labelText: String) {
        self.edgeInsets = edgeInsets
        self.placeHolderText = placeHolderText
        self.textFieldText = textFieldText
        self.labelText = labelText
        super.init(frame: .zero)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(textLabel)
        addSubview(textField)
    }
    
    func setupConstraints() {
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: self.topAnchor),
            textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textLabel.heightAnchor.constraint(equalToConstant: labelViewHeight),
            
            textField.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 2),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}
