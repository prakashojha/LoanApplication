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
    
    let genders: [String] = ["Male", "Female"]
    let gapBetween: CGFloat = 15.0
    let viewHeight: CGFloat = 78.0
    let gapLeft: CGFloat = 0.0
    let gapRight: CGFloat = 0.0
    
    var firstName: String {
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

        loadNextScreen()
    }
    
    func loadNextScreen() {
        self.coordinator?.loadNextScreen(fromScreen: .PersonalInformationScreen(model: model))
    }
    
    func loadPreviousScreen() {
        //self.coordinator?.loadPreviousScreen(screen: Screen.PersonalInformationScreen, loanData: model)
    }
}
