//
//  DragGestureBootcamp2.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Ifeanyi Ahumareze on 01/10/2023.
//

import SwiftUI

struct DragGestureBootcamp2: View {
    
    @State var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.85
    @State var currentDragOffsetY: CGFloat = 0
    @State var endingOffsetY: CGFloat = 0
    
    var body: some View {
        ZStack{
            Color.green.ignoresSafeArea()
            
            mySignupView()
                .offset(y: startingOffsetY)
                .offset(y: currentDragOffsetY)
                .offset(y: endingOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged{value in
                            withAnimation(.spring()){
                                currentDragOffsetY = value.translation.height
                            }
                        }
                        .onEnded{value in
                            withAnimation(.spring()){
                                if currentDragOffsetY < -150{
                                    endingOffsetY = -startingOffsetY
                                }else if endingOffsetY != 0 && currentDragOffsetY > 150{
                                    endingOffsetY = 0
                                }
                                currentDragOffsetY = 0
                            }
                        }
                    
                )
            
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

struct DragGestureBootcamp2_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureBootcamp2()
    }
}

struct mySignupView: View {
    var body: some View {
        VStack(spacing: 20){
            Image(systemName: "chevron.up")
                .padding(.top)
            Text("Sign up")
                .font(.headline)
                .fontWeight(.semibold)
            
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100, alignment: .center)
            
            Text("Description for oup app. Thuis is my favourite swift UI course and I reccomend to all my friends to subscribe to swiftful thinking")
                .multilineTextAlignment(.center)
            
            Text("CREATE AN ACCOUNT")
                .foregroundColor(.white)
                .font(.headline)
                .padding()
                .padding(.horizontal)
                .background(Color.black.cornerRadius(10))
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(20)
    }
}
