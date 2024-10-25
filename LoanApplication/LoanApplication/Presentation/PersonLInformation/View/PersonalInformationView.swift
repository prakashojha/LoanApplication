//
//  PersonalInformationView.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 24/10/24.
//

import Foundation
import UIKit

protocol PersonalInformationDelegate {
    func updatePhoneNumber(withNumber: String)
}

class PersonalInformationView: UIView {
    
    private let viewModel: PersonalInformationViewModel
    
    private lazy var pickerView: UIPickerView = {
        let view = UIPickerView()
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    private lazy var firstNameView: LAUIInputField = {
        let view: LAUIInputField = LAUIInputField(viewModel.firstName, labelText: "Full Name")
        view.textField.delegate = self
        return view
    }()
    
    private lazy var emailAddressView: LAUIInputField = {
        let view: LAUIInputField = LAUIInputField(viewModel.email, labelText: "Email Address")
        view.textField.autocapitalizationType = .none
        view.textField.delegate = self
        return view
    }()
    
    private lazy var phoneNumberView: LAUIInputField = {
        let view: LAUIInputField = LAUIInputField(viewModel.phoneNumber, labelText: "Phone Number (+64 123 456 789)")
        view.textField.keyboardType = .phonePad
        view.textField.delegate = self
        return view
    }()
    
    private lazy var genderView: LAUIInputField = {
        let view: LAUIInputField = LAUIInputField(viewModel.gender, labelText: "Select Gender")
        view.textField.text = viewModel.genders[0]
        view.textField.inputView = pickerView
        view.textField.delegate = self
        return view
    }()
    
    private lazy var addressView: LAUIInputField = {
        let view: LAUIInputField = LAUIInputField(viewModel.address, labelText: "Postal Address")
        return view
    }()
    
    private lazy var button: LAUIButton = {
        let button = LAUIButton(configuration: .personalInformationCustomButton)
        button.addTarget(self, action: #selector(onNextButtonPressed), for: .touchUpInside)
        return button
    }()
    
    init(viewModel: PersonalInformationViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.viewModel.delegate = self
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onNextButtonPressed() {
        viewModel.onNextButtonPressed(
            firstNameView.textField.text,
            emailAddressView.textField.text,
            phoneNumberView.textField.text,
            genderView.textField.text,
            addressView.textField.text
        )
    }
    
    func setupView() {
        self.addSubview(firstNameView)
        self.addSubview(emailAddressView)
        self.addSubview(phoneNumberView)
        self.addSubview(genderView)
        self.addSubview(addressView)
        self.addSubview(button)
    }
    
    func setupConstraints() {
        firstNameView.translatesAutoresizingMaskIntoConstraints = false
        emailAddressView.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberView.translatesAutoresizingMaskIntoConstraints = false
        genderView.translatesAutoresizingMaskIntoConstraints = false
        addressView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstNameView.topAnchor.constraint(equalTo: self.topAnchor),
            firstNameView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: viewModel.gapLeft),
            firstNameView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -viewModel.gapRight),
            firstNameView.heightAnchor.constraint(equalToConstant: viewModel.viewHeight),
            
            emailAddressView.topAnchor.constraint(equalTo: firstNameView.bottomAnchor, constant: viewModel.gapBetween),
            emailAddressView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: viewModel.gapLeft),
            emailAddressView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -viewModel.gapRight),
            emailAddressView.heightAnchor.constraint(equalToConstant: viewModel.viewHeight),
            
            phoneNumberView.topAnchor.constraint(equalTo: emailAddressView.bottomAnchor, constant: viewModel.gapBetween),
            phoneNumberView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: viewModel.gapLeft),
            phoneNumberView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -viewModel.gapRight),
            phoneNumberView.heightAnchor.constraint(equalToConstant: viewModel.viewHeight),
            
            genderView.topAnchor.constraint(equalTo: phoneNumberView.bottomAnchor, constant: viewModel.gapBetween),
            genderView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: viewModel.gapLeft),
            genderView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -viewModel.gapRight),
            genderView.heightAnchor.constraint(equalToConstant: viewModel.viewHeight),
            
            addressView.topAnchor.constraint(equalTo: genderView.bottomAnchor, constant: viewModel.gapBetween),
            addressView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: viewModel.gapLeft),
            addressView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -viewModel.gapRight),
            addressView.heightAnchor.constraint(equalToConstant: viewModel.viewHeight),
            
            button.topAnchor.constraint(equalTo: addressView.bottomAnchor, constant: 50),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            button.heightAnchor.constraint(equalToConstant: 56),
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        
        ])
    }
}

extension PersonalInformationView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension PersonalInformationView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.genders[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderView.textField.text = viewModel.genders[row]
        genderView.textField.resignFirstResponder()
    }
}

extension PersonalInformationView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.genders.count
    }
}

extension PersonalInformationView: PersonalInformationDelegate {
    func updatePhoneNumber(withNumber: String) {
        self.phoneNumberView.textField.text = withNumber
    }
}
