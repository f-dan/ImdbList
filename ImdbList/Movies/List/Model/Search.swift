//
//  Search.swift
//  ImdbList
//
//  Created by Danilo on 03/05/22.
//

import Foundation

// MARK: - Search
struct Search: Codable {
    let searchType: SearchTypeEnum
    let expression: String
    let results: [Result]
    let errorMessage: String
}

// MARK: - Result
struct Result: Codable {
    let id: String
    let resultType: SearchTypeEnum
    let image: String
    let title, resultDescription: String

    enum CodingKeys: String, CodingKey {
        case id, resultType, image, title
        case resultDescription = "description"
    }
}

enum SearchTypeEnum: String, Codable {
    case title = "Title"
}
