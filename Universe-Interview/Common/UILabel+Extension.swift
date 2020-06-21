//
//  UILabel+Extension.swift
//  Universe-Interview
//
//  Created by Kudzaiishe Mhou on 2020/06/21.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import UIKit

extension UILabel {
    func universeLabel(with fontSize: CGFloat,
                       color: UIColor,
                       fontWeight: UIFont.Weight) -> UILabel {
        let label = UILabel()
        label.textColor = color
        label.font = .systemFont(ofSize: fontSize, weight: fontWeight)
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
}
