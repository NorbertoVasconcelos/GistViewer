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
    
    var transition: PopAnimator?
    var gistView: GistDetailView = GistDetailView(frame: UIScreen.main.bounds)
    var viewModel: GistDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(gistView)
        
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        let imageInSuperview = self.gistView.owner.imgView.convert(self.gistView.owner.imgView.bounds, to: view)
//
//        self.transition = PopAnimator(duration: 0.5,
//                                      isPresenting: false,
//                                      originFrame: imageInSuperview,
//                                      image: self.gistView.owner.imgView.image ?? UIImage(named: "arrow_left")!)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
            .do(onNext: {
                
            })
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

// MARK: - Transition Animation -
extension GistDetailViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
}
