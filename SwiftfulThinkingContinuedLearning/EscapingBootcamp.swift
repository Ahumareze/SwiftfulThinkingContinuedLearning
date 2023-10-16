//
//  EscapingBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Ifeanyi Ahumareze on 16/10/2023.
//

import SwiftUI

class EscapingViewModel: ObservableObject{
    
    @Published var text:String = "Text"
    
    func getData(){
        downloadData3 {[weak self] data in
            self?.text = data
        }
    }
    
    func downloadData() -> String{
        return "New Data"
    }
    
    func downloadData2(handler: (_ data: String) -> Void){
        handler("NEW DATA 2 !!!")
    }
    
    func downloadData3(handler: @escaping (_ data: String) -> Void){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            handler("NEW DATA 3 !!!")
        }
    }
    
}

struct EscapingBootcamp: View {
    
    @StateObject var vm = EscapingViewModel()
    
    var body: some View {
        Text(vm.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.blue)
            .onTapGesture {
                vm.getData()
            }
    }
}

struct EscapingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        EscapingBootcamp()
    }
}
