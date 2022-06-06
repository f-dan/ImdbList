//
//  MoviesDescriptionViewModel.swift
//  ImdbList
//
//  Created by Danilo on 11/05/22.
//

import Foundation
import WebKit

final class MoviesDescriptionViewModel{
    
    var trailer: Trailer!
    private var service: ImdbAPI
    
    lazy var description: String = {
        return trailer.videoDescription
    }()
    
    lazy var title: String = {
        return trailer.title
    }()
    
    lazy var year: String = {
        return trailer.year
    }()
    
    init(service: ImdbAPI, trailer: Trailer) {
        self.service = service
        self.trailer = trailer
    }    
}

