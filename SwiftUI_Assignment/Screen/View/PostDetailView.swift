//
//  PostDetailView.swift
//  SwiftUI_Assignment
//
//  Created by Ankit on 02/10/25.
//

import SwiftUI

struct PostDetailView: View {
    let post: PostModel
    @State private var showAlert = false
    @State private var alertMessage = ""
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("User ID: \(post.userId ?? 0)")
                .font(.headline)
            Text("Title:")
                .font(.title3)
            Text(post.title?.capitalizingFirstLetter() ?? "No Title")
                .font(.body)
            
            Text("Body:")
                .font(.title3)
            Text(post.body ?? "No Content")
                .font(.body)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Post Detail")
    }
}
