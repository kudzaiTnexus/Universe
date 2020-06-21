//
//  UIview+Extension.swift
//  Universe-Interview
//
//  Created by Kudzaiishe Mhou on 2020/06/20.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import UIKit

extension UIView {
    
    func layoutPinToSuperviewEdges(top: Bool = true, leading: Bool = true, bottom: Bool = true, trailing: Bool = true, insets: UIEdgeInsets = UIEdgeInsets.zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if top {
            topAnchor.constraint(equalTo: superview!.topAnchor, constant: insets.top).isActive = true
        }
        if leading {
            leadingAnchor.constraint(equalTo: superview!.leadingAnchor, constant: insets.left).isActive = true
        }
        if bottom {
            bottomAnchor.constraint(equalTo: superview!.bottomAnchor, constant: -insets.bottom).isActive = true
        }
        if trailing {
            trailingAnchor.constraint(equalTo: superview!.trailingAnchor, constant: -insets.right).isActive = true
        }
    }
}
