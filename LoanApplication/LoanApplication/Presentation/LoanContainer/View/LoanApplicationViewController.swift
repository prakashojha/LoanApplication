//
//  LoanApplicationViewController.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 26/10/24.
//

import UIKit

class LoanApplicationViewController: UIViewController, ShowAlertProtocol, HideKeyboardProtocol {    
    
    let viewModel: LoanApplicationViewModel
    
    init(viewModel: LoanApplicationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Segmented control to show progress
    private lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: viewModel.segments)
        control.selectedSegmentIndex = 0
        control.isUserInteractionEnabled = false // Disable direct interaction
        return control
    }()
    
    // Container view to hold child view controllers
    private let containerView = UIView()
    
    private var currentViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        hideKeyboardWhenTappedAround()
        self.view.backgroundColor = .cyan
    }
    
    // UI setup
    private func setupUI() {
        view.addSubview(segmentedControl)
        view.addSubview(containerView)
    }
    
    func setupConstraints() {
        
        // Add segmented control
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // Add container view for child controllers
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc func dismissKeyboardView() {
        view.endEditing(true)
    }
    
    // Transition to a new child view controller with animation
    func transitionToViewController(_ viewController: UIViewController, progressIndex: Int, animated: Bool, isBackward: Bool = false) {
        segmentedControl.selectedSegmentIndex = progressIndex
        
        // Prepare the new child view controller
        addChild(viewController)
        containerView.addSubview(viewController.view)
        
        // Enable Auto Layout
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            viewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            viewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        
        // Set initial position for incoming view controller
        let initialX = isBackward ? -containerView.frame.width : containerView.frame.width
        viewController.view.transform = CGAffineTransform(translationX: initialX, y: 0)
        
        if animated {
            // Animate sliding transition
            UIView.animate(withDuration: 0.3, animations: {
                // Slide the incoming view into place
                viewController.view.transform = .identity
                
                // Slide the current view out of view
                self.currentViewController?.view.transform = CGAffineTransform(translationX: isBackward ? self.containerView.frame.width : -self.containerView.frame.width, y: 0)
                
            }) { _ in
                // Complete the transition by removing the old view controller
                self.currentViewController?.willMove(toParent: nil)
                self.currentViewController?.view.removeFromSuperview()
                self.currentViewController?.removeFromParent()
                
                // Finalize the new child view controller setup
                viewController.didMove(toParent: self)
                self.currentViewController = viewController
            }
        } else {
            // No animation, just replace the view
            currentViewController?.willMove(toParent: nil)
            currentViewController?.view.removeFromSuperview()
            currentViewController?.removeFromParent()
            
            viewController.didMove(toParent: self)
            currentViewController = viewController
        }
    }
    
}

