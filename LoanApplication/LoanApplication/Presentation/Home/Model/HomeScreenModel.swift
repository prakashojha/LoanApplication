//
//  HomeScreenModel.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 27/10/24.
//

import Foundation
import UIKit


struct HomeScreenModel: Codable {
    var fullName: String
    var loanAmount: String
    var dateSubmitted: String
    var isComplete: Bool
}

struct HomeScreenModelMapper {
    
    static func map(from persons: [PersonCDModel] ) -> [LoanApplicationCDModel] {
        var LoanApplicationCDModels: [LoanApplicationCDModel] = []
        for person in persons {
            guard let loans = person.loans?.allObjects as? [LoanApplicationCDModel] else { return [] }
            for loan in loans {
                LoanApplicationCDModels.append(loan)
            }
        }
        return LoanApplicationCDModels
    }
}
