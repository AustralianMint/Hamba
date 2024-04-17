import Fluent
import Vapor

// Wessel NOTE: Make SURE that the var name of @ID is "id:", because otherwise it won't conform to "Model"... for some reason...
final class Users_ratings: Model {
  // Define a static string for the table name if you want it different from the default
  static let schema = "users_ratings"
  // Primary key id field
  @ID(custom: "id_users_ratings")
  var id: Int?
  // Example fields
  @Field(key: "users_id")
  var users_id: Int
  @Field(key: "spots_id")
  var spots_id: Int
  @Field(key: "given_ratings")
  var given_ratings: Int
  init() {}
  init(id: Int? = nil, users_id: Int, spots_id: Int, given_ratings: Int) {
    self.id = id
    self.users_id = users_id
    self.spots_id = spots_id
    self.given_ratings = given_ratings
  }
}