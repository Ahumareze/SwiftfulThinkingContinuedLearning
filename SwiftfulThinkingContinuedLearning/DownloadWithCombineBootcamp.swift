//
//  DownloadWithCombineBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Ifeanyi Ahumareze on 17/10/2023.
//

import SwiftUI
import Combine

class DownloadWithCombineViewmodel: ObservableObject{
    
    @Published var posts: [PostModel] = []
    
    var cancellebles = Set<AnyCancellable>()
    
    init(){
        getPosts()
    }
    
    func getPosts(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        
        // 1. create the publisher
        // 2. subscribe publisher on background thread
        // 3. recieve on main thread
        // 4. trymap (check that the data is good)
        // 5. decode (decode data into postmodels
        // 6. sink (put the item in our app)
        // 7. store (cancle subscription if needed)
        
        URLSession.shared.dataTaskPublisher(for: url)
//            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                
                guard
                    let response = response as? HTTPURLResponse,
                    response.statusCode >= 200 && response.statusCode < 300 else{
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .sink{ (completion) in
                print("Completion: \(completion)")
            }receiveValue: { [weak self] (returnedPosts) in
                self?.posts = returnedPosts
            }
            .store(in: &cancellebles)
    }
    
}

struct DownloadWithCombineBootcamp: View {
    
    @StateObject var vm = DownloadWithCombineViewmodel()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading){
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

struct DownloadWithCombineBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithCombineBootcamp()
    }
}
