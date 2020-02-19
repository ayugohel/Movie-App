//
//  venue.swift
//  ios-interview-test
//

import Foundation

struct Venue {
    static private let venueUrlString: String = "https://assets.eventbase.com/apps/ios-interview-project/resources/venuelistjson.json"
    
    let uid: Int
    let name: String
    let address: String
    
    public enum Result<Venue> {
        case success(Venue)
        case failure(Error)
    }
    
    static func getVenue(uid: Int, completion: ((Result<Venue>) -> Void)?) {
        guard let url:URL = URL.init(string: venueUrlString) else {
            return
        }
        
        /*
         Example response:
         [{ "uid": 1, "name": "AMC Kabuki", "address": "1881 Post St, San Francisco, CA 94115" }]
        */
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            DispatchQueue.main.async {
                if let error = responseError {
                    completion?(.failure(error))
                } else if let jsonData = responseData {
                    let decoder = JSONDecoder()
                    do {
                        let venues = try decoder.decode([Venue].self, from: jsonData)
                        guard let venue = venues.first(where: { $0.uid == uid} ) else {
                            return
                        }
                        completion?(.success(venue))
                    } catch {
                        completion?(.failure(error))
                    }
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                    completion?(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}

extension Venue: Decodable {
    enum venueKeys: String, CodingKey {
        case uid = "uid"
        case name = "name"
        case address = "address"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: venueKeys.self)
        let uid: Int = try container.decode(Int.self, forKey: .uid)
        let name: String = try container.decode(String.self, forKey: .name)
        let address: String = try container.decode(String.self, forKey: .address)

        self.init(uid: uid, name: name, address: address)
    }
    
}
