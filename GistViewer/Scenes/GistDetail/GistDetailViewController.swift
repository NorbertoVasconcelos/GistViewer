//
//  GistDetailViewController.swift
//  GistViewer
//
//  Created by Norberto Vasconcelos on 10/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Domain

class GistDetailViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
    var gistView: GistDetailView = GistDetailView(frame: UIScreen.main.bounds)
    var viewModel: GistDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(gistView)
        
        bindViewModel()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func bindViewModel() {
        assert(viewModel != nil)
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        
        let back = gistView.btnBack.rx.tap.asDriver()
        
        let input = GistDetailViewModel.Input(trigger: viewWillAppear,
                                              back: back)
        let output = viewModel.transform(input: input)
        
        output.gist
            .drive(onNext: {
                gist in
                self.gistView.owner.lblTitle.text = gist.owner.username
                if let url = URL(string: gist.owner.avatarUrl) {
                    self.gistView.owner.imgView.kf.setImage(with: url)
                }
                self.gistView.gistDescription.lblTitle.text = "Description"
                self.gistView.gistDescription.lblDescription.text = gist.description
                self.gistView.createdDate.lblTitle.text = "Created at:"
                self.gistView.createdDate.lblDescription.text = "\(gist.createdAt?.simpleString ?? "Unavailable")"
                self.gistView.updatedDate.lblTitle.text = "Updated at:"
                self.gistView.updatedDate.lblDescription.text = "\(gist.updatedAt?.simpleString ?? "Unavailable")"
            })
            .disposed(by: disposeBag)
        
        output.back
            .drive()
            .disposed(by: disposeBag)
        
        output.error
            .drive(onNext: {
                error in
                print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
        
    }
}
