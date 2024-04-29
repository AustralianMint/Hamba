import Foundation
import Fluent
import Vapor

final class Groupings: Model, Content {
    static let schema: String = "groupings"
    
    @ID(custom: "id_groupings")
    var id: Int?
    
    @Field(key: "name")
    var name: String
    
    @OptionalParent(key: "users_id")
    var users_id: Users?
    
    @Siblings(through: Grouped_Spots.self, from: \.$groupings_id, to: \.$spots_id)
    var spots_id: [Spots]
    
    @Siblings(through: Labeled_groupings.self, from: \.$groupings_id, to: \.$labels_id)
    var labels_id: [Labels]
    
    init() {}
    
    init(id: Int? = nil, name: String, users_id: Int?) {
        self.id = id
        self.name = name
        self.$users_id.id = users_id
    }
}
