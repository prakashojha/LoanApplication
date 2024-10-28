//
//  LAUIButton.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 25/10/24.
//

import UIKit

class LAUIButton: UIButton {
    
    // Custom initializer with configuration
    init(configuration: UIButton.Configuration?=nil) {
        super.init(frame: .zero)
        applyCustomConfiguration(configuration)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // Apply the configuration and enforce tintAdjustmentMode
    private func applyCustomConfiguration(_ configuration: UIButton.Configuration?) {
        if let configuration = configuration {
            self.configuration = configuration
        }
        self.tintAdjustmentMode = .normal // Prevents color change when alert is presented
    }
}


extension UIButton.Configuration {
    
    static func navigationCustomButton(title: String, fontSize: CGFloat = 14) -> UIButton.Configuration {
        var container = AttributeContainer()
        container.font = UIFont.boldSystemFont(ofSize: fontSize)
        
        var config = UIButton.Configuration.filled()
        config.titleAlignment = .center
        config.baseBackgroundColor = UIColor.init(red: 26/255, green: 18/255, blue: 77/255, alpha: 1.0)
        config.baseForegroundColor = .white
        //config.background.strokeColor = .lightGray
        //config.background.strokeWidth = 2.0
        config.cornerStyle = .medium
        config.attributedTitle = AttributedString(title, attributes: container)
        
        return config
    }
    
    static var newLoanCustomButton: UIButton.Configuration {
        var container = AttributeContainer()
        container.font = UIFont.boldSystemFont(ofSize: 18)
        
        var config = UIButton.Configuration.filled()
        config.titleAlignment = .center
        config.baseBackgroundColor = UIColor.init(red: 26/255, green: 18/255, blue: 77/255, alpha: 1.0)
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        config.attributedTitle = AttributedString("New Loan", attributes: container)
        
        return config
    }
    
    static var personalInformationCustomButton: UIButton.Configuration {
        var container = AttributeContainer()
        container.font = UIFont.boldSystemFont(ofSize: 18)
        
        var config = UIButton.Configuration.filled()
        config.titleAlignment = .center
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.cornerStyle = .medium
        config.attributedTitle = AttributedString("Next", attributes: container)
        
        return config
    }
    
    static var financialInformationCustomButton: UIButton.Configuration {
        var container = AttributeContainer()
        container.font = UIFont.boldSystemFont(ofSize: 28)
        
        var config = UIButton.Configuration.filled()
        config.titleAlignment = .center
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.background.strokeColor = .lightGray
        config.background.strokeWidth = 2.0
        config.cornerStyle = .capsule
        config.attributedTitle = AttributedString("Next", attributes: container)
        
        return config
    }
}
