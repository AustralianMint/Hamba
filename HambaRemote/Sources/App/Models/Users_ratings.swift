import Fluent
import Vapor

final class Users_ratings: Model, Content {
    static let schema = "users_ratings"
    
    @ID(custom: "id_users_ratings")
    var id: Int?
    
    @Parent(key: "users_id")
    var users_id: Users
    
    @Parent(key: "spots_id")
    var spots_id: Spots
    
    @Field(key: "given_rating")
    var given_rating: Int
   
    init() {}
    
    init(id: Int? = nil, users_id: Int, spots_id: Int, given_rating: Int) {
        self.id = id
        self.$users_id.id = users_id
        self.$spots_id.id = spots_id
        self.given_rating = given_rating
    }
}
