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
   
    private var model: PersonalInformationModel
    
    var delegate: PersonalInformationDelegate?
    var alertMessage: AlertType?
    var coordinator: AppCoordinator?
    
    init(model: PersonalInformationModel, coordinator: AppCoordinator) {
        self.model = model
        self.coordinator = coordinator
    }
    
    let genders: [String] = ["Male", "Female"]
    let gapBetween: CGFloat = 15.0
    let viewHeight: CGFloat = 60.0
    let gapLeft: CGFloat = 12.0
    let gapRight: CGFloat = 12.0
    
    var firstName: String {
        get { model.firstName }
        set { model.firstName = newValue}
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
    
    private func trimSpace(from text: String?) -> String? {
        guard let text = text else { return nil }
        return text.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    private func isValidString(_ checkString: String?) -> String? {
        guard let checkString = trimSpace(from: checkString), !checkString.isEmpty else { return nil }
        return checkString
    }
    
    private  func isValidPhone(phoneNumber: String) -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phoneNumber)
    }
    
    private func isValidEmailAddress(email: String?) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    private func checkFirstNameIsValid(firstName: String?) -> String? {
        guard let trimmedFirstName = isValidString(firstName) else {
            alertMessage?("First Name cannot be empty"){}
            return nil
        }
        
        return trimmedFirstName
    }
    
    private func checkEmailIsValid(email: String?) -> String? {
        guard let trimmedEmail = isValidString(email) else {
            alertMessage?("Email cannot be empty"){}
            return nil
        }
        
        guard isValidEmailAddress(email: trimmedEmail) else {
            alertMessage?("Invalid Email. Enter valid email address"){}
            return nil
        }
        
        return trimmedEmail
    }
    
    private func checkPhoneNumberIsValid(phoneNumber: String?) -> String? {
        guard let trimmedPhoneNumber = isValidString(phoneNumber) else {
            alertMessage?("Phone Number cannot be empty"){}
            return nil
        }
        
        guard isValidPhone(phoneNumber: trimmedPhoneNumber) else {
            alertMessage?("Invalid phone number. Enter valid number"){}
            return nil
        }

        return trimmedPhoneNumber
    }
   
    func updateModel(firstName: String, email: String, phoneNumber: String, gender: String, address: String) {
        self.firstName = firstName
        self.email = email
        self.phoneNumber = phoneNumber
        self.gender = gender
        self.address = address
    }
    
    func onNextButtonPressed(_ firstName: String?, _ email: String?, _ phoneNumber: String?, _ gender: String?, _ address: String?) {
        
        guard let firstName = checkFirstNameIsValid(firstName: firstName) else { return }
        guard let email = checkEmailIsValid(email: email) else { return }
        guard let phoneNumber = checkPhoneNumberIsValid(phoneNumber: phoneNumber) else { return }
        
        self.updateModel(firstName: firstName, email: email, phoneNumber: phoneNumber, gender: gender!, address: address ?? "Not provided")
        
        self.coordinator?.loadNextScreen(screen: Screens.PersonalInformationScreen)
    }
}
