//
//  DownloadWithEscapingBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Ifeanyi Ahumareze on 17/10/2023.
//

import SwiftUI

struct PostModel: Identifiable, Codable{
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithEscapingViewModel: ObservableObject{
    
    @Published var posts: [PostModel] = []
    
    init(){
        getPost()
    }
    
    func getPost(){
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        
        downloadData(fromUrl: url) { returnedData in
            if let data = returnedData {
                guard let newPosts = try? JSONDecoder().decode([PostModel].self, from: data) else {return}
                DispatchQueue.main.async { [weak self] in
                    self?.posts = newPosts
                }
            }else{
                print("NO DATA RETURNED")
            }
        }
        
    }
    
    func downloadData(fromUrl url: URL, handler: @escaping (_ data: Data?) -> Void){
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            //first run checks to see if data is succesfully returnes
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else{
                print("ERROR FETCHING DATA")
                handler(nil)
                return
            }
            
            handler(data)
            
        }.resume()
    }
}

struct DownloadWithEscapingBootcamp: View {
    
    @StateObject var vm = DownloadWithEscapingViewModel()
    
    var body: some View {
        List{
            ForEach(vm.posts) { post in
                VStack(alignment: .leading){
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct DownloadWithEscapingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithEscapingBootcamp()
    }
}
