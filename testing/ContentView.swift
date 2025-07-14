//
//  ContentView.swift
//  testing
//
//  Created by SoftSuave on 14/07/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ListViewModel()

       var body: some View {
           NavigationView {
               if viewModel.isLoading {
                   ProgressView("Loading Posts...")
               } else if let error = viewModel.errorMessage {
                   Text("Error: \(error)")
                       .foregroundColor(.red)
               } else {
                   List(viewModel.posts) { post in
                       VStack(alignment: .leading, spacing: 4) {
                           Text(post.title)
                               .font(.headline)
                           Text(post.body)
                               .font(.subheadline)
                               .foregroundColor(.gray)
                       }
                   }
                   .navigationTitle("Posts")
               }
           }
       }
}

#Preview {
    ContentView()
}
