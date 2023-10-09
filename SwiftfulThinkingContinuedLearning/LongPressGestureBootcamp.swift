//
//  LongPressGestureBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Ifeanyi Ahumareze on 01/10/2023.
//

import SwiftUI

struct LongPressGestureBootcamp: View {
    
    @State var isComplete: Bool = false
    @State var isSuccess: Bool = false
    
    var body: some View {
        
        VStack{
            Rectangle()
                .fill(isSuccess ? Color.red : Color.blue)
                .frame(maxWidth: isComplete ? .infinity : 0)
                .frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.cyan)
            
            HStack{
                Text("CLICK HERE")
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50) { (isPressing) in
                        // start of press -> min duration
                        if isPressing{
                            withAnimation(.easeInOut(duration: 1.0)) {
                                isComplete = true
                            }
                        }else{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                if !isSuccess{
                                    withAnimation(.easeInOut(duration: 1.0)) {
                                        isComplete = false
                                    }
                                }
                            }
                        }
                    } perform: {
                        // at the min duration
                        withAnimation {
                            isSuccess = true
                        }
                    }

                
                Text("RESET")
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 1.0)){
                            isComplete = false
                            isSuccess = false
                        }
                    }
            }
        }
        
        
        
        
        
        
        
        
        
//        Text(isComplete ? "Completed" : "Not completed")
//            .padding()
//            .padding(.horizontal)
//            .background(isComplete ? Color.red : Color.gray)
//            .cornerRadius(15)
//            .foregroundColor(Color.white)
//            .onLongPressGesture {
//                isComplete.toggle()
//            }
    }
}

struct LongPressGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGestureBootcamp()
    }
}
