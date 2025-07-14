//
//  PostListViewModel.swift
//  testing
//
//  Created by SoftSuave on 14/07/25.
//


import Foundation

class ListViewModel: ObservableObject {
    @Published var posts: [UserModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let apiService: APIServiceProtocol

    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
        fetchPosts()
    }

    func fetchPosts() {
        isLoading = true
        apiService.fetchPosts { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let posts):
                    self?.posts = posts
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

