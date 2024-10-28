//
//  LoanApplicationCDModel+CoreDataProperties.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 29/10/24.
//
//

import Foundation
import CoreData


extension LoanApplicationCDModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LoanApplicationCDModel> {
        return NSFetchRequest<LoanApplicationCDModel>(entityName: "LoanApplicationCDModel")
    }

    @NSManaged public var address: String?
    @NSManaged public var annualIncome: String?
    @NSManaged public var dateSubmitted: Date?
    @NSManaged public var desiredLoanAmount: String?
    @NSManaged public var email: String?
    @NSManaged public var fullName: String?
    @NSManaged public var gender: String?
    @NSManaged public var identifier: UUID?
    @NSManaged public var irdNumber: String?
    @NSManaged public var isComplete: Bool
    @NSManaged public var phoneNumber: String?
    @NSManaged public var applicant: PersonCDModel?

}

extension LoanApplicationCDModel : Identifiable {

}
