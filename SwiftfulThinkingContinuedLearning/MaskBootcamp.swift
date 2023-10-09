//
//  MaskBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Ifeanyi Ahumareze on 01/10/2023.
//

import SwiftUI

struct MaskBootcamp: View {
    
    @State var rating: Int = 0
    
    var body: some View {
        ZStack{
            starsView
                .overlay {
                    overlayView.mask(starsView)
                }
        }
    }
    
    private var starsView: some View {
        HStack{
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(Color.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut){
                            rating = index
                        }
                    }
            }
            
        }
    }
    
    private var overlayView: some View{
        GeometryReader{geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color.yellow)
                    .frame(width: CGFloat(rating) / 5 * geometry.size.width)
            }
        }
        .allowsHitTesting(false)
    }
    
}

struct MaskBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MaskBootcamp()
    }
}
