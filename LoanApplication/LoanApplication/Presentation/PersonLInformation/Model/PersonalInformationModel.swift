//
//  PersonalInformationModel.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 25/10/24.
//

import Foundation

struct PersonalInformationModel {
    var firstName: String
    var email: String
    var phoneNumber: String
    var gender: String
    var address: String
    
    init(
        firstName: String = "John Doe",
        email: String = "john@tbs.co.nz",
        phoneNumber: String = "+64220764933",
        gender: String = "Male",
        address: String = "66 collins street, taranaki"
    ) {
        self.firstName = firstName
        self.email = email
        self.phoneNumber = phoneNumber
        self.gender = gender
        self.address = address
    }
}
