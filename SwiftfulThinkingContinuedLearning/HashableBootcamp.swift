//
//  HashableBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Ifeanyi Ahumareze on 02/10/2023.
//

import SwiftUI

struct MyCustomModel: Identifiable {
    let id: String
    let title: String
    
}

struct HashableBootcamp: View {
    
    let data: [MyCustomModel] = [
        MyCustomModel( id: "hello", title: "ONE"),
        MyCustomModel( id: "hi", title: "TWO")
//        MyCustomModel(title: "TWO"),
//        MyCustomModel(title: "THREE"),
//        MyCustomModel(title: "FOUR"),
//        MyCustomModel(title: "FIVE")
    ]
    
    var body: some View {
        ScrollView{
            VStack(spacing: 40){
                ForEach(data) { item in
                    Text(item.id)
                        .font(.headline)
                }
            }
        }
    }
}

struct HashableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        HashableBootcamp()
    }
}
