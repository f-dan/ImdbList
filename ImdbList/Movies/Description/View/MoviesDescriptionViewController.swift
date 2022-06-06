//
//  TrailerViewController.swift
//  ImdbList
//
//  Created by Danilo on 10/05/22.
//

import UIKit
import WebKit

class MoviesDescriptionViewController: UIViewController {
  
    @IBOutlet weak var webView: WKWebView!	
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbYear: UILabel!
    @IBOutlet weak var lbMovieDescription: UILabel!
    
    // MARK: - Properties
    var viewModel: MoviesDescriptionViewModel!
    
    // MARK: - Initializers
    init(viewModel: MoviesDescriptionViewModel){
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        setupDescription()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadVideo()
    }
    
    func loadVideo(){
        guard let videoURL = URL(string: viewModel.trailer.linkEmbed) else { return }
        let urlRequest = URLRequest(url: videoURL)
        webView.load(urlRequest)
    }
  
    
    func setupDescription() {
        lbTitle.text = viewModel.title
        lbYear.text = viewModel.year
        lbMovieDescription.text = viewModel.description
    }
}
