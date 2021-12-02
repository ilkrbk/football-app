import Foundation

protocol TeamsViewModelDelegate: AnyObject {
    func callbackWhenDataAvailable(matches: [TeamStandingTable])
}

class TeamsViewModel {
    
    var table: [TeamStandingTable] = []
    var error: Error?
    var isLoading: Bool = false
    weak var delegate: TeamsViewModelDelegate?
    
    var service: WebService = DataWebService.shared
    
    func fetchLatestStanding(competitionId: Int) {
        error = nil
        isLoading = true
        
        service.fetchLatestStandings(competitionId: competitionId) { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let table):
                    self.table = table
                    
                case .failure(let error):
                    self.error = error
                }
            }
        }
    }
}
