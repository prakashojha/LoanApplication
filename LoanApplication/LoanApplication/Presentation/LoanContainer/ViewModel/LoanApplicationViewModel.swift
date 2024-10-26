//
//  LoanApplicationViewModel.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 26/10/24.
//

import Foundation
import UIKit

class LoanApplicationViewModel {
    
    var coordinator: AppCoordinator?
    var loanApplicationData: LoanApplicationModel
    
    let segments = ["Personal", "Financial", "Review"]

    init(
        coordinator: AppCoordinator? = nil,
        loanApplicationData: LoanApplicationModel
    ) {
        self.coordinator = coordinator
        self.loanApplicationData = loanApplicationData
    }
    
    func getPersonalInformationModel() -> LoanApplicationModel.PersonalInformationModel {
        return loanApplicationData.personalInfo
    }
    
    func getFinancialInformationModel() -> LoanApplicationModel.FinancialInformationModel {
        return loanApplicationData.financialInfo
    }
}
