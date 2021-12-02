//
//  TeamDetailViewModel.swift
//  FootballApp
//
//  Created by  Sasha Khomenko on 22.11.2021.
//

import Foundation

protocol TeamViewModelDelegate: AnyObject {
    func callbackWhenDataAvailable(matches: [Team])
}

class TeamViewModel{
    
    var team: Team?
    var error: Error?
    var isLoading: Bool = false
    
    weak var delegate: TeamViewModelDelegate?
    
    var service: WebService = DataWebService.shared
    
    func fetchUpcomingMatches(teamId: Int) {
        error = nil
        isLoading = true
        
        service.fetchTeamDetail(teamId: teamId) { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                
                switch result {
                case .success(let team):
                    self.team = team
                    
                case .failure(let error):
                    self.error = error
                }
            }
        }
    }
    
}
