//
//  HomeScreenViewModel.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 27/10/24.
//

import Foundation
import UIKit

class HomeScreenViewModel {
    
   // let dataService: AnyDataService<LoanApplicationCDModel>
    let coordinator: AppCoordinator?
    
    private var homeScreenModels: [HomeScreenModel] = []
    private var loanApplicationDataCD: [LoanApplicationCDModel] = []
    
    init(coordinator: AppCoordinator?) {
        //self.dataService = dataService
        self.coordinator = coordinator
    }
    
    var numberOfRowsInSection: Int {
        return homeScreenModels.count
    }
    
    func cellForAtRow(index: Int) -> HomeScreenModel {
        return homeScreenModels[index]
    }
    
    func onLoanFileSelected(index: Int) {
        if !homeScreenModels[index].isComplete {
            coordinator?.showLoanApplicationScreen(forModel: loanApplicationDataCD[index])
        }
    }
    
    // get data from core model
    func fetchData(completion: @escaping (Result<Bool, Error>) -> Void) {
        self.loanApplicationDataCD = []
        coordinator?.fetchFromCoreData{ [weak self ] result in
            switch(result) {
            case .success(let data):
                self?.loanApplicationDataCD = data
                self?.createDataForView(loanData: data)
                completion(.success(self?.loanApplicationDataCD.count != 0))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func createDataForView(loanData: [LoanApplicationCDModel]) {
        homeScreenModels = []
        for loan in loanData {
            let homeScreenModel = HomeScreenModel(
                fullName: loan.fullName ?? "NA" ,
                loanAmount: loan.desiredLoanAmount ?? "NA",
                dateSubmitted: Helper.formatDate(loan.dateSubmitted) ?? "NA",
                isComplete: loan.isComplete
            )
            homeScreenModels.append(homeScreenModel)
        }
    }
    
    func deleteItem(at index: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let item = loanApplicationDataCD[index]
        coordinator?.deleteFromCoreData(item: item){ [weak self ] result in
            switch(result) {
            case .success(let status):
                self?.homeScreenModels.remove(at: index)
                self?.loanApplicationDataCD.remove(at: index)
                completion(.success(status))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func applyNewLoan() {
        coordinator?.loadNextScreen(fromScreen: .HomeScreen)
    }
}
