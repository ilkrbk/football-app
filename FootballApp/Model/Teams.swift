//
//  Teams.swift
//  FootballApp
//
//  Created by  Sasha Khomenko on 22.11.2021.
//

import Foundation

struct Area: Identifiable, Decodable, Equatable {
    let id: Int
    let name: String
}

public struct Team: Identifiable, Decodable, Equatable {
    
    public let id: Int
    let name: String
    
    let area: Area?
    
    let shortName: String?
    let tla: String?
    let clubColors: String?
    let crestUrl: String?
    let address: String?
    let phone: String?
    let website: String?
    let email: String?
    let founded: Int?
    let venue: String?
    let squad: [Player]?
}


struct Standing: Identifiable, Decodable, Equatable {
    
    var id: String {
        "\(type)-\(stage)"
    }
    
    let type: String
    let stage: String
    let table: [TeamStandingTable]
}

public struct TeamStandingTable: Identifiable, Decodable, Equatable {
    
    public var id: Int { team.id }
    let position: Int
    let team: Team
    
    let playedGames: Int
    let won: Int
    let draw: Int
    let lost: Int
    let points: Int
    let goalsFor: Int
    let goalsAgainst: Int
    let goalDifference: Int
}

