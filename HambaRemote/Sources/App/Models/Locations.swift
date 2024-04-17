//
//  File.swift
//
//
//  Created by Thomas Frey on 16.04.24.
//

import Foundation
import Fluent
import Vapor

final class Location: Model, Content {
    
    static let schema: String = "locations"
    
    @ID(custom: "id_locations")
    var id: Int?
    
    @Field(key: "country")
    var country: String
    
    @Field(key: "city")
    var city: String
    
    @Field(key: "zip")
    var zip: String
    
    @Field(key: "house_number")
    var house_number: Int
    
    @Field(key: "street_name")
    var street_name: String
    
    @Field(key: "x_coordinates")
    var x_coordinates: (Float)
    
    @Field(key: "y_coordinates")
    var y_coordinates: (Float)
    
    @Field(key: "spot_id")
    var spot_id: Int
    
    init() {}
    
    init(id: Int? = nil, country: String, city: String,
         zip: String, house_number: Int, street_name: String,
         x_coordinates: Float, y_coordinates: Float,
         spots_id: Int ) {
        self.id = id
        self.country = country
        self.city = city
        self.zip = zip
        self.house_number = house_number
        self.street_name = street_name
        self.x_coordinates = x_coordinates
        self.y_coordinates = y_coordinates
        self.spot_id = spot_id
    }
}
