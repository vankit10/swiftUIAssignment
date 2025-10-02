//
//  PostViewScreen.swift
//  SwiftUI_Assignment
//
//  Created by Ankit on 02/10/25.
//

import SwiftUI
import SVProgressHUD

struct PostViewScreen: View {
    @State var posts = [PostModel]()
    @State var allPosts = [PostModel]()
    @StateObject var viewModel = PostViewModel()
    @State var favoritePostIDs: Set<Int> = []
    @AppStorage("favoritePostIDs") var storedFavoritesData: Data = Data()
    @State var searchText = ""
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            HeaderView(title: "All posts")
            
                VStack(alignment: .leading) {
                    TextField("Search by title...", text: $searchText)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 2)
                        .padding(.horizontal, 12)
                        .onChange(of: searchText) { newValue in
                            filterPosts(with: newValue)
                        }
                }
//                .padding(6)
                .background(.darkgray)
            if posts.count != 0{
                List {
                    ForEach(posts, id: \.id) { post in
                        NavigationLink(destination: PostDetailView(post: post)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("\(post.userId ?? 0)")
                                        .font(.headline)
                                    Text(post.title?.capitalizingFirstLetter() ?? "No Title")
                                        .font(.subheadline)
                                }
                                Spacer()
                                Button(action: {
                                    toggleFavorite(postID: post.id ?? 0)
                                }) {
                                    Image(systemName: favoritePostIDs.contains(post.id ?? 0) ? "heart.fill" : "heart")
                                        .foregroundColor(.red)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }
                .refreshable {
                    fetchPosts()
                }
                .edgesIgnoringSafeArea(.all)
            }else{
                Spacer()
                   VStack {
                       Image(systemName: "tray")
                           .resizable()
                           .frame(width: 80, height: 80)
                           .foregroundColor(.gray)
                           .padding(.bottom)
                       Text("No posts found.")
                           .font(.headline)
                           .foregroundColor(.gray)
                       if !searchText.isEmpty {
                           Text("Try clearing the search or refresh.")
                               .font(.subheadline)
                               .foregroundColor(.gray)
                       }
                   }
                   Spacer()
            }
        }
        .background(.darkgray)
        .onAppear {
            if let ids = try? JSONDecoder().decode(Set<Int>.self, from: storedFavoritesData) {
                   self.favoritePostIDs = ids
               }
            
            fetchPosts()
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Error"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        
        
    }
    func success(){
        let response = viewModel.postsData
        self.posts = response
        self.allPosts = response
        
    }
    func filterPosts(with text: String) {
            if text.isEmpty {
                self.posts = allPosts      
            } else {
                self.posts = allPosts.filter {
                    $0.title?.localizedCaseInsensitiveContains(text) ?? false
                }
            }
        }
    func toggleFavorite(postID: Int) {
        if favoritePostIDs.contains(postID) {
            favoritePostIDs.remove(postID)
        } else {
            favoritePostIDs.insert(postID)
        }
        
        // Store in UserDefaults
        if let data = try? JSONEncoder().encode(favoritePostIDs) {
            storedFavoritesData = data
        }
    }
    func fetchPosts() {
        Task{
            SVProgressHUD.show()
            viewModel.errorMessage.removeAll()
            await viewModel.getPosts()
            await SVProgressHUD.dismiss()
            if viewModel.errorMessage == "" || viewModel.errorMessage == nil {
                self.success()
            }else{
                alertMessage = viewModel.errorMessage
                showAlert = true
            }
        }
    }
}
extension String {
    
    func capitalizingFirstLetter() -> String {
        guard let first = self.first else { return self }
        return first.uppercased() + self.dropFirst()
    }
    
}
