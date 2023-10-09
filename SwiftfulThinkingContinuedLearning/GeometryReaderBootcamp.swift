//
//  GeometryReaderBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Ifeanyi Ahumareze on 01/10/2023.
//

import SwiftUI

struct GeometryReaderBootcamp: View {
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0){
                
                Rectangle()
                    .fill(Color.red)
                    .frame(width: geometry.size.width * 0.6666)
                
                Rectangle()
                    .fill(Color.blue)
            }
            .ignoresSafeArea()
        }
    }
}

struct GeometryReaderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderBootcamp()
    }
}
