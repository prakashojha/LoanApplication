//
//  FinancialInformationViewModel.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 25/10/24.
//

import Foundation

class FinancialInformationViewModel {
    
    typealias Completion = () -> Void
    typealias AlertType = ( _: String, _: Completion? ) -> Void
   
    private var model: LoanApplicationModel.FinancialInformationModel
    
    var alertMessage: AlertType?
    var coordinator: AppCoordinator?
    
    init(model: LoanApplicationModel.FinancialInformationModel, coordinator: AppCoordinator) {
        self.model = model
        self.coordinator = coordinator
    }
    
    let gapBetween: CGFloat = 15.0
    let viewHeight: CGFloat = 78.0
    let gapLeft: CGFloat = 0.0
    let gapRight: CGFloat = 0.0
    
    var annualIncome: String {
        get { model.annualIncome }
        set { model.annualIncome = newValue }
    }
    
    var desiredLoanAmount: String {
        get { model.desiredLoanAmount }
        set { model.desiredLoanAmount = newValue }
    }
    
    var irdNumber: String {
        get { model.irdNumber }
        set { model.irdNumber = newValue }
    }
    
    func containValidAmount(updatedText: String, replacementString: String) -> Bool {
        guard Helper.containOnlyDigitsAndDecimal(string: replacementString ) else { return false }
        // Ensure only one period exists
        guard !Helper.periodCountIsGreaterThanOne(text: updatedText) else { return false }
        return true
    }
    
    func getFormattedText(_ updatedText: String, _ replacementString: String, _ tag: Int) -> String? {
        var formattedText: String?
        // Format the text when not editing (e.g., on losing focus)
        if replacementString.isEmpty || !replacementString.contains(".") {
            // Remove non-digit characters except "."
            let digitsAndDecimalOnly = updatedText.replacingOccurrences(of: "[^0-9.]", with: "", options: .regularExpression)
            
            // Format based on tag
            if tag == 3 {
                formattedText = Helper.formatWithHyphens(digitsAndDecimalOnly)
            } else {
                formattedText = Helper.formatWithCommas(digitsAndDecimalOnly)
            }
        }
        return formattedText
    }
    
    func checkAnnualIncomeIsValid(annualIncome: String?) -> String? {
        guard let trimmedIncome = Helper.isValidString(annualIncome) else {
            alertMessage?("Annual Income cannot be empty"){}
            return nil
        }
        
        guard Helper.isValidAmount(amount: trimmedIncome) else {
            alertMessage?("Invalid Annual Income. [$], [comma separated] required. Round up-to 2 digits"){}
            return nil
        }
        
        return trimmedIncome
    }
    
    func checkDesiredLoanAmountIsValid(desiredLoanAmount: String?, annualIncome: String) -> String? {
        guard let trimmedDesiredLoanAmount = Helper.isValidString(desiredLoanAmount) else {
            alertMessage?("Loan Amount cannot be empty"){}
            return nil
        }
        
        guard Helper.isValidAmount(amount: trimmedDesiredLoanAmount) else {
            alertMessage?("Invalid Loan Amount. [$], [comma separated] required. Round up-to 2 digits"){}
            return nil
        }
        
        guard let annualIncomeDouble = Helper.convertDollarIncomeToDouble(income: annualIncome) else {
            alertMessage?("Invalid Annual Income"){}
            return nil
        }
        
        guard let desiredLoanDouble = Helper.convertDollarIncomeToDouble(income: trimmedDesiredLoanAmount) else {
            alertMessage?("Invalid Loan Amount"){}
            return nil
        }
        
        guard desiredLoanDouble <= annualIncomeDouble/2 else {
            alertMessage?("Loan amount must not exceed 50% of Annual Income"){}
            return nil
        }
        
        return trimmedDesiredLoanAmount
    }
    
    func onNextButtonPressed(_ annualIncome: String?, _ desiredLoanAmount: String?, irdNumber: String?) {
        guard let annualIncome = checkAnnualIncomeIsValid(annualIncome: annualIncome) else { return }
        guard let desiredLoanAmount = checkDesiredLoanAmountIsValid(desiredLoanAmount: desiredLoanAmount, annualIncome: annualIncome) else { return }
    }
    
    func onPreviousButtonPressed() {
        coordinator?.loadPreviousScreen(fromScreen: .FinancialInformationScreen(model: model))
    }
}
