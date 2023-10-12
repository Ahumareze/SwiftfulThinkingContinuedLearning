//
//  CoreDataBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Ifeanyi Ahumareze on 12/10/2023.
//

import SwiftUI
import CoreData

// View - UI
// Model - data point
// ViewModel - maneges the data for a view

class CoreDataViewModel: ObservableObject{
    
    let container: NSPersistentContainer
    
    @Published var savedEntities: [FruitEntity] = []
    
    init(){
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { (description, error )in
            if let error = error{
                print("Error loading core data. \(error)")
            }else{
                print("Successfully loaded core data!")
            }
        }
        
        fetchFruits()
    }
    
    func fetchFruits(){
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        
        do{
            savedEntities = try container.viewContext.fetch(request)
        }catch let error{
            print("Error fetching \(error)")
        }
    }
    
    func addFruit(name: String, price: Int){
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = name
        newFruit.price = Int32(price)
        
        saveData()
    }
    
    func saveData(){
        do{
            try container.viewContext.save()
            fetchFruits()
        }catch let error{
            print("Error saving \(error)")
        }
    }
    
    func deleteFruit(indexSet: IndexSet){
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        
        saveData()
    }
    
}

struct CoreDataBootcamp: View {
    
    @StateObject var vm = CoreDataViewModel()
    
    @State var textFieldName: String = ""
    @State var textFieldAmount: Int = 1
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                HStack(spacing: 15){
                    TextField("Enter name", text: $textFieldName)
                        .font(.headline)
                        .padding(.horizontal)
                        .frame(height: 55)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        
                    
                    HStack{
                        Button {
                            if textFieldAmount > 1{
                                textFieldAmount = textFieldAmount - 1
                            }
                        } label: {
                            Circle()
                                .frame(width: 40, height: 40, alignment: .center)
                                .overlay {
                                    Image(systemName: "minus")
                                        .foregroundColor(Color.white)
                                }
                                .foregroundColor(Color.orange)
                        }
                        Text("$\(textFieldAmount)")
                        Button {
                            textFieldAmount = textFieldAmount + 1
                        } label: {
                            Circle()
                                .frame(width: 40, height: 40, alignment: .center)
                                .overlay {
                                    Image(systemName: "plus")
                                        .foregroundColor(Color.white)
                                }
                                .foregroundColor(Color.orange)
                        }
                    }

                }.padding(.horizontal)
                
                Button {
                    guard !textFieldName.isEmpty else { return }
                    vm.addFruit(name: textFieldName, price: textFieldAmount)
                } label: {
                    Text("Add fruit")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                
                List {
                    ForEach(vm.savedEntities) { entity in
                        HStack{
                            Text(entity.name ?? "N/A")
                            Spacer()
                            Text("$\(entity.price)")
                        }
                    }
                    .onDelete(perform: vm.deleteFruit)
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationTitle("Fruits")
    }
}

struct CoreDataBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataBootcamp()
    }
}
