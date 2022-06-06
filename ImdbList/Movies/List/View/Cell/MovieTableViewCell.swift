//
//  ResultTableViewCell.swift
//  ImdbList
//
//  Created by Danilo on 05/05/22.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var ivMovie: UIImageView!
    @IBOutlet weak var lbYear: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    
    func setup(title:String, year: String, url: String) {
        lbTitle.text = title
        lbYear.text = year
       if let url = URL(string: url){
           ivMovie.kf.indicatorType = .activity
           ivMovie.kf.setImage(with: url)
           } else {
               ivMovie.image = nil
           }

       ivMovie.layer.cornerRadius = ivMovie.frame.size.height/2
        ivMovie.layer.borderColor = UIColor.gray.cgColor
       ivMovie.layer.borderWidth = 2
    }
}
