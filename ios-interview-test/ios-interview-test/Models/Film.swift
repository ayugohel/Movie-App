//
//  film.swift
//  ios-interview-test
//

import Foundation

struct Film {
    static private let movieUrlString: String = "https://assets.eventbase.com/apps/ios-interview-project/resources/movielistjson.json"
    
    let uid: Int
    let name: String
    let shortDesc: String
    let duration: Int
    let thumbnailUrl: URL
    let categoryId: Int
    // When 1 to many relationship
    // let catId : [Int]
    let venueId: Int
    
    public enum Result<Value> {
        case success(Value)
        case failure(Error)
    }
    
    static func getFilms(category: Int, completion: ((Result<[Film]>) -> Void)?) {
        guard let url:URL = URL.init(string: movieUrlString) else {
            return
        }
        
        /*
         Example response:
         [{ "uid": 1, "name": "Avengers: Infinity War", "shortDesc": "Lorem Ipsum", "duration": 120, "thumbnailUrl": "https://assets.eventbase.com/apps/ios-interview-project/images/avg.jpg", "category": 1, "venue": 1 }]
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
                        var films = try decoder.decode([Film].self, from: jsonData)
                        films = films.filter { $0.categoryId == category}
                        // When 1 to many relationship
                        // films = films.filter({ $0.catId.contains(category) })
                        completion?(.success(films))
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

extension Film: Decodable {
    enum filmKeys: String, CodingKey {
        case uid = "uid"
        case name = "name"
        case shortDesc = "shortDesc"
        case duration = "duration"
        case thumbnailUrl = "thumbnailUrl"
        case category = "category"
        case venue = "venue"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: filmKeys.self)
        let uid: Int = try container.decode(Int.self, forKey: .uid)
        let name: String = try container.decode(String.self, forKey: .name)
        let shortDesc: String = try container.decode(String.self, forKey: .shortDesc)
        let duration: Int = try container.decode(Int.self, forKey: .duration)
        let thumbnailUrl: URL = try container.decode(URL.self, forKey: .thumbnailUrl)
        let categoryId: Int = try container.decode(Int.self, forKey: .category)
        let venueId: Int = try container.decode(Int.self, forKey: .venue)
        
        self.init(uid: uid, name: name, shortDesc: shortDesc, duration: duration, thumbnailUrl:thumbnailUrl, categoryId: categoryId, venueId:venueId)
    }
}
