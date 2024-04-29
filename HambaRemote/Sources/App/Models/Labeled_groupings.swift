import Fluent
import Vapor

final class Labeled_groupings: Model, Content {
    static let schema = "labeled_groupings"
    
    @ID(custom: "id_labeled_groupings")
    var id: Int?
    
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
