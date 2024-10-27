//
//  Helper.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 25/10/24.
//

import Foundation

struct Helper {
    
    // Allow only digits and one period
    static func containOnlyDigitsAndDecimal(string: String) -> Bool {
        if !CharacterSet(charactersIn: "0123456789.").isSuperset(of: CharacterSet(charactersIn: string)) {
            return false
        }
        return true
    }
    
    // Ensure only one period exists
    static func periodCountIsGreaterThanOne(text: String) -> Bool {
        let periodCount = text.filter { $0 == "." }.count
        if periodCount > 1 {
            return true
        }
        return false
    }
    
    static func trimSpace(from text: String?) -> String? {
        guard let text = text else { return nil }
        return text.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    static func isValidString(_ checkString: String?) -> String? {
        guard let checkString = trimSpace(from: checkString), !checkString.isEmpty else { return nil }
        return checkString
    }
    
    static func isValidPhone(phoneNumber: String) -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phoneNumber)
    }
    
    static func isValidEmailAddress(email: String?) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    static func isValidAmount(amount: String) -> Bool {
        let incomeRegex = #"^\$[0-9]{1,3}(?:,[0-9]{3})*(?:\.[0-9]{2})?$"#
        let incomeTest = NSPredicate(format: "SELF MATCHES %@", incomeRegex)
        return incomeTest.evaluate(with: amount)
    }
    
    static func convertDollarIncomeToDouble(income: String) -> Double? {
        let sanitizedIncome = income.replacingOccurrences(of: "[$,]", with: "", options: .regularExpression)
        return Double(sanitizedIncome)
    }
    
    // Helper function to format with commas
    static func formatWithCommas(_ number: String) -> String {
        // Split the number into integer and decimal parts
        let components = number.split(separator: ".")
        // Check if there are components to prevent out-of-bound access
        guard !components.isEmpty else { return "" }
        let integerPart = components[0]
        let decimalPart = components.count > 1 ? String(components[1]) : ""
        
        // Format the integer part with commas
        var formattedInteger = ""
        for (index, digit) in integerPart.reversed().enumerated() {
            if index > 0 && index % 3 == 0 {
                formattedInteger.insert(",", at: formattedInteger.startIndex)
            }
            formattedInteger.insert(digit, at: formattedInteger.startIndex)
        }
        
        // Combine integer part, decimal part, and add the $ symbol
        let formattedResult = decimalPart.isEmpty ? "$\(formattedInteger)" : "$\(formattedInteger).\(decimalPart)"
        
        return formattedResult
    }
    
    static func formatWithHyphens(_ number: String) -> String {
        var result = ""
        for (index, digit) in number.enumerated() {
            if index > 0 && index % 3 == 0 {
                result.append("-")
            }
            result.append(digit)
        }
        return result
    }
    
    static func formatDate(_ date: Date?) -> String? {
        guard let date = date else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy 'at' h:mm a"
        dateFormatter.amSymbol = "am"
        dateFormatter.pmSymbol = "pm"
        return dateFormatter.string(from: date)
    }

}
