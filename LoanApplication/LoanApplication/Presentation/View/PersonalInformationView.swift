//
//  PersonalInformationView.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 24/10/24.
//

import Foundation
import UIKit

class PersonalInformationView: UIView {
    
    private let genders: [String] = ["Male", "Female"]
    private let pickerView: UIPickerView = UIPickerView()
    
    private lazy var firstNameView: LATextField = {
        let view: LATextField = LATextField("First Name")
        return view
    }()
    
    private lazy var emailAddressView: LATextField = {
        let view: LATextField = LATextField("Email Address")
        return view
    }()
    
    private lazy var phoneNumber: LATextField = {
        let view: LATextField = LATextField("Phone Number")
        view.keyboardType = .asciiCapableNumberPad
        return view
    }()
    
    private lazy var genderView: LATextField = {
        let textView = LATextField("Gander")
        textView.text = genders[0]
        textView.inputView = pickerView
        textView.delegate = self.superview as? any UITextFieldDelegate
        return textView
        
    }()
    
    private lazy var address: LATextField = {
        let view: LATextField = LATextField("Address")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        pickerView.dataSource = self
        pickerView.delegate = self
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(firstNameView)
        self.addSubview(emailAddressView)
        self.addSubview(phoneNumber)
        self.addSubview(genderView)
        self.addSubview(address)
    }
    
    func setupConstraints() {
        firstNameView.translatesAutoresizingMaskIntoConstraints = false
        emailAddressView.translatesAutoresizingMaskIntoConstraints = false
        phoneNumber.translatesAutoresizingMaskIntoConstraints = false
        genderView.translatesAutoresizingMaskIntoConstraints = false
        address.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstNameView.topAnchor.constraint(equalTo: self.topAnchor),
            firstNameView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            firstNameView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            firstNameView.heightAnchor.constraint(equalToConstant: 60),
            
            emailAddressView.topAnchor.constraint(equalTo: firstNameView.bottomAnchor, constant: 10),
            emailAddressView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            emailAddressView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            emailAddressView.heightAnchor.constraint(equalToConstant: 60),
            
            phoneNumber.topAnchor.constraint(equalTo: emailAddressView.bottomAnchor, constant: 10),
            phoneNumber.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            phoneNumber.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            phoneNumber.heightAnchor.constraint(equalToConstant: 60),
            
            genderView.topAnchor.constraint(equalTo: phoneNumber.bottomAnchor, constant: 10),
            genderView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            genderView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            genderView.heightAnchor.constraint(equalToConstant: 60),
            
            address.topAnchor.constraint(equalTo: genderView.bottomAnchor, constant: 10),
            address.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            address.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            address.heightAnchor.constraint(equalToConstant: 60),
            address.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        
        ])
    }
    
}


extension PersonalInformationView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genders[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderView.text = genders[row]
        genderView.resignFirstResponder()
    }
}

extension PersonalInformationView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genders.count
    }
    
    
}
