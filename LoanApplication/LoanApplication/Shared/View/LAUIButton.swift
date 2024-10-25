//
//  LAUIButton.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 25/10/24.
//

import UIKit

class LAUIButton: UIButton {
    
    // Custom initializer with configuration
    init(configuration: UIButton.Configuration) {
        super.init(frame: .zero)
        applyCustomConfiguration(configuration)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // Apply the configuration and enforce tintAdjustmentMode
    private func applyCustomConfiguration(_ configuration: UIButton.Configuration) {
        self.configuration = configuration
        self.tintAdjustmentMode = .normal // Prevents color change when alert is presented
    }
}


extension UIButton.Configuration {
    
    static var personalInformationCustomButton: UIButton.Configuration {
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
