import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }
    
    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    //Route to URL/test-db:
    app.get("test-db") {
        req -> EventLoopFuture<String> in
        let queryResult = Spots.query(on: req.db).all()
        return queryResult.map { models in
            "Database connected \(models[2])."
        }
    }
    //Wessel: This works as a routes function. You do not need a "guard let" for all() but you do need it for .first() or at least unrwap like seen in the examples below.
    app.get("test-async") {
        req async throws -> String in
        // the do clause is optional here actually, so is the catch that comes with it. You can remove them and it will work.
        do {
            let queryResult = try await Spots.query(on: req.db).all()
            
            var empty_string = ""
            for each in queryResult {
                empty_string = empty_string + "\n -- " + each.name
            }
            return empty_string
        } catch {
            throw Abort(.notFound)
        }
    }
    app.get("test-first") {
        req async throws -> String in
        guard let queryResult = try await Spots.query(on: req.db).first() else {
            throw Abort(.notFound)
        }
        
        return queryResult.name
    }
    app.get("get", "spots", "all") {
        req async throws -> [Spots] in
        do {
            let queryResult = try await Spots.query(on: req.db).all()
            
            return queryResult
        } catch {
            throw Abort(.notFound)
        }
    }     
    app.get("get", "users", "all") {
        req async throws -> [Users] in
        do {
            let queryResult = try await Users.query(on: req.db).all()
            
            return queryResult
        } catch {
            throw Abort(.notFound)
        }
    }
    app.get("get", "users_ratings", "all") {
        req async throws -> [Users_ratings] in
        do {
            let queryResult = try await Users_ratings.query(on: req.db).all()
            
            return queryResult
        } catch {
            throw Abort(.notFound)
        }
    }
    app.get("get", "labeled_groupings", "all") {
        req async throws -> [Labeled_groupings] in
        do {
            let queryResult = try await Labeled_groupings.query(on: req.db).all()
            
            return queryResult
        } catch {
            throw Abort(.notFound)
        }
    }
    
    app.get("get", "locations", "all") {
        req async throws -> [Location] in
        do {
            let queryResult = try await Location.query(on: req.db).all()
            
            return queryResult
        } catch {
            throw Abort(.notFound)
        }
    }
    
    app.get("get", "groupings", "all") {
        req async throws -> [Groupings] in
        do {
            let queryResult = try await Groupings.query(on: req.db).all()
            
            return queryResult
        } catch {
            throw Abort(.notFound)
        }
    }
    
    app.get("get", "spots_labeled", "all") {
        req async throws -> [Spots_labeled] in
        do {
            let queryResult = try await Spots_labeled.query(on: req.db).all()
            
            return queryResult
        } catch {
            throw Abort(.notFound)
        }
    }
    // this gets all the spots with the Users entries which have rated that spot.
    app.get("spots", "with_rating") { req async throws -> [Spots] in
      let spots = try await Spots.query(on: req.db)
        .join(Users_ratings.self, on: \Spots.$id == \Users_ratings.$spots_id.$id)
        .with(\.$users_id)
        .all()

        return spots 
    }
    //app.get("user_ratings", "get") { req async throws -> [Users_ratings] in 
    //    let the_ratings = try await Users_ratings.query(on: req.db)
    //        .join(Spots.self, on: \Users_ratings.$spots_id.$id == \Spots.$id)
    //        .join(Users.self, on: \Users_ratings.$users_id.$id == \Users.$id)
    //        .with(\.$spots_id)
    //        .with(\.$users_id)
    //        .field(Users_ratings.self, \.$given_rating)
    //        .all()

    //    return the_ratings
    //}
    app.get("user_ratings", "get") { req async throws -> [Users_ratings] in 
        let the_ratings = try await Users_ratings.query(on: req.db)
            .join(Spots.self, on: \Users_ratings.$spots_id.$id == \Spots.$id)
            .join(Users.self, on: \Users_ratings.$users_id.$id == \Users.$id)
            .with(\.$spots_id)
            .with(\.$users_id)
            .all()

        return the_ratings
    }
    app.get("spots", "with-labelnames") { req async throws -> [SpotWithLabel] in
      let spots = try await Spots.query(on: req.db)
        .join(Spots_labeled.self, on: \Spots.$id == \Spots_labeled.$spots_id.$id)
        .join(Labels.self, on: \Labels.$id == \Spots_labeled.$labels_id.$id)
        .with(\.$labels_id)
        .all()
      // Map the fetched spots to include the associated labels
      return spots.map { spot -> SpotWithLabel in
        // Extract labels from each spot, assuming that labels are loaded
        let labels = spot.labels_id.map { $0.name }
        return SpotWithLabel(spotName: spot.name, labelName: labels)
      }
    }
    //app.get("all_favourites") { req async throws -> [Favourites] in 
    //    let the_favourites = try await Grouped_Spots.query(on: req.db)
    //        .join(Spots.self, on: \Grouped_Spots.$spots_id.$id == \Spots.$id)
    //        .join(Groupings.self, on: \Grouped_Spots.$groupings_id.$id == \Groupings.$id)
    //        .with(\.$spots_id)
    //        .with(\.$groupings_id)
    //        .all()

    //    // JEEEESSUUUS CHRISST... this is necessary to get only the relevant fields as
    //    // The .filter() does not work on the above and breaks the code. This seems to
    //    // be a 
    //    return the_favourites.map {favourite -> Favourites in
    //        Favourites(group_name: favourite.groupings_id.name, spot_name: favourite.spots_id.name)
    //    }
    //}
    //app.get("favs_id", ":ID") { req async throws -> [Favourites] in 
    //    guard let groupingID = req.parameters.get("ID", as: Int.self) else {
    //        throw Abort(.badRequest, reason: "Invalid user ID.")
    //    } 
    //    let the_favourites = try await Grouped_Spots.query(on: req.db)
    //        .filter(\.$groupings_id.$id == groupingID)
    //        .join(Spots.self, on: \Grouped_Spots.$spots_id.$id == \Spots.$id)
    //        .join(Groupings.self, on: \Grouped_Spots.$groupings_id.$id == \Groupings.$id)
    //        .with(\.$spots_id)
    //        .with(\.$groupings_id)
    //        .all()

    //    // JEEEESSUUUS CHRISST... this is necessary to get only the relevant fields as
    //    // The .filter() does not work on the above and breaks the code. This seems to
    //    // be a 
    //    return the_favourites.map {favourite -> Favourites in
    //        Favourites(group_name: favourite.groupings_id.name, spot_name: favourite.spots_id.name)
    //    }
    //}
    app.get("favs_group_name", ":NAME") { req async throws -> Favourites in 
        guard let groupingNAME = req.parameters.get("NAME", as: String.self) else {
            throw Abort(.badRequest, reason: "Invalid group Name.")
        } 
        let the_favourites = try await Groupings.query(on: req.db)
            .filter(\.$name == groupingNAME)
            .join(Grouped_Spots.self, on: \Groupings.$id == \Grouped_Spots.$groupings_id.$id)
            .join(Spots.self, on: \Grouped_Spots.$spots_id.$id == \Spots.$id)
            .with(\.$spots_id)
            .all()

        // JEEEESSUUUS CHRISST... this is necessary to get only the relevant fields as
        // The .filter() does not work on the above and breaks the code. This seems to
        // be a 
        let the_array = the_favourites.map {favourite -> Favourites in
            let the_names = favourite.spots_id.map {$0.name}
            return Favourites(group_name: favourite.name, spot_name: the_names)
        }

        return the_array[0]     
    }
    app.get("spots_user_ratings", "get") { req async throws -> [Spots_Users_ratings] in 
        let the_ratings = try await Users_ratings.query(on: req.db)
            .join(Spots.self, on: \Users_ratings.$spots_id.$id == \Spots.$id)
            .join(Users.self, on: \Users_ratings.$users_id.$id == \Users.$id)
            .with(\.$spots_id)
            .with(\.$users_id)
            .all()

        // JEEEESSUUUS CHRISST... this is necessary to get only the relevant fields as
        // The .filter() does not work on the above and breaks the code. This seems to
        // be a 
        return the_ratings.map {rating -> Spots_Users_ratings in
            Spots_Users_ratings(spot_name: rating.spots_id.name, user_name: rating.users_id.name_full, given_rating: rating.given_rating)
        }
    }
    //CREATES 
    app.post("create-location") { req async throws -> HTTPStatus in
        let locationDTO = try req.content.decode(createLocationRequest.self)
        // Validate the input
        guard locationDTO.country.contains("Ger") else {
            throw Abort(.badRequest, reason: "Invalid location")
        }
        // Create a new user instance from the DTO
        let newLocation = Location(country: locationDTO.country, city: locationDTO.city, zip: locationDTO.zip, house_number: locationDTO.house_number, street_name: locationDTO.street_name, x_coordinates: locationDTO.x_coordinates, y_coordinates: locationDTO.y_coordinates, spots_id: locationDTO.spots_id ?? 1)
        // Save the user to the database
        try await newLocation.save(on: req.db)
        // Return HTTP 201 to indicate successful creation
        return .created
  }
  // UPDATES
   app.put("update-location", ":locationID") { req async throws -> HTTPStatus in
        guard let locationID = req.parameters.get("locationID", as: Int.self) else {
            throw Abort(.badRequest, reason: "Invalid location ID.")
        }
        let updateData = try req.content.decode(createLocationRequest.self)
        guard let updateLocation = try await Location.find(locationID, on: req.db) else {
          throw Abort(.notFound, reason: "location not found.")
        }
        updateLocation.country = updateData.country
        updateLocation.city = updateData.city
        updateLocation.zip = updateData.zip
        updateLocation.house_number = updateData.house_number
        updateLocation.street_name = updateData.street_name
        updateLocation.x_coordinates = updateData.x_coordinates
        updateLocation.y_coordinates = updateData.y_coordinates
        updateLocation.$spots_id.id = updateData.spots_id
        try await updateLocation.save(on: req.db)
        return .ok
  }
  // DELETE
  app.delete("delete-location", ":locationID") { req async throws -> HTTPStatus in
    guard let locationID = req.parameters.get("locationID", as: Int.self) else {
      throw Abort(.badRequest, reason: "Invalid location ID.")
    }
    guard let deleteLocation = try await Location.find(locationID, on: req.db) else {
      throw Abort(.notFound, reason: "location not found.")
    }
    try await deleteLocation.delete(on: req.db)
    return .ok
  }
    //Wessel: This is where we register which controllers to use. See the "Controllers" folder if you want to see what controllers are present.
    try app.register(collection: TodoController())
}
