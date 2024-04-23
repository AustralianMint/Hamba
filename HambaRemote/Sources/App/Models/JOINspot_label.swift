import Vapor

  struct SpotWithLabel: Content {
    let spotName: String
    let labelName: [String]
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