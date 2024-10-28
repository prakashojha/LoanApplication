//
//  AppCoordinator.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 25/10/24.
//

import Foundation
import UIKit
import CoreData

enum Screen {
    case PersonalInformationScreen(model: LoanApplicationModel.PersonalInformationModel)
    case FinancialInformationScreen(model: LoanApplicationModel.FinancialInformationModel)
    case ReviewAndSubmitScreen
    case HomeScreen
}

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    private var loanApplicationViewController: LoanApplicationViewController!
    private let dataService: AnyDataService<LoanApplicationCDModel>
    
    var currentViewController: UIViewController?
    
    var loanApplicationData: LoanApplicationModel
    
    let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init(navigationController: UINavigationController) {
        context.reset()
        self.navigationController = navigationController
        self.loanApplicationData = LoanApplicationModel(id: .init())
        self.dataService = AnyDataService(CoreDataService(context: context, mapper: HomeScreenModelMapper.map))
    }
    
    func start() {
        showHomeScreen()
    }
    
    func LoanApplicationScreen(model: LoanApplicationModel? = nil) {
        if let model = model {
            self.loanApplicationData = model
        }
        else {
            self.loanApplicationData = LoanApplicationModel(id: UUID())
        }
        
        let viewModel = LoanApplicationViewModel(coordinator: self, loanApplicationData: loanApplicationData)
        loanApplicationViewController = LoanApplicationViewController(viewModel: viewModel)
        
        navigationController.pushViewController(loanApplicationViewController, animated: true)
        showPersonalInformationScreen(model: viewModel.getPersonalInformationModel(), animated: false)
    }
    
    func showHomeScreen() {
        let viewModel = HomeScreenViewModel(coordinator: self)
        let homeScreenViewController = HomeScreenViewController(viewModel: viewModel)
        navigationController.pushViewController(homeScreenViewController, animated: true)
        
    }
    
    // Show Personal Info Screen
    private func showPersonalInformationScreen(model: LoanApplicationModel.PersonalInformationModel, animated: Bool, slideOut: Bool = false) {
        let viewModel = PersonalInformationViewModel(model: model, coordinator: self)
        let personalVC = PersonalInformationViewController(viewModel: viewModel)
        currentViewController = personalVC
        loanApplicationViewController.transitionToViewController(personalVC, progressIndex: 0, animated: animated, isBackward: slideOut)
    }
    
    private func showFinancialInformationScreen(model: LoanApplicationModel.FinancialInformationModel, animated: Bool, slideOut: Bool = false) {
        let viewModel = FinancialInformationViewModel(model: model, coordinator: self)
        let financialVC = FinancialInformationViewController(viewModel: viewModel)
        currentViewController = financialVC
        loanApplicationViewController.transitionToViewController(financialVC, progressIndex: 1, animated: animated, isBackward: slideOut)
    }
    
    func showReviewAndSubmitScreen(model: LoanApplicationModel, animated: Bool, slideOut: Bool = false) {
        let viewModel = ReviewAndSubmitViewModel(loanApplicationModel: model, coordinator: self)
        let viewController = ReviewAndSubmitViewController(viewModel: viewModel)
        currentViewController = viewController
        loanApplicationViewController.transitionToViewController(viewController, progressIndex: 2, animated: animated, isBackward: slideOut)
    }
    
    func gotToHomeScreen() {
        self.navigationController.popViewController(animated: true)
    }
    
    func showLoanApplicationScreen(forModel cdModel: LoanApplicationCDModel) {
        print(cdModel)
        let model: LoanApplicationModel = LoanApplicationModel(
            personalInfo: .init(
                fullName: cdModel.fullName ?? "NA",
                email: cdModel.email ?? "NA",
                phoneNumber: cdModel.phoneNumber ?? "NA",
                gender: cdModel.gender ?? "NA",
                address: cdModel.address ?? "NA"
            ),
            financialInfo: .init(
                annualIncome: cdModel.annualIncome ?? "NA",
                desiredLoanAmount: cdModel.desiredLoanAmount ?? "NA",
                irdNumber: cdModel.irdNumber ?? "NA"
            ),
            isComplete: cdModel.isComplete,
            id: cdModel.identifier!
        )
        
        LoanApplicationScreen(model: model)
    }
    
    func loadNextScreen(fromScreen: Screen) {
        switch(fromScreen) {
            
        case let .PersonalInformationScreen(model):
            loanApplicationData.personalInfo = model
            showFinancialInformationScreen(model: loanApplicationData.financialInfo, animated: true)
        case let .FinancialInformationScreen(model):
            loanApplicationData.financialInfo = model
            showReviewAndSubmitScreen(model: loanApplicationData, animated: true)
        case .ReviewAndSubmitScreen:
            break
        case .HomeScreen:
            LoanApplicationScreen()
        }
    }
    
    func loadPreviousScreen(fromScreen: Screen) {
        switch(fromScreen) {
            
        case .PersonalInformationScreen(_):
            break
        case let .FinancialInformationScreen(model):
            loanApplicationData.financialInfo = model
            showPersonalInformationScreen(model: loanApplicationData.personalInfo, animated: true, slideOut: true)
        case .ReviewAndSubmitScreen:
            break
        case .HomeScreen:
            break
        }
    }
    
    func onSubmitButtonPressed(model: LoanApplicationModel) {
        var model = model
        model.isComplete = true
        updateCoreData(id: model.id, model: model) { [weak self] result in
            switch(result) {
            case .success(_):
                self?.showSuccessScreen()
            case .failure(let error ):
                self?.showAlert(message: "\(error.localizedDescription)", completion: nil)
            }
        }
    }
    
    private func _saveToCoreDataAndExit(model: LoanApplicationModel) {
        updateCoreData(id: model.id, model: model) { result in
            switch(result) {
            case .success(_):
                DispatchQueue.main.async{
                    self.gotToHomeScreen()
                }
            case .failure(let error ):
                print("error save app \(error.localizedDescription)")
            }
        }
    }

    
    func saveAndExit(fromScreen: Screen) {
        switch(fromScreen) {
            
        case .PersonalInformationScreen(model: let model):
            showAlterWithCancel(message: "Are you sure to save and exit?") { [weak self ] in
                if var loanApplicationData = self?.loanApplicationData {
                    loanApplicationData.personalInfo = .init(fullName: model.fullName, email: model.email, phoneNumber: model.phoneNumber, gender: model.gender, address: model.address)
                    loanApplicationData.isComplete = false
                    self?.loanApplicationData = loanApplicationData
                    self?._saveToCoreDataAndExit(model: loanApplicationData)
                }
            }
            
        case .FinancialInformationScreen(model: let model):
            
            showAlterWithCancel(message: "Are you sure to save and exit?") { [weak self ] in
                if var loanApplicationData = self?.loanApplicationData {
                    loanApplicationData.financialInfo = .init(annualIncome: model.annualIncome, desiredLoanAmount: model.desiredLoanAmount, irdNumber: model.irdNumber)
                    loanApplicationData.isComplete = false
                    self?.loanApplicationData = loanApplicationData
                    self?._saveToCoreDataAndExit(model: loanApplicationData)
                }
            }
                        
        case .ReviewAndSubmitScreen:
            break
        case .HomeScreen:
            break
        }
    }
    
    
    func showSuccessScreen() {
        if let vc = currentViewController as? ReviewAndSubmitViewController {
            if let pc = vc.parent as? LoanApplicationViewController {
                pc.view.backgroundColor = .systemMint.withAlphaComponent(0.8)
            }
            
            vc.showAlert(
                title: "Congratulations!!",
                message: "Your loan request is submitted successfully",
                completion: { [weak self] in
                    self?.gotToHomeScreen()
                })
        }
    }
    
    func showAlterWithCancel(title: String = "Alert", message: String, completion: (()->Void)?) {
        if let currentViewController = currentViewController {
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                completion?()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            currentViewController.present(alertController, animated: true)
        }
    }
    
    func showAlert(title: String = "Alert", message: String, completion: (()->Void)?) {
        if let currentViewController = currentViewController {
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel) { _ in
                completion?()
            }
            alertController.addAction(action)
            currentViewController.present(alertController, animated: true)
        }
    }
    
    func onEditButtonPressed() {
        guard let vc = currentViewController as? ReviewAndSubmitViewController else { return }
        
        let actionSheet = UIAlertController(title: "Edit Information", message: "Which section would you like to edit?", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Personal Info", style: .default, handler: { [self] _ in
            self.showPersonalInformationScreen(model: loanApplicationData.personalInfo, animated: true)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Financial Info", style: .default, handler: { [self] _ in
            self.showFinancialInformationScreen(model: loanApplicationData.financialInfo, animated: true)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        vc.present(actionSheet, animated: true, completion: nil)
    }
}


