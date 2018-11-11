//
//  GistDetailView.swift
//  GistViewer
//
//  Created by Norberto Vasconcelos on 10/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import UIKit
import Cartography

class GistDetailView: UIView {
    
    let btnBack: UIButton = UIButton()
    let lblTitle: UILabel = UILabel()
    let scrollView: UIScrollView = UIScrollView()
    var stackView: UIStackView = UIStackView()
    let owner: ImageTitleView = ImageTitleView()
    let gistDescription: TitleDescriptionView = TitleDescriptionView()
    let createdDate: TitleDescriptionView = TitleDescriptionView()
    let updatedDate: TitleDescriptionView = TitleDescriptionView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupView() {
        btnBack.setImage(UIImage(named: "left_arrow"), for: .normal)
        
        lblTitle.text = "Gist Detail"
        lblTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 36)
        lblTitle.textColor = UIColor.white
        
        owner.imgView.tag = 99
        
        stackView = UIStackView(arrangedSubviews: [owner,
                                                   gistDescription,
                                                   createdDate,
                                                   updatedDate])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(btnBack)
        addSubview(lblTitle)
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        constrain(btnBack, lblTitle, stackView, scrollView) {
            btnBack, lblTitle, stackView, scrollView in
            if let superview = btnBack.superview {
                btnBack.top == superview.top + 32
                btnBack.leading == superview.leading + 8
                
                
                lblTitle.top == btnBack.bottom + 32
                lblTitle.leading == superview.leading + 8
                lblTitle.trailing == superview.trailing + 8
                
                scrollView.top == lblTitle.bottom + 32
                scrollView.leading == superview.leading + 8
                scrollView.trailing == superview.trailing - 8
                scrollView.bottom == superview.bottom
                
                stackView.top == lblTitle.bottom + 32
                stackView.leading == superview.leading + 8
                stackView.trailing == superview.trailing - 8
                stackView.bottom <= superview.bottom
                
                stackView.width == scrollView.width
            }
        }
    }
}
