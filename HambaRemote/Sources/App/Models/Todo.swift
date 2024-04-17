import Fluent
import Vapor
import FluentPostgresDriver

final class Todo: Model, Content {
  static let schema = "todos"
  @ID(key: .id)
  var id: UUID?
  @Field(key: "title")
  var title: String
  init() { }
  init(id: UUID? = nil, title: String) {
    self.id = id
    self.title = title
  }
}


//final class Labels: Model, Content {
//  // Define a static string for the table name if you want it different from the default
//  static let schema = "labels"
//  // Primary key id field
//  @ID(custom: "id_labels")
//  var id: Int?
//  // Example fields
//  @Field(key: "name")
//  var name: String
//  init() {}
//  init(id: Int? = nil, name: String) {
//    self.id = id
//    self.name = name 
//  }
//}