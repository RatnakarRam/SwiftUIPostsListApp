//
//  PostAPIServiceProtocol.swift
//  testing
//
//  Created by SoftSuave on 14/07/25.
//


import Foundation

protocol APIServiceProtocol {
    func fetchPosts(completion: @escaping (Result<[UserModel], Error>) -> Void)
}

class APIService: APIServiceProtocol {
    func fetchPosts(completion: @escaping (Result<[UserModel], Error>) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            completion(.failure(URLError(.badURL)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }

            do {
                let posts = try JSONDecoder().decode([UserModel].self, from: data)
                completion(.success(posts))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
