//
//  HomeScreenViewModel.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 27/10/24.
//

import Foundation
import UIKit
import CoreData

class HomeScreenViewModel {
    
    let context: NSManagedObjectContext
    let coordinator: AppCoordinator?
    
    private var homeScreenModels: [HomeScreenModel] = []
    
    init(context: NSManagedObjectContext, coordinator: AppCoordinator?) {
        self.context = context
        self.coordinator = coordinator
    }
    
    var numberOfRowsInSection: Int {
        return homeScreenModels.count
    }
    
    func cellForAtRow(index: Int) -> HomeScreenModel {
        return homeScreenModels[index]
    }
    
    // get data from core model
    func fetchData() {
        do {
            let loans = try fetchFromCoreData(context: context)
            createModelForCell(loans: loans)
        } catch {
            print("Failed to fetch data: \(error)")
        }
    }
    
    private func createModelForCell(loans: [LoanApplicationCDModel]?) {
        guard let loans = loans else { return }
        
        for loan in loans {
            let model = HomeScreenModel(fullName: loan.fullName ?? "NA" ,
                                        loanAmount: loan.desiredLoanAmount ?? "NA",
                                        dateSubmitted: Helper.formatDate(loan.dateSubmitted) ?? "NA")
            homeScreenModels.append(model)
        }
    }
}

// core data related implementations

extension HomeScreenViewModel {
    func fetchFromCoreData(context: NSManagedObjectContext) throws -> [LoanApplicationCDModel]? {
        let fetchRequest: NSFetchRequest<PersonCDModel> = PersonCDModel.fetchRequest()
        let people = try context.fetch(fetchRequest)
        guard let person = people.first else { return nil }
        guard let loans = person.loans?.allObjects as? [LoanApplicationCDModel] else { return nil }
        
        return loans
    }
}
