import Fluent
import Vapor

// Wessel NOTE: Make SURE that the var name of @ID is "id:", because otherwise it won't conform to "Model"... for some reason...
final class Users_ratings: Model, Content {
  // Define a static string for the table name if you want it different from the default
  static let schema = "users_ratings"
  // Primary key id field
  @ID(custom: "id_users_ratings")
  var id: Int?
  // Example fields
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
