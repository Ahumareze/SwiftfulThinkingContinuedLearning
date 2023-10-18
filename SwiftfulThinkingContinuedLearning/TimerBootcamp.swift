//
//  TimerBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Ifeanyi Ahumareze on 18/10/2023.
//

import SwiftUI

struct TimerBootcamp: View {
    
    let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
    
    @State var currentDate: Date = Date()
    
    
    //Current time
    /*
    var dateFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }
     */
    
    //Countdown
    /*
    @State var count: Int = 10
    @State var finishedText: String? = nil
     */
    
    //Countdown to date
    /*
    @State var timeRemaining: String = ""
    let futureDate: Date = Calendar.current.date(byAdding: .minute, value: 5, to: Date()) ?? Date()
    
    func updateTimeRemaining(){
        let remaining = Calendar.current.dateComponents([.minute, .second], from: Date(), to: futureDate)
        let minute = remaining.minute ?? 0
        let seconds = remaining.second ?? 0
        
        timeRemaining = "\(minute) minutes, \(seconds) seconds"
    }
     */
    
    //Animation counter
    @State var count: Int = 1
    
    var body: some View {
        ZStack{
            RadialGradient(
                gradient: Gradient(colors: [Color(.blue), Color(.purple)]),
                center: .center,
                startRadius: 5,
                endRadius: 500)
            .ignoresSafeArea()
            
            TabView(selection: $count,
                    content: {
                Rectangle()
                    .foregroundColor(.red)
                    .tag(1)
                Rectangle()
                    .foregroundColor(.blue)
                    .tag(2)
                Rectangle()
                    .foregroundColor(.green)
                    .tag(3)
                Rectangle()
                    .foregroundColor(.orange)
                    .tag(4)
                Rectangle()
                    .foregroundColor(.pink)
                    .tag(5)
            })
            .frame(height: 200)
            .tabViewStyle(PageTabViewStyle())
        }
        .onReceive(timer) { _ in
            withAnimation(.default){
                count = count == 5 ? 1 : count + 1
            }
        }
    }
}

struct TimerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TimerBootcamp()
    }
}
