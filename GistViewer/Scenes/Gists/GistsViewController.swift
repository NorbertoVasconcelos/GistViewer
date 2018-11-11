//
//  GistsViewController.swift
//  GistViewer
//
//  Created by Norberto Vasconcelos on 08/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Domain

class GistsViewController: UIViewController {

    private let disposeBag = DisposeBag()

    var transition: PopAnimator?
    var gistsView: GistsView = GistsView(frame: UIScreen.main.bounds)
    var viewModel: GistsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(gistsView)
        
        setupTableView()
        bindViewModel()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setupTableView() {
        gistsView.tableView.refreshControl = UIRefreshControl()
        gistsView.tableView.estimatedRowHeight = 140
        gistsView.tableView.rowHeight = 140
        gistsView.tableView.register(GistTableViewCell.self, forCellReuseIdentifier: GistTableViewCell.reuseID)
        gistsView.tableView.backgroundColor = UIColor.clear
        gistsView.tableView.separatorStyle = .none
        gistsView.tableView.contentInset = UIEdgeInsets(top: 20,
                                                        left: 0.0,
                                                        bottom: 20,
                                                        right: 0.0)
    }
    
    private func bindViewModel() {
        assert(viewModel != nil)
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        
        let pull = gistsView.tableView.refreshControl!.rx
            .controlEvent(.valueChanged)
            .asDriver()
        
        let selection = gistsView
            .tableView
            .rx
            .itemSelected
            .do(onNext: { indexPath in
                if let cell = self.gistsView.tableView.cellForRow(at: indexPath) as? GistTableViewCell {
                    cell.owner.imgView.tag = 99
                    let imageInSuperview = cell.owner.imgView.convert(cell.owner.imgView.bounds, to: self.view)
                    
                    self.transition = PopAnimator(duration: 0.5,
                                                  isPresenting: true,
                                                  originFrame: imageInSuperview,
                                                  image: cell.owner.imgView.image ?? UIImage(named: "arrow_left")!)
                }
            })
            .asDriverOnErrorJustComplete()
        
        let input = GistsViewModel.Input(trigger: Driver.merge(viewWillAppear, pull),
                                         selection: selection)
        let output = viewModel.transform(input: input)
        
        output.gists
            .drive(gistsView.tableView.rx.items(cellIdentifier: GistTableViewCell.reuseID,
                                                cellType: GistTableViewCell.self)) { tv, viewModel, cell in
                                                    cell.bind(viewModel)
            }
            .disposed(by: disposeBag)
        
        output.fetching
            .drive(gistsView.tableView.refreshControl!.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        output.selectedGist
            .drive(onNext: {
                gist in
                print("Selected Gist: \(gist.id)")
            })
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
extension GistsViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
}
