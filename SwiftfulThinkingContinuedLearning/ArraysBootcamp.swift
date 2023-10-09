//
//  ArraysBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Ifeanyi Ahumareze on 02/10/2023.
//

import SwiftUI

struct userModel: Identifiable {
    
    let id = UUID().uuidString
    let name: String
    let points: Int
    let isVerified: Bool
    
}

class ArrayModificationViewModel: ObservableObject{
    
    @Published var dataArray: [userModel] = []
    @Published var filteredArray: [userModel] = []
    
    init(){
        getusers()
    }
    
    func getusers(){
        let user1 = userModel(name: "Nick", points: 12, isVerified: true)
        let user2 = userModel(name: "Jane", points: 5, isVerified: false)
        let user3 = userModel(name: "Morty", points: 3, isVerified: true)
        let user4 = userModel(name: "Smith", points: 10, isVerified: false)
        let user5 = userModel(name: "Chris", points: 34, isVerified: false)
        let user6 = userModel(name: "Joe", points: 22, isVerified: true)
        let user7 = userModel(name: "Mary", points: 5, isVerified: false)
        let user8 = userModel(name: "Hitler", points: 77, isVerified: true)
        let user9 = userModel(name: "Albert", points: 0, isVerified: false)
        let user10 = userModel(name: "Einstein", points: 4, isVerified: false)
        
        self.dataArray.append(contentsOf: [
            user1,
            user2,
            user3,
            user4,
            user5,
            user6,
            user7,
            user8,
            user9,
            user10
        ])
    }
    
    func updateFilteredArray(){
        
    }
    
}

struct ArraysBootcamp: View {
    
    @StateObject var vm = ArrayModificationViewModel()
    
    var body: some View {
        ScrollView{
            VStack(spacing: 20) {
                ForEach(vm.dataArray) { user in
                    VStack(alignment: .leading){
                        Text(user.name)
                            .font(.headline)
                        HStack{
                            Text("Points: \(user.points)")
                            Spacer()
                            if user.isVerified{
                                Image.init(systemName: "flame.fill")
                            }
                        }
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue.cornerRadius(10))
                    .padding(.horizontal)
                }
            }
        }
    }
}

struct ArraysBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ArraysBootcamp()
    }
}
