//
//  Utilities.swift
//  FootballApp
//
//  Created by  Sasha Khomenko on 22.11.2021.
//

import Foundation
import UIKit

struct Utilities {
    
    static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    static func loadStub<D: Decodable>(url: URL) -> D {
        let data = try! Data(contentsOf: url)
        do {
            let d = try jsonDecoder.decode(D.self, from: data)
            return d
        } catch {
            print(error.localizedDescription)
            fatalError()
        }
    }
}
