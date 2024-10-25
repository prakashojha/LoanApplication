//
//  AppCoordinator.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 25/10/24.
//

import Foundation
import UIKit

enum Screens {
    case PersonalInformationScreen
    case FinancialInformationScreen
    case ReviewAndSubmitScreen
    case HomeScreen
}

protocol Coordinator {
    var childCoordinators: [Coordinator] { get}
    func start()
    
}

class AppCoordinator: Coordinator {
    let window: UIWindow
    private(set) var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController = UINavigationController()
    
    init(window: UIWindow) {
        self.window = window
    }
    func start() {
        presentPersonalInformationScreen()
    }
    
    func presentPersonalInformationScreen() {
        let model = PersonalInformationModel()
        let viewModel = PersonalInformationViewModel(model: model, coordinator: self)
        let viewController = LoanApplicationViewController(viewModel: viewModel)
        
        navigationController.setViewControllers([viewController], animated: false)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func presentFinancialInformationScreen() {
        let viewController = FinancialInformationViewController()
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func presentReviewAndSubmitScreen() {
        
    }
    
    func presentHomeScreen() {
        
    }
    
    func loadNextScreen(screen: Screens) {
        switch(screen){
            
        case .PersonalInformationScreen:
            presentFinancialInformationScreen()
        case .FinancialInformationScreen:
            presentReviewAndSubmitScreen()
        case .ReviewAndSubmitScreen:
            presentHomeScreen()
        case .HomeScreen:
            presentPersonalInformationScreen()
        }
    }
}
