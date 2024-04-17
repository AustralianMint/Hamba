import Foundation
import Fluent

final class Grouped_Spots: Model {

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
