//
//  AppCoordinator.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 25/10/24.
//

import Foundation
import UIKit

enum Screen {
    case PersonalInformationScreen(model: LoanApplicationModel.PersonalInformationModel)
    case FinancialInformationScreen(model: LoanApplicationModel.FinancialInformationModel)
    case ReviewAndSubmitScreen
    case HomeScreen
}

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    // Starts the coordinator flow
    func start()
}

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    private var loanApplicationViewController: LoanApplicationViewController!
    
    var loanApplicationData: LoanApplicationModel
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        loanApplicationData = LoanApplicationModel()
    }
    
    func start() {
        let viewModel = LoanApplicationViewModel(coordinator: self, loanApplicationData: loanApplicationData)
        loanApplicationViewController = LoanApplicationViewController(viewModel: viewModel)
       
        navigationController.pushViewController(loanApplicationViewController, animated: true)
        //showPersonalInformationScreen(model: viewModel.getPersonalInformationModel(), animated: false)
        showReviewAndSubmitScreen(model: loanApplicationData, animated: false)
    }
    
    // Show Personal Info Screen
    private func showPersonalInformationScreen(model: LoanApplicationModel.PersonalInformationModel, animated: Bool, slideOut: Bool = false) {
        //let model = loanApplicationViewModel.getPersonalInformationModel()
        let viewModel = PersonalInformationViewModel(model: model, coordinator: self)
        let personalVC = PersonalInformationViewController(viewModel: viewModel)
        loanApplicationViewController.transitionToViewController(personalVC, progressIndex: 0, animated: animated, isBackward: slideOut)
    }
    
    private func showFinancialInformationScreen(model: LoanApplicationModel.FinancialInformationModel, animated: Bool, slideOut: Bool = false) {
        //let model = loanApplicationViewModel.getFinancialInformationModel()
        let viewModel = FinancialInformationViewModel(model: model, coordinator: self)
        let financialVC = FinancialInformationViewController(viewModel: viewModel)
        loanApplicationViewController.transitionToViewController(financialVC, progressIndex: 1, animated: animated, isBackward: slideOut)
    }
    
    func showReviewAndSubmitScreen(model: LoanApplicationModel, animated: Bool, slideOut: Bool = false) {
        let viewModel = ReviewAndSubmitViewModel(loanApplicationModel: model, coordinator: self)
        let viewController = ReviewAndSubmitViewController(viewModel: viewModel)
        loanApplicationViewController.transitionToViewController(viewController, progressIndex: 2, animated: animated, isBackward: slideOut)
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
            break
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
    
}
