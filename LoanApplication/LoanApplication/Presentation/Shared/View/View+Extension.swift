//
//  View+Extension.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 24/10/24.
//

import Foundation
import UIKit

enum Anchor {
    case anchorX
    case anchorY
}


extension UIView {
    
    func setSizeConstraints(superview: UIView, viewSize: CGSize?, constraints: inout [NSLayoutConstraint]) {
        if let viewSize = viewSize {
            let width = viewSize.width
            let height = viewSize.height
            
            if height > 0 {
                constraints.append(self.heightAnchor.constraint(equalToConstant: viewSize.height))
            }
            
            if width > 0 {
                constraints.append(self.widthAnchor.constraint(equalToConstant: viewSize.width))
            }
        }
    }
    
    func setAnchorConstraints(superview: UIView, anchor: Anchor?, constraints: inout [NSLayoutConstraint]) {
        if anchor == .anchorX {
            constraints.append(self.centerXAnchor.constraint(equalTo: superview.centerXAnchor))
        }
        
        if anchor == .anchorY {
            constraints.append(self.centerYAnchor.constraint(equalTo: superview.centerYAnchor))
        }
    }
    
    func setEdgeConstraints(superview: UIView, edgeInsets: UIEdgeInsets?, constraints: inout [NSLayoutConstraint] ) {
        if let edgeInsets = edgeInsets {
            let left = edgeInsets.right
            let right = edgeInsets.right
            let top = edgeInsets.top
            let bottom = edgeInsets.bottom
            
            
            if left > 0 {
                constraints.append(leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: left))
            }
            
            if right > 0 {
                constraints.append(trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -right))
            }
            
            if top > 0 {
                constraints.append(topAnchor.constraint(equalTo: superview.topAnchor, constant: edgeInsets.top))
            }
            
            if bottom > 0 {
                constraints.append(bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -edgeInsets.bottom))
            }
        }
    }
    
    func edgesTo(view: UIView, edgeInsets: UIEdgeInsets? = nil, anchor: Anchor? = nil, viewSize: CGSize? = nil) {
        self.translatesAutoresizingMaskIntoConstraints = false
        var constraints: [NSLayoutConstraint] = []
        setSizeConstraints(superview: view, viewSize: viewSize, constraints: &constraints)
        setAnchorConstraints(superview: view, anchor: anchor, constraints: &constraints)
        setEdgeConstraints(superview: view, edgeInsets: edgeInsets, constraints: &constraints)
        NSLayoutConstraint.activate(constraints)
    }
}
