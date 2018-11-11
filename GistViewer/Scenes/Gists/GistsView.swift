//
//  GistsView.swift
//  GistViewer
//
//  Created by Norberto Vasconcelos on 08/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import UIKit
import Cartography

class GistsView: UIView {
    
    var tableView: UITableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupView() {
        let lblTitle = UILabel()
        lblTitle.text = "Gists"
        lblTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 36)
        lblTitle.textColor = UIColor.white
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 80))
        headerView.addSubview(lblTitle)
        tableView.tableHeaderView = headerView
        addSubview(tableView)
        
        constrain(lblTitle) {
            lblTitle in
            if let superview = lblTitle.superview {
                lblTitle.leading == superview.leading + 8
                lblTitle.top == superview.top
            }
        }
        
        constrain(tableView) {
            tableView in
            if let superview = tableView.superview {
                tableView.top == superview.top + 32
                tableView.leading == superview.leading
                tableView.trailing == superview.trailing
                tableView.bottom == superview.bottom
            }
        }
    }
}
