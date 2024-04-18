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
    
    
    //app.get("test-first") {
    //    req async throws -> String in
    //    let queryResult = try await Spots.query(on: req.db).first()
    //
    //    return queryResult!.name
    //}
    
    //Wessel: This is where we register which controllers to use. See the "Controllers" folder if you want to see what controllers are present.
    try app.register(collection: TodoController())
}
