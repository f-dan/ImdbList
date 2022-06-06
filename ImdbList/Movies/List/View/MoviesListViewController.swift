//
//  ResultTableViewController.swift
//  ImdbList
//
//  Created by Danilo on 02/05/22.
//

import UIKit
import Kingfisher

class MoviesListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var results: [Result]!
    var viewModel: MoviesListViewModel!
    
    // MARK: - Initializers
    init(viewModel: MoviesListViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.viewModel.vcDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        setupTable()
    }
    
    func setupTable() {
        let nib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MovieTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Table view data source
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         viewModel.fetchTrailer(indexPath)       
    }
   

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if viewModel.count == 0 {
             onFailure()
             self.viewModel.flowDelegate?.goHome()
         }
         return viewModel.count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
         let movie = viewModel.movieBy(indexPath)
         cell.setup(title: movie.title, year: movie.resultDescription, url: movie.image)
        return cell
    }
}

extension MoviesListViewController: MoviesListViewDelegate {
    func onSuccess() {
        self.view?.finishLoading()
    }
    func onFailure() {
        showAlert(withTitle: "Erro", withMessage: "Não foi possível realizar a pesquisa", completion: nil)
    }
}
