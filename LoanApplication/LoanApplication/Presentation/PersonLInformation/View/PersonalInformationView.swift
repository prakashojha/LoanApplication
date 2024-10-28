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
        let view: LAUIInputField = LAUIInputField("John Doe", viewModel.fullName, labelText: "Full Name")
        view.textField.delegate = self
        return view
    }()
    
    private lazy var emailAddressView: LAUIInputField = {
        let view: LAUIInputField = LAUIInputField("Joe@tsb.co.nz", viewModel.email, labelText: "Email Address")
        view.textField.autocapitalizationType = .none
        view.textField.delegate = self
        return view
    }()
    
    private lazy var phoneNumberView: LAUIInputField = {
        let view: LAUIInputField = LAUIInputField("+64220845922",viewModel.phoneNumber, labelText: "Phone Number (+64 123 456 789)")
        view.textField.keyboardType = .phonePad
        view.textField.delegate = self
        return view
    }()
    
    private lazy var genderView: LAUIInputField = {
        let view: LAUIInputField = LAUIInputField(viewModel.gender, labelText: "Select Gender")
        view.textField.text = viewModel.gender
        view.textField.inputView = pickerView
        //view.textField.delegate = self
        return view
    }()
    
    private lazy var addressView: LAUIInputField = {
        let view: LAUIInputField = LAUIInputField("66 Collins Street", viewModel.address, labelText: "Postal Address")
        return view
    }()
    
    private lazy var saveAndExit: LAUIButton = {
        let button: LAUIButton = LAUIButton(configuration: .navigationCustomButton(title: "Save and Exit"))
        button.isEnabled = false
        button.addTarget(self, action: #selector(onSaveAndExitPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton: LAUIButton = {
        let button = LAUIButton(configuration: .navigationCustomButton(title: "Next"))
        button.isEnabled = false
        button.addTarget(self, action: #selector(onNextButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var navigationButtonView: UIStackView = {
        let view: UIStackView = UIStackView()
        view.addArrangedSubview(saveAndExit)
        view.addArrangedSubview(nextButton)
        view.spacing = 10
        return view
    }()
    
    init(viewModel: PersonalInformationViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        setupView()
        setupConstraints()
        updateButtonState()
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
    
    @objc func onSaveAndExitPressed() {
        viewModel.onSaveAndExitPressed(
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
        self.addSubview(navigationButtonView)
    }
    
    func setupConstraints() {
        firstNameView.translatesAutoresizingMaskIntoConstraints = false
        emailAddressView.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberView.translatesAutoresizingMaskIntoConstraints = false
        genderView.translatesAutoresizingMaskIntoConstraints = false
        addressView.translatesAutoresizingMaskIntoConstraints = false
        navigationButtonView.translatesAutoresizingMaskIntoConstraints = false
        
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
            
            navigationButtonView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            navigationButtonView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            navigationButtonView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            navigationButtonView.heightAnchor.constraint(equalToConstant: 44),
            navigationButtonView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        
        ])
    }
}

extension PersonalInformationView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        updateButtonState()
    }
    
    private func updateButtonState() {
        let isAnyFieldNotEmpty = !(firstNameView.textField.text?.isEmpty ?? true) ||
                                !(emailAddressView.textField.text?.isEmpty ?? true) ||
                                !(phoneNumberView.textField.text?.isEmpty ?? true)
        
        saveAndExit.isEnabled = isAnyFieldNotEmpty
        
        let isAllFieldFilled = !(firstNameView.textField.text?.isEmpty ?? false) &&
                               !(emailAddressView.textField.text?.isEmpty ?? false) &&
                               !(phoneNumberView.textField.text?.isEmpty ?? false)
        
        nextButton.isEnabled = isAllFieldFilled
        
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
