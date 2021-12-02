//
//  FakeModelStubs.swift
//  FootballApp
//
//  Created by  Sasha Khomenko on 22.11.2021.
//

import Foundation

extension Match {

    static var stubMatches: [Match] {
        let url = Bundle.main.url(forResource: "matches", withExtension: "json")!
        let matchResponse: MatchResponse = Utilities.loadStub(url: url)
        return matchResponse.matches
    }

    static var stubFinishedMatches: [Match] {
        let url = Bundle.main.url(forResource: "finished_matches", withExtension: "json")!
        let matchResponse: MatchResponse = Utilities.loadStub(url: url)
        return matchResponse.matches.reversed()
    }
}

extension Player {
    
    static var dummyPlayers: [Player] {
        return [
            Player(id: 1, name: "Cristiano Ronaldo", firstName: "CR7", dateOfBirth: "1999-11-12", countryOfBirth: "Portugal", nationality: "Portugal", position: "Attacker", shirtNumber: 7),
            Player(id: 2, name: "Ronaldo", firstName: "Ronaldo", dateOfBirth: "1999-11-12", countryOfBirth: "Portugal", nationality: "Brazil", position: "Attacker", shirtNumber: 9),
            Player(id: 3, name: "Kurniawan Dwi Julianto", firstName: "Kurniawan", dateOfBirth: "1999-11-12", countryOfBirth: "Portugal", nationality: "Indonesia", position: "Attacker", shirtNumber: 10),
            Player(id: 4, name: "Thierry Henry", firstName: "Ongry", dateOfBirth: "1999-11-12", countryOfBirth: "Portugal", nationality: "France", position: "Attacker", shirtNumber: 14),
            Player(id: 5, name: "Fransesco Totti", firstName: "Totti", dateOfBirth: "1999-11-12", countryOfBirth: "Portugal", nationality: "Italy", position: "Attacker", shirtNumber: 11),
        ]
    }
}





extension Standing {

    static var dummyStandings: Standing {
        let url = Bundle.main.url(forResource: "standings", withExtension: "json")!
        let standingResponse: StandingResponse = Utilities.loadStub(url: url)
        return standingResponse.standings!.first { $0.type == "TOTAL" }!

    }
}

extension MatchScore {
    
    static var dummyMatchScores: [MatchScore] {
        return [
            MatchScore(winner: "HOME", duration: "REGULAR", fullTime: MatchScoreTime(homeTeam: 3, awayTeam: 1), halfTime: MatchScoreTime(homeTeam: 1, awayTeam: 2), extraTime: nil, penalties: nil),
            MatchScore(winner: "AWAY", duration: "REGULAR", fullTime: MatchScoreTime(homeTeam: 4, awayTeam: 5), halfTime: MatchScoreTime(homeTeam: 4, awayTeam: 0), extraTime: nil, penalties: nil),
            MatchScore(winner: "AWAY", duration: "REGULAR", fullTime: MatchScoreTime(homeTeam: 2, awayTeam: 3), halfTime: MatchScoreTime(homeTeam: 2, awayTeam: 1), extraTime: nil, penalties: nil)
        ]
    }
}

