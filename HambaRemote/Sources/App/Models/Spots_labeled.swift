//
//  File.swift
//
//
//  Created by Thomas Frey on 16.04.24.
//

import Foundation
import Fluent
import FluentPostgresDriver
import Vapor

final class Spots_labeled: Model, Content {
    
    static let schema: String = "spots_labeled"
    
    @ID(custom: "id_spots_labeled")
    var id: Int?
    
    @Parent(key: "labels_id")
    var labels_id: Labels
    
    @Parent(key: "spots_id")
    var spots_id: Spots
    
    init() {}
    
    init(id: Int? = nil, labels_id: Int, spots_id: Int) {
        self.id = id
        self.$labels_id.id = labels_id
        self.$spots_id.id = spots_id
    }
}
