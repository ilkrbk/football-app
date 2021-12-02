//
//  WebService.swift
//  FootballApp
//
//  Created by  Sasha Khomenko on 22.11.2021.
//

import Foundation

public typealias dataResponseHandler = (Result<[Match], Error>)

public protocol WebService {
    func startEndDateFilter(isUpcoming: Bool) -> (String, String)
    func fetchLatestMatches(competitionId: Int, completion: @escaping(dataResponseHandler) -> ())
    func fetchUpcomingMatches(competitionId: Int, completion: @escaping(Result<[Match], Error>) -> ())

}

struct DataWebService: WebService  {
    
    static let shared = DataWebService()
    private let urlSession = URLSession.shared
    private let apiKey = "36ed6a2f130146fbbf3cddf7f7d6f18a"
    private let baseURL = "https://api.football-data.org/v2/"
    
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    private init() {}

    internal func startEndDateFilter(isUpcoming: Bool) -> (String, String) {
        let today = Date()
        // Seconds: 86400 = 1440 = 24 hours (todays date +/- 10 days) as API only allows only 10 days of data in a call.
        let tenDays = today.addingTimeInterval(86400 * (isUpcoming ? 10 : -10))
        
        let todayText = DataWebService.dateFormatter.string(from: today)
        let tenDaysText = DataWebService.dateFormatter.string(from: tenDays)
        return isUpcoming ? (todayText, tenDaysText) : (tenDaysText, todayText)
    }
    
    static private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    //Запрос на вывод названий всех команд в лиге
    //?????
//    func fetchLatestStandings(competitionId: Int, completion: @escaping(Result<[TeamStandingTable], Error>) -> ()) {
//        let url = baseURL + "/competitions/\(competitionId)/standings"
//        let urlRequest = URLRequest(url: URL(string: url)!)
//
//        fetchData(request: urlRequest) { (result: Result<StandingResponse, Error>) in
//            switch result {
//            case .success(let response):
//                if let standing = response.standings?.first {
//                    completion(.success(standing.table))
//                } else {
//                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Not found"])))
//                }
//
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
    
    // Запрос на предстоящие матчи
    func fetchUpcomingMatches(competitionId: Int, completion: @escaping(Result<[Match], Error>) -> ()) {
        let (tenDaysAgoText, todayText) = startEndDateFilter(isUpcoming: true)
        
        let url = baseURL + "/matches?status=SCHEDULED&competitions=\(competitionId)&dateFrom=\(tenDaysAgoText)&dateTo=\(todayText)"
        let urlRequest = URLRequest(url: URL(string: url)!)

        fetchData(request: urlRequest) { (result: Result<MatchResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.matches))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //Запрос на прошедшие матчи
    func fetchLatestMatches(competitionId: Int, completion: @escaping(Result<[Match], Error>) -> ()) {
        let (tenDaysAgoText, todayText) = startEndDateFilter(isUpcoming: false)
        
        let url = baseURL + "/matches?status=FINISHED&competitions=\(competitionId)&dateFrom=\(tenDaysAgoText)&dateTo=\(todayText)"
        let urlRequest = URLRequest(url: URL(string: url)!)
        fetchData(request: urlRequest) { (result: Result<MatchResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.matches))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //Запрос на детальную информация про команд
    //??????
//    func fetchTeamDetail(teamId: Int, completion: @escaping(Result<Team, Error>) -> ()) {
//        let url = baseURL + "/teams/\(teamId)"
//        let urlRequest = URLRequest(url: URL(string: url)!)
//
//        fetchData(request: urlRequest, completion: completion)
//    }
    
    func fetchData<D: Decodable>(request: URLRequest, completion: @escaping(Result<D, Error>) -> ()) {
        var urlRequest = request
        urlRequest.addValue(apiKey, forHTTPHeaderField: "X-Auth-Token")
        
        
        urlSession.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Data not found"])
                completion(.failure(error))
                return
            }
            
            do {
                let d = try self.jsonDecoder.decode(D.self, from: data)
                completion(.success(d))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}


struct StandingResponse: Decodable {
    var standings: [Standing]?
}

