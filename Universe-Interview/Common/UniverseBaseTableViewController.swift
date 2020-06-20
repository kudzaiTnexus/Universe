//
//  UniverseBaseTableViewController.swift
//  Universe-Interview
//
//  Created by Kudzaiishe Mhou on 2020/06/20.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import Foundation
import UIKit

class UniverseBaseTableViewController: UITableViewController {

    var activityView: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension UniverseBaseTableViewController {
    
    func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityView?.center = self.view.center
        self.view.addSubview(activityView!)
        activityView?.startAnimating()
        self.view.isUserInteractionEnabled = false
    }

    func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.stopAnimating()
            self.view.isUserInteractionEnabled = true
        }
    }
}
