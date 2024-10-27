//
//  PersonCDModel+CoreDataProperties.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 27/10/24.
//
//

import Foundation
import CoreData


extension PersonCDModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonCDModel> {
        return NSFetchRequest<PersonCDModel>(entityName: "PersonCDModel")
    }

    @NSManaged public var loans: NSSet?

}

// MARK: Generated accessors for loans
extension PersonCDModel {

    @objc(addLoansObject:)
    @NSManaged public func addToLoans(_ value: LoanApplicationCDModel)

    @objc(removeLoansObject:)
    @NSManaged public func removeFromLoans(_ value: LoanApplicationCDModel)

    @objc(addLoans:)
    @NSManaged public func addToLoans(_ values: NSSet)

    @objc(removeLoans:)
    @NSManaged public func removeFromLoans(_ values: NSSet)

}

extension PersonCDModel : Identifiable {

}
