//
//  LAUILabelView.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 27/10/24.
//

import Foundation
import UIKit


class LAUILabelView: UIView {
    
    var title: String? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.titleView.text = self?.title
            }
        }
    }
    var value: String? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.valueView.text = self?.value
            }
        }
    }
    
    private lazy var titleView: UILabel = {
        let view: UILabel = UILabel()
        view.textColor = UIColor.init(red: 33/255, green: 32/255, blue: 72/255, alpha: 1.0)
        view.text = title
        view.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return view
    }()
    
    private lazy var valueView: UILabel = {
        let view: UILabel = UILabel()
        view.text = value
        view.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        view.textColor = UIColor.init(red: 33/255, green: 36/255, blue: 74/255, alpha: 1.0)
        return view
    }()
    
    init(title: String, value: String) {
        self.title = title
        self.value = value
        super.init(frame: .zero)
        addViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        self.addSubview(titleView)
        self.addSubview(valueView)
    }
    
    func setupConstraints() {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        valueView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            titleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            titleView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            valueView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            valueView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            valueView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
