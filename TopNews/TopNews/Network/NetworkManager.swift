//
//  NetworkManager.swift
//  TopNews
//
//  Created by Jelena Radojkovic on 11.11.22..
//

import Foundation

class NetworkManager {
    private let defaultSession = URLSession(configuration: .default)
    private let key = "2985bec6ba98434bb3c626c2b7df7627"
    static let shared = NetworkManager()
    private init() {}
    
    func getTopNews(country: String, completion: @escaping (Result<[TopNewsResponse], Error>) -> Void) {
        let queryItems = [URLQueryItem(name: "country", value: country),
                          URLQueryItem(name: "apiKey", value: key)]
        let getRequest = GetNewsRequest(params: queryItems)
        self.send(request: getRequest, completion: completion)
    }
    
    private func send<T: Codable>(request: APIRequest, completion: @escaping (Result<T, Error>) -> Void) {
        guard let urlRequest = request.urlRequest else { return }
        let dataTask = defaultSession.dataTask(with: urlRequest) { data,_,error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            
            let decoder = JSONDecoder()
            
            DispatchQueue.main.async {
                do {
                    let result = try decoder.decode(ApiResponse<T>.self, from: data)
                    completion(.success(result.articles))
                } catch {
                    let responseString = String(data: data, encoding: .utf8)
                    print("error, response string: \(String(describing: responseString))")
                    completion(.failure(error))
                }
            }
        }
        
        dataTask.resume()
    }
    
    func downloadImage(from url: String, _ completion: @escaping (Data) -> Void) {
        guard let url = URL(string: url) else { return }
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else {
                if let error = error {
                    print("image error: \(error.localizedDescription)")
                }
                return
            }
            DispatchQueue.main.async() {
                completion(data)
            }
        }
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
