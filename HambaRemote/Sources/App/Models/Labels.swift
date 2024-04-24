import Foundation
import Fluent
import Vapor

final class Labels: Model, Content {

    static let schema = "labels"

    // Primary Key
    @ID(custom: "id_labels")
    var id: Int?

    @Field(key: "name")
    var name: String
    
    @Siblings(through: Spots_labeled.self, from: \.$labels_id, to: \.$spots_id)
    var spots_id: [Spots]
    
    @Siblings(through: Labeled_groupings.self, from: \.$labels_id, to: \.$groupings_id)
    var groupings_id: [Groupings]

    init() {}

    init(id: Int? = nil, name: String) {
        self.id = id
        self.name = name
    }
}

struct createLabel: Content {
    var name: String
}
