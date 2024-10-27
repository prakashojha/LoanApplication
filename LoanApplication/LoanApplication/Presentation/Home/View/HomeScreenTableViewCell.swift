//
//  HomeScreenTableViewCell.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 27/10/24.
//

import UIKit

class HomeScreenTableViewCell: UITableViewCell {
    
    var cellViewModel: HomeScreenModel? {
        didSet {
            DispatchQueue.main.async { [weak self ] in
                self?.nameView.value = self?.cellViewModel?.fullName
                self?.loanAmountView.value = self?.cellViewModel?.loanAmount
                self?.dateSubmittedView.value = self?.cellViewModel?.dateSubmitted
            }
        }
    }
    
    private lazy var nameView: LAUILabelView = {
        let view = LAUILabelView(title: "Name", value: "NA")
        return view
    }()
    
    private lazy var loanAmountView: LAUILabelView = {
        let view = LAUILabelView(title: "Loan Amount", value: "NA")
        return view
    }()
    
    private lazy var dateSubmittedView: LAUILabelView = {
        let view = LAUILabelView(title: "Date Submitted", value: "NA")
        return view
    }()
    
    private lazy var containerView: UIView = {
       let view = UIView()
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
        
        contentView.addSubview(containerView)
        containerView.addSubview(nameView)
        containerView.addSubview(loanAmountView)
        containerView.addSubview(dateSubmittedView)
        
        containerView.backgroundColor = .white // Set background color for visibility
        containerView.layer.cornerRadius = 8   // Optional rounded corners
        containerView.layer.masksToBounds = true
        
        containerView.backgroundColor = .white
        
    }
    
    func setupConstraints() {
        nameView.translatesAutoresizingMaskIntoConstraints = false
        loanAmountView.translatesAutoresizingMaskIntoConstraints = false
        dateSubmittedView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            nameView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 8),
            nameView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 8),
            nameView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -8),
            //nameView.heightAnchor.constraint(equalToConstant: 15),
            
            dateSubmittedView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -16),
            dateSubmittedView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 8),
            dateSubmittedView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -8),
            // dateSubmittedView.heightAnchor.constraint(equalToConstant: 15),
            
            loanAmountView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 0),
            loanAmountView.bottomAnchor.constraint(equalTo: dateSubmittedView.topAnchor, constant: 0),
            loanAmountView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 8),
            loanAmountView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -8),
            // loanAmountView.heightAnchor.constraint(equalToConstant: 15)
            
        ])
    }

}
