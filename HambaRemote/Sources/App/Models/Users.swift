import Fluent
import Vapor

struct CreateUserRequest: Content {
    var email: String
    var password: String
    var nameFull: String
    var spotCount: Int?
}

final class Users: Model, Content {
  	static let schema = "users"

  	@ID(custom: "id_users")
  	var id: Int?

    @Field(key: "email")
  	var email: String
  	
    @Field(key: "password")
  	var password: String
  	
    @Field(key: "name_full")
  	var name_full: String
  	
    @Field(key: "spot_count")
  	var spot_count: Int
    
    @Children(for: \.$users_id)
    var groupings_id: [Groupings]
	
    @Siblings(through: Users_ratings.self, from: \.$users_id, to:\.$spots_id)
  	var spots_id: [Spots]

  	init() {}
    
    init(id: Int? = nil, email: String, password: String, nameFull: String, spotCount: Int) {
            self.id = id
            self.email = email
            self.password = password
            self.name_full = nameFull
            self.spot_count = spotCount
    }
}
