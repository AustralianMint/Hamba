import Fluent
import Vapor

final class Users: Model {
  	// Define a static string for the table name if you want it different from the default
  	static let schema = "users"
  	// Primary key id field
  	@ID(custom: "id_users")
  	var id: Int?
  	// Example fields
  	@Field(key: "email")
  	var email: String
  	@Field(key: "password")
  	var password: String
  	@Field(key: "name_full")
  	var name_full: String
  	@Field(key: "spot_count")
  	var spot_count: Int
	@Siblings(through: Users_ratings.self, from: \.$users_id, to:\.$spots_id)
  	var spots_id: [Spots]
  	// A default initializer is necessary if using a final class
  	init() {}
  	init(id: Int? = nil, name: String, age: Int) {
  	  	self.id = id
  	  	self.email = email
  	  	self.password = password
  	  	self.name_full = name_full
  	  	self.spot_count = spot_count
  	}
}
