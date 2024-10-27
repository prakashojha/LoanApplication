//
//  ReviewAndSubmitViewCell.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 27/10/24.
//

import Foundation
import UIKit

class ReviewAndSubmitViewCell: UITableViewCell {
    
    var model: ReviewAndSubmitModel? {
        didSet {
            titleView.text = model?.title
            valueView.text = model?.value
        }
    }
    
    private lazy var titleView: UILabel = {
        let view: UILabel = UILabel()
        view.textColor = .gray
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return view
    }()
    
    private lazy var valueView: UILabel = {
        let view: UILabel = UILabel()
        view.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        view.textColor = .black
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.contentView.addSubview(titleView)
        self.contentView.addSubview(valueView)
    }
    
    func setupConstraints() {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            titleView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
            titleView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        ])
        
        valueView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            valueView.topAnchor.constraint(equalTo: self.titleView.bottomAnchor,constant: 2),
            valueView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
            valueView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            valueView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
        ])
    }
}
