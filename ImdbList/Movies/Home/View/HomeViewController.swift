//
//  ListViewController.swift
//  ImdbList
//
//  Created by Danilo on 29/04/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var mainImageView: UIView!
    @IBOutlet weak var tfSearch: UITextField!
    // MARK: - Properties
    var viewModel: HomeViewModel!
    
    // MARK: - Initializers
    init(viewModel: HomeViewModel){
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.viewModel.vcDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainImageView.layer.cornerRadius = 15
    }

    @IBAction func btSearch(_ sender: UIButton) {
        guard let search = tfSearch.text else { return }
        viewModel.fetchMovies(search: search)
        }
    }


extension HomeViewController: HomeViewDelegate {
    func loading() {
        self.view?.startLoading()
    }
    
    func onSuccess() {
        self.view?.finishLoading()
    }
    
    func onFailure() {
        self.showAlert(withTitle: "Erro", withMessage: "Não foi possível realizar a pesquisa")
        self.view?.finishLoading()
    }
}
