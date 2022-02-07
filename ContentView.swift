//
//  ContentView.swift
//  StopWatch
//
//  Created by 吉郷景虎 on 2020/08/03.
//  Copyright © 2020 Kagetora Yoshigo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var stopWatchManager = StopWatchManager()
    
    var body: some View {
        VStack {
            Text(String(format: "%.1f", stopWatchManager.secondsElapsed))
                .font(.custom("Avenir", size: 40))
                .padding(.top, 200)
                .padding(.bottom, 100)
            if stopWatchManager.mode == .stopped {
                Button(action: {self.stopWatchManager.start()}) {
                    TimerButton(label: "開始", buttonColor: .blue)
                }
            }
            if stopWatchManager.mode == .running {
                Button(action: {self.stopWatchManager.pause()}) {
                    TimerButton(label: "一時停止", buttonColor: .blue)
                }
            }
            if stopWatchManager.mode == .paused {
                Button(action: {self.stopWatchManager.start()}) {
                    TimerButton(label: "開始", buttonColor: .blue)
                }
                Button(action: {self.stopWatchManager.stop()}) {
                    TimerButton(label: "リセット", buttonColor: .red)
                }
                    .padding(.top, 30)
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TimerButton: View {
    
    let label: String
    let buttonColor: Color
    
    var body: some View {
            Text(label)
                .foregroundColor(.white)
                .padding(.vertical, 20)
                .padding(.horizontal, 90)
                .background(buttonColor)
                .cornerRadius(10)
        
    }
}

class StopWatchManager: ObservableObject {
    
    @Published var secondsElapsed = 0.0
    @Published var mode: stopWatchMode = .stopped
    
    enum stopWatchMode
    {
        case running
        case stopped
        case paused
    }
    
    var timer = Timer()
    
    func start() {
        mode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.secondsElapsed += 0.1
        }
    }
    
    func stop() {
        timer.invalidate()
        secondsElapsed = 0
        mode = .stopped
    }
    
    func pause() {
        timer.invalidate()
        mode = .paused
    }
}
