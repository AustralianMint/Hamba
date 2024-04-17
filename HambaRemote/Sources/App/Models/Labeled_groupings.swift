import Fluent
import Vapor

// Wessel NOTE: Make SURE that the var name of @ID is "id:", because otherwise it won't conform to "Model"... for some reason...
final class Labeled_groupings: Model {
  // Define a static string for the table name if you want it different from the default
  static let schema = "labeled_groupings"
  // Primary key id field
  @ID(custom: "id_labeled_groupings")
  var id: Int?
  // Example fields
  @Parent(key: "groupings_id")
  var groupings_id: Groupings
  @Parent(key: "labels_id")
  var labels_id: Labels
  init() {}
  init(id: Int? = nil, groupings_id: Int, labels_id: Int) {
    self.id = id
      self.$groupings_id.id = groupings_id
      self.$labels_id.id = labels_id
  }
}
