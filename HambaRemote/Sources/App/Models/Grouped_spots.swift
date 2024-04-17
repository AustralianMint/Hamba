import Foundation
import Fluent
import Vapor

final class Grouped_Spots: Model, Content {

    static let schema = "grouped_spots"

    // Primary Key
    @ID(custom: "id_grouped_spots")
    var id: Int?

    @Field(key: "groupings_id")
    var groupings_id: Int
    
    @Field(key: "spots_id")
    var spots_id: Int


    init() {}

    init(id: Int? = nil, groupings_id: Int, spots_id: Int) {
        self.id = id
        self.groupings_id = groupings_id
        self.spots_id = spots_id
    }
}
