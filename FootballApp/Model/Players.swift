//
//  Players.swift
//  FootballApp
//
//  Created by  Sasha Khomenko on 22.11.2021.
//

import Foundation

public struct Player: Identifiable, Decodable, Equatable {
    
    public var id: Int?
    var name: String
    var firstName: String?
    var dateOfBirth: String?
    var countryOfBirth: String?
    var nationality: String?
    var position: String?
    var shirtNumber: Int?
    var role: String?
}

