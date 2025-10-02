//
//  FavoritesView.swift
//  SwiftUI_Assignment
//
//  Created by Ankit on 02/10/25.
//

import SwiftUI
import SVProgressHUD

struct FavoritesView: View {
    @AppStorage("favoritePostIDs") var storedFavoritesData: Data = Data()
        @State private var favoritePostIDs: Set<Int> = []
        @State private var favoritePosts: [PostModel] = []
    @StateObject var viewModel = PostViewModel()
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    var body: some View {
        VStack{
            
            HeaderView(title: "Favorites")
            
            VStack {
                if favoritePosts.count != 0{
                    List {
                        ForEach(favoritePosts, id: \.id) { post in
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
                    .edgesIgnoringSafeArea(.all)
                }
            }
        }
        .background(.darkgray)
        .onAppear {
            if let ids = try? JSONDecoder().decode(Set<Int>.self, from: storedFavoritesData) {
                        favoritePostIDs = ids
                    }
            Task{
                SVProgressHUD.show()
                await viewModel.getPosts()
                await SVProgressHUD.dismiss()
                if viewModel.errorMessage == "" || viewModel.errorMessage == nil {
                    self.success()
                }else{
                    
                }
            }
            
        }
        .onChange(of: favoritePostIDs) { _ in
                   updateFavoritePosts()
                   // Also save changes to AppStorage
                   if let data = try? JSONEncoder().encode(favoritePostIDs) {
                       storedFavoritesData = data
                   }
               }
        
    }
    func success(){
        let response = viewModel.postsData
        DispatchQueue.main.async {
            self.favoritePosts = response.filter { favoritePostIDs.contains($0.id ?? -1) }
            print("Favoritess \(self.favoritePosts)")
        }
    }
    func updateFavoritePosts() {
           DispatchQueue.main.async {
               self.favoritePosts = viewModel.postsData.filter { favoritePostIDs.contains($0.id ?? -1) }
           }
       }

       func toggleFavorite(postID: Int) {
           if favoritePostIDs.contains(postID) {
               favoritePostIDs.remove(postID)
           } else {
               favoritePostIDs.insert(postID)
           }
         
       }
    

}
