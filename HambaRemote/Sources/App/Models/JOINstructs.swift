import Vapor

  struct SpotWithLabel: Content, Hashable {
    let spotName: String
    var labelName: [String]
  }
  
  struct Spots_Users_ratings: Content {
    let spot_name: String
    let user_name: String
    let given_rating: Int
  }

  struct Favourites: Content {
    let group_name: String
    let spot_name: [String]
  }

//Used to display the labels inside a grouping.
struct Labels_in_Groupings: Content {
    let groupings_name: String
    let labels_in_groupings: [String]
}

//Used to display the groupings of the users.
struct Groupings_belonging_to_users: Content {
    let user_name: String
    let groupings_name: [String]
}

struct SpotWithLocation: Content {
    var id: Int?
    var name: String
    var xCoordinates: Float
    var yCoordinates: Float
}

extension Array where Element: Hashable {
    func unique() -> [Element] {
        var seen: Set<Element> = []
        return filter { seen.insert($0).inserted }
    }
}
struct Basic_Favorites: Content {
    let group_name: String
    let spot_name: String
}

