//
//  Coffee.swift
//  Dark roasted beans
//
//  Created by Luc Daalmeijer on 06/11/2021.
//

import Foundation

struct Coffee: Codable, Identifiable {
    let id: String
    let types: [CoffeeType]
    let sizes: [CoffeeSize]
    let extras: [Extra]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case types, sizes, extras
    }
}

extension Coffee {
    struct CoffeeType: Codable, Identifiable {
        let id, name: String
        let sizes, extras: [String]

        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case name, sizes, extras
        }
    }
    
    struct CoffeeSize: Codable, Identifiable {
        let id, name: String
        let v: Int?

        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case name
            case v = "__v"
        }
    }
    
    struct Extra: Codable, Identifiable {
        var id, name: String
        let subselections: [Subselection]

        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case name, subselections
        }
    }
}

extension Coffee.Extra {
    struct Subselection: Codable, Identifiable {
        let id, name: String

        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case name
        }
    }
}

