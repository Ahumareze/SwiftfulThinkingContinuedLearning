//
//  TypealiasBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Ifeanyi Ahumareze on 16/10/2023.
//

import SwiftUI

struct MovieModel{
    let title: String
    let director: String
    let count: Int
}

typealias TVShowModel = MovieModel

struct TypealiasBootcamp: View {
    
//    @State var item: MovieModel = MovieModel(title: "Rick and Morty", director: "Rick sanchez", count: 50)
    
    @State var item: TVShowModel = TVShowModel(title: "Matrix", director: "ifeanyi", count: 500)
    
    var body: some View {
        VStack{
            Text(item.title)
            Text(item.director)
            Text("\(item.count)")
        }
    }
}

struct TypealiasBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TypealiasBootcamp()
    }
}
