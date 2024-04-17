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

    init() {}

    init(id: Int? = nil, name: String) {
        self.id = id
        self.name = name
    }
}
