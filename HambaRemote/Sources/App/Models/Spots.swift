import Fluent
import Vapor


final class Spots: Model {
  // Define a static string for the table name if you want it different from the default
  static let schema = "spots"
  // Primary key id field
  @ID(custom: "id_spots")
  var id: Int?
  // Example fields
  @Field(key: "name")
  var name: String

  @Field(key: "rating")
  var rating: Int

  @Field(key: "n_ratings")
  var n_ratings: Int
  
  @Siblings(through: Users_ratings.self, from: \.$spots_id, to:\.$users_id)
  var users_id: [Users]

  init() {}
  init(id: Int? = nil, name: String) {
    self.id = id
    self.name = name
    self.rating = rating
    self.n_ratings = n_ratings
  }
}