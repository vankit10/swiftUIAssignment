//
//  File.swift
//  SwiftUI_Assignment
//
//  Created by Ankit on 02/10/25.
//

import Foundation

class PostViewModel : ObservableObject {
    let url = "https://jsonplaceholder.typicode.com/posts"
    @Published var postsData = [PostModel]()
    @Published var errorMessage = String()
    
    func getPosts() async{
      
            do {
                let posts = try await APIManager.shared.fetchData(from: url, modelType: [PostModel].self)
                print(posts)
                DispatchQueue.main.async {
                    self.postsData = posts
                }
                
            } catch {
                
                self.errorMessage = error.localizedDescription
                print("❌ Error fetching posts: \(error.localizedDescription)")
            }
        }
        
    
    
}
