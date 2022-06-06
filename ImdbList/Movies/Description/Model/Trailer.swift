//
//  Trailer.swift
//  ImdbList
//
//  Created by Danilo on 03/05/22.
//

import Foundation

// MARK: - Trailer
struct Trailer: Codable {
    let imDBID, title, fullTitle, type: String
    let year, videoID, videoTitle, videoDescription: String
    let thumbnailURL: String
    let uploadDate: JSONNull?
    let link, linkEmbed: String
    let errorMessage: String

    enum CodingKeys: String, CodingKey {
        case imDBID = "imDbId"
        case title, fullTitle, type, year
        case videoID = "videoId"
        case videoTitle, videoDescription
        case thumbnailURL = "thumbnailUrl"
        case uploadDate, link, linkEmbed, errorMessage
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
