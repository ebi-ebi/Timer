//
//  ContentView.swift
//  Timer
//
//  Created by billy on 9/28/23.
//

import SwiftUI

struct ContentView: View {
   
    var body: some View {
        NavigationView {
            TimerEditView()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Timer")
                }
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink (destination: TimerEditView()) {
//                        Text("+")
//                    }
//                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            
            ContentView()
                .environment(\.colorScheme, .dark)
        }
    }
}