extension AppCoordinator {
    
    private func getDictModelData(loanApplicationModel: LoanApplicationModel) -> [String: Any]{
        var dictModel: [String: Any] = [:]
        dictModel["fullName"] = loanApplicationModel.personalInfo.fullName
        dictModel["email"] = loanApplicationModel.personalInfo.email
        dictModel["phoneNumber"] = loanApplicationModel.personalInfo.phoneNumber
        dictModel["gender"] = loanApplicationModel.personalInfo.gender
        dictModel["address"] = loanApplicationModel.personalInfo.address
        dictModel["annualIncome"] = loanApplicationModel.financialInfo.annualIncome
        dictModel["desiredLoanAmount"] = loanApplicationModel.financialInfo.desiredLoanAmount
        dictModel["irdNumber"] = loanApplicationModel.financialInfo.irdNumber
        dictModel["isComplete"] = loanApplicationModel.isComplete
        dictModel["dateSubmitted"] = Date()
        
        return dictModel
    }
    
    private func createModelForCoreData(loanApplicationModel: LoanApplicationModel) -> LoanApplicationCDModel {
       
        let model = LoanApplicationCDModel(context: context)
        
        model.fullName = loanApplicationModel.personalInfo.fullName
        model.email = loanApplicationModel.personalInfo.email
        model.phoneNumber = loanApplicationModel.personalInfo.phoneNumber
        model.gender = loanApplicationModel.personalInfo.gender
        model.address = loanApplicationModel.personalInfo.address
        model.annualIncome = loanApplicationModel.financialInfo.annualIncome
        model.desiredLoanAmount = loanApplicationModel.financialInfo.desiredLoanAmount
        model.irdNumber = loanApplicationModel.financialInfo.irdNumber
        model.isComplete = loanApplicationModel.isComplete
        model.dateSubmitted = Date()
        
        return model
    }
    
    func fetchFromCoreData(completion: @escaping (Result<[LoanApplicationCDModel], Error>) -> Void) {
        dataService.fetchData(completion: completion)
    }
    
    func saveToCoreData(model: LoanApplicationModel, completion: @escaping (Result<Bool, Error>) -> Void){
        let person = PersonCDModel(context: context)
        let loan = createModelForCoreData(loanApplicationModel: model)
        loan.identifier = model.id
        person.addToLoans(loan)
        dataService.saveData(completion: completion)
    }
    
    func deleteFromCoreData(item: LoanApplicationCDModel, completion: @escaping (Result<Bool, Error>) -> Void) {
        dataService.deleteData(forObject: item, completion: completion)
    }
    
    func updateCoreData(id: UUID, model: LoanApplicationModel, completion: @escaping (Result<Bool, Error>) -> Void) {
        let cdModel = createModelForCoreData(loanApplicationModel: model)
        if let entityService = dataService.getEntityToUpdate(withId: id, object: cdModel) {
            let dictModel = getDictModelData(loanApplicationModel: model)
            dataService.updateData(entityToUpdate: entityService, object: dictModel, completion: completion)
            
        }
        else{
            saveToCoreData(model: model, completion: completion)
        }
    }
}
