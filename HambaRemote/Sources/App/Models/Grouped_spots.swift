import Foundation
import Fluent
import Vapor

final class Grouped_Spots: Model, Content {
    static let schema = "grouped_spots"

    @ID(custom: "id_grouped_spots")
    var id: Int?

    @Parent(key: "groupings_id")
    var groupings_id: Groupings
    
    @Parent(key: "spots_id")
    var spots_id: Spots

    init() {}

    init(id: Int? = nil, groupings_id: Int, spots_id: Int) {
        self.id = id
        self.$groupings_id.id = groupings_id
        self.$spots_id.id = spots_id
    }
}
