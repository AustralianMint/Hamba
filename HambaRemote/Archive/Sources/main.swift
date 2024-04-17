// The Swift Programming Language
// https://docs.swift.org/swift-book
import PostgresNIO

let config = PostgresClient.Configuration(
    host: "localhost",
    port: 5432,
    username: "postgres",
    password: "hambaisaserver",
    database: "hambaw",
    tls: .disable
    )

let client = PostgresClient(configuration: config)

await withTaskGroup(of: Void.self) { taskGroup in 
    taskGroup.addTask {
        await client.run()
    }
    do {
        try await create_row(client: client, into: "users", values: ["wessellino@bois.com", "lalaland is great", "the bois", 4])
        try await create_row(client: client, into: "labels", values: ["dank"])

        // deleting rows. Function can only be used with WHERE statement currently. 
        try await delete_rows(client: client, from: "labels", condition: "name = 'fancy'")
        
        print("========== BEGINNING TABLE ==========")
        // case of reading spots table
        //if let unwraped_rows = try await read_rows(client: client , select: "*", from: "spots") {
        if let unwraped_rows = try await read_rows(client: client , select: "*", from: "labels") {
            for try await (id, name) in unwraped_rows.decode((Int, String).self) {
                print("\(id), \(name)")
            }
        }
        print("============= END TABLE =============")
        
        //// case creating Spot entry. 
        //try await create_row(client: client, into: "spots", values: ["weasel", 5, 1000])

        //let rows = try await client.query("SELECT * FROM spots;")
        //print("========== BEGINNING TABLE SPOTS ==========")
        //// case of reading spots table
        ////if let unwraped_rows = try await read_rows(client: client , select: "*", from: "spots") {
        //if let unwraped_rows = try await read_rows(client: client , select: "*", from: "spots") {
        //    for try await (id, name, rating, n_ratings) in unwraped_rows.decode((Int, String, Int, Int).self) {
        //        print("\(id) -- \(name) -- \(rating) -- \(n_ratings)")
        //    }
        //}
        //print("============= END TABLE SPOTS =============")
    }
    catch {
        print("error");
    }

    //do {
    //    let rows = try await read_all_spots(client: client)
    //    print(type(of: rows))
    //    print(rows != nil)
    //    if let unwraped_rows = rows {
    //        print("worked here 1.")
    //        for try await (name, rating) in unwraped_rows.decode((String, Int).self) {
    //            print("worked here 2.")
    //            print(name)
    //            print(rating)
    //        }
    //    }
    //    //if rows != nil {
    //    //    for try await (name, rating) in rows!.decode((String, Int).self) {
    //    //        print(name)
    //    //        print(rating)
    //    //    }
    //    //}
    //} catch {print("my error 1")}

    



    taskGroup.cancelAll()
}


func read_rows(client: PostgresClient , select: String, from: String) async throws -> PostgresRowSequence? {
    do {
        
        let my_string = "SELECT \(select) FROM \(from)"

        // this works now but could be dangerous, need to sanitize against SQL injection. Need to check if it is or is not safe... To find out!
        let rows = try await client.query(PostgresQuery.init(unsafeSQL: my_string))
        return rows
    } catch {
        print("something went wrong fetching from postgres. The Error:")
        print(String(reflecting: error))
        return nil
    } 
}

/* This function was the simpler implementation of create_row. The newer function has clearer & easier 
input parameters so it is easier to work with. Alse has a variable length array depending on the table we need
to insert into.
*/
//func create_row(client: PostgresClient, into: String, values: String) async throws {
//    do {
//        let my_sql = "INSERT INTO \(into) VALUES \(values);"
//
//        try await client.query(PostgresQuery.init(unsafeSQL: my_sql))
//
//    } catch {
//        print("something went wrong inserting into postgres. The Error: \n \(String(reflecting: error))")
//    }
//}

func create_row<T>(client: PostgresClient, into: String, values: [T]) async throws {
    do {
        switch (into) {
            case "spots":
                let the_query = "INSERT INTO spots (name, rating, n_ratings) VALUES ( '\(values[0])', \(values[1]), \(values[2]));"
                try await client.query(PostgresQuery.init(unsafeSQL: the_query))

            case "labels":
                let the_query = "INSERT INTO labels (name) VALUES ('\(values[0])')"
                try await client.query(PostgresQuery.init(unsafeSQL: the_query))
            case "grouped_spots":
                let the_query = "INSERT INTO grouped_spots (groupings_id, spots_id) VALUES (\(values[0]), \(values[1]))"
                try await client.query(PostgresQuery.init(unsafeSQL: the_query))
            case "groupings":
                let the_query = "INSERT INTO groupings (name, users_id) VALUES ('\(values[0])', \(values[1]))"
                try await client.query(PostgresQuery.init(unsafeSQL: the_query))
            case "labeled_groupings":
                let the_query = "INSERT INTO labeled_groupings (groupings_id, labels_id) VALUES ('\(values[0])', \(values[1]))"
                try await client.query(PostgresQuery.init(unsafeSQL: the_query))
            case "locations":
                let the_query = "INSERT INTO locations (country, city, zip, house_number, street_name, coordinates, spot_id) VALUES ('\(values[0])', '\(values[1])', '\(values[2])', \(values[3]), '\(values[4])', \(values[5]), \(values[6]))"
                try await client.query(PostgresQuery.init(unsafeSQL: the_query))
            case "pictures":
                let the_query = "INSERT INTO pictures (name, file_path, spots_id) VALUES ('\(values[0])', '\(values[1])', \(values[2]))"
                try await client.query(PostgresQuery.init(unsafeSQL: the_query))
            case "spots_labeled":
                let the_query = "INSERT INTO spots_labeled (labels_id, spots_id ) VALUES (\(values[0]), \(values[1]))"
                try await client.query(PostgresQuery.init(unsafeSQL: the_query))
            case "users":
                let the_query = "INSERT INTO users (email, password, name_full, spot_count) VALUES ('\(values[0])', '\(values[1])', '\(values[2])', \(values[3]))"
                try await client.query(PostgresQuery.init(unsafeSQL: the_query))
            case "users_ratings":
                let the_query = "INSERT INTO users_ratings (users_id, spots_id, given_rating) VALUES (\(values[0]), \(values[1]), \(values[2]))"
                try await client.query(PostgresQuery.init(unsafeSQL: the_query))
            default:
                print("Something went wrong, check the name of the database table you are trying to access.")

        }


    } catch {
        print("something went wrong inserting into postgres. The Error: \n \(String(reflecting: error))")
    }
}

func delete_rows(client: PostgresClient, from: String, condition: String) async throws {
    do {
         let the_query = "DELETE FROM \(from) WHERE \(condition);"
         try await client.query(PostgresQuery.init(unsafeSQL: the_query))

    } catch {
        print("something went wrong deleting rows, try again.")
    }
} 

func update_rows(client: PostgresClient, into: String, condition1: String, condition2: String) async throws {
    do {
        let the_query = "UPDATE \(into) SET \(condition1) WHERE \(condition2)"
        try await client.query(PostgresQuery.init(unsafeSQL: the_query))
    
    } catch {
        print("Something went wrong with updating the table.")
    }
}
