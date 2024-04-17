//
//  File.swift
//
//
//  Created by Thomas Frey on 16.04.24.
//

import Foundation
import Fluent
import Vapor

final class Groupings: Model, Content {
    
    static let schema: String = "groupings"
    
    @ID(custom: "id_groupings")
    var id: Int?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "users_id")
    var users_id: Int
    
    init() {}
    
    init(id: Int? = nil, name: String, users_id: Int) {
        self.id = id
        self.name = name
        self.users_id = users_id
    }
}
