import Foundation
import Fluent
import Vapor

final class Pictures: Model, Content {
    
    static let schema = "pictures"
    
    // Primary Key
    @ID(custom: "id_pictures")
    var id: Int?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "created_at")
    var created_at: Date
    
    @Field(key: "spots_id")
    var spots_id: Int
    
    @Field(key: "users_id")
    var users_id: Int
    
    init() {}
    
    init(id: Int? = nil, name: String, created_at: Date, spots_id: Int, users_id: Int) {
        self.id = id
        self.name = name
        self.created_at = created_at
        self.spots_id = spots_id
        self.users_id = users_id
    }
}
