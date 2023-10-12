//
//  CoreDataRelationsBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Ifeanyi Ahumareze on 12/10/2023.
//

import SwiftUI

class CoreDataManager{
    
}

class CoreDataRelationshipViewmodel: ObservableObject{
    init(){
        
    }
}

struct CoreDataRelationsBootcamp: View {
    
    @StateObject var vm = CoreDataRelationshipViewmodel()
    
    var body: some View {
        Text("Hello world")
    }
}

struct CoreDataRelationsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataRelationsBootcamp()
    }
}
