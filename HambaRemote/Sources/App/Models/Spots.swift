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
    
    @Siblings(through: Grouped_Spots.self, from: \.$spots_id, to: \.$groupings_id)
    var groupings_id: [Groupings]
    
    @Siblings(through: Spots_labeled.self, from: \.$spots_id, to: \.$labels_id)
    var labels_id: [Labels]
    
    @Children(for: \.$spots_id)
    var pictures_id: [Pictures]
    
    @Children(for: \.$spots_id)
    var location_id: [Location]
    
    init() {}
    init(id: Int? = nil, name: String) {
        self.id = id
        self.name = name
        self.rating = rating
        self.n_ratings = n_ratings
    }
}
