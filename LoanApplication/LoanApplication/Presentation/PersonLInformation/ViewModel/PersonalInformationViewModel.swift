//
//  PersonalInformationViewModel.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 25/10/24.
//

import Foundation

final class PersonalInformationViewModel {
    typealias Completion = () -> Void
    typealias AlertType = ( _: String, _: Completion? ) -> Void
   
    private var model: LoanApplicationModel.PersonalInformationModel
    
    var alertMessage: AlertType?
    var coordinator: AppCoordinator?
    
    init(model: LoanApplicationModel.PersonalInformationModel, coordinator: AppCoordinator) {
        self.model = model
        self.coordinator = coordinator
    }
    
    let genders: [String] = ["Other", "Male", "Female"]
    let gapBetween: CGFloat = 15.0
    let viewHeight: CGFloat = 78.0
    let gapLeft: CGFloat = 0.0
    let gapRight: CGFloat = 0.0
    
    var selectedGenderIndex: Int = 0 // Default to first item
    
    var fullName: String {
        get { model.fullName }
        set { model.fullName = newValue}
    }
    
    var email: String {
        get { model.email }
        set { model.email = newValue}
    }
    
    var phoneNumber: String {
        get { model.phoneNumber }
        set { model.phoneNumber = newValue }
    }
    
    var gender: String {
        get { model.gender }
        set { model.gender = newValue }
    }
    
    var address: String {
        get { model.address }
        set { model.address = newValue }
    }
    
    private func checkFirstNameIsValid(firstName: String?) -> String? {
        guard let trimmedFirstName = Helper.isValidString(firstName) else {
            alertMessage?("Full Name cannot be empty"){}
            return nil
        }
        
        return trimmedFirstName
    }
    
    private func checkEmailIsValid(email: String?) -> String? {
        guard let trimmedEmail = Helper.isValidString(email) else {
            alertMessage?( "Email cannot be empty"){}
            return nil
        }
        
        guard Helper.isValidEmailAddress(email: trimmedEmail) else {
            alertMessage?("Invalid Email. Enter valid email address"){}
            return nil
        }
        
        return trimmedEmail
    }
    
    private func checkPhoneNumberIsValid(phoneNumber: String?) -> String? {
        guard let trimmedPhoneNumber = Helper.isValidString(phoneNumber) else {
            alertMessage?("Phone Number cannot be empty"){}
            return nil
        }
        
        guard Helper.isValidPhone(phoneNumber: trimmedPhoneNumber) else {
            alertMessage?("Invalid phone number. Enter valid number"){}
            return nil
        }

        return trimmedPhoneNumber
    }
   
    func updateModel(_ fullName: String, _ email: String, _ phoneNumber: String, _ gender: String, _ address: String) {
        self.fullName = fullName
        self.email = email
        self.phoneNumber = phoneNumber
        self.gender = gender
        self.address = address
    }
    
    private func verifyItemsValidity(_ fullName: String?, _ email: String?, _ phoneNumber: String?) -> (String, String, String)? {
        guard let validFullName = checkFirstNameIsValid(firstName: fullName) else { return nil }
        guard let validEmail = checkEmailIsValid(email: email) else { return nil }
        guard let validPhoneNumber = checkPhoneNumberIsValid(phoneNumber: phoneNumber) else { return nil }
        
        return (validFullName, validEmail, validPhoneNumber)
    }
    
    func onNextButtonPressed(_ fullName: String?, _ email: String?, _ phoneNumber: String?, _ gender: String?, _ address: String?) {
        
        guard let items = verifyItemsValidity(fullName, email, phoneNumber) else { return }
        updateModel(items.0, items.1, items.2, gender!, address ?? "Not provided")
        loadNextScreen()
    }
    
    func loadNextScreen() {
        self.coordinator?.loadNextScreen(fromScreen: .PersonalInformationScreen(model: model))
    }
    
    func onSaveAndExitPressed(_ fullName: String?, _ email: String?, _ phoneNumber: String?, _ gender: String?, _ address: String?) {
        var validName: String = ""
        var validEmail: String = ""
        var validPhone: String = ""
        
        if let fullName = fullName, !fullName.isEmpty, let validFullName = checkFirstNameIsValid(firstName: fullName) {
            validName = validFullName
        }
        if let email = email, !email.isEmpty, let verifiedEmail = checkEmailIsValid(email: email) {
            validEmail = verifiedEmail
        }
        
        if let phoneNumber = phoneNumber, !phoneNumber.isEmpty, let validPhoneNumber = checkPhoneNumberIsValid(phoneNumber: phoneNumber) {
            validPhone = validPhoneNumber
        }
        
        updateModel(validName, validEmail, validPhone, gender!, address ?? "Not provided")
        coordinator?.saveAndExit(fromScreen: .PersonalInformationScreen(model: model))
        
    }
    
}
