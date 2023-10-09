//
//  MultipleSheetsBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Ifeanyi Ahumareze on 01/10/2023.
//

import SwiftUI

struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let color: Color
}

struct MultipleSheetsBootcamp: View {
    
    @State var selectedModel: RandomModel = RandomModel(title: "Starting Title", color: Color.gray)
    @State var showSheet: Bool = false
    
    var body: some View {
        VStack(spacing: 40) {
            Button("Click me") {
                selectedModel = RandomModel(title: "ONE", color: Color.cyan)
                showSheet.toggle()
            }
            
            Button("Click me") {
                selectedModel = RandomModel(title: "TWO", color: Color.red)
                showSheet.toggle()
            }
        }
        .sheet(isPresented: $showSheet) {
            NextScreen(selectedModel: $selectedModel)
        }
    }
}

struct NextScreen: View{
    
    @Binding var selectedModel: RandomModel
    
    var body: some View{
        VStack{
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 300)
                .padding(20)
                .foregroundColor(selectedModel.color)
            Text(selectedModel.title)
                .font(.largeTitle)
            Spacer()
        }
        
    }
}

struct MultipleSheetsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetsBootcamp()
    }
}
