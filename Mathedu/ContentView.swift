//
//  ContentView.swift
//  Mathedu
//
//  Created by Maciej on 06/08/2022.
//

import SwiftUI

class AppSettings: ObservableObject {
    @Published var mutliplicationRange = 7.0
    @Published var numberOfQuestions = 10.0
}

struct ContentView: View {
    @StateObject private var appSettings = AppSettings()

    var body: some View {
        TabView {
            QuestionsView()
                .tabItem {
                    Label("Questions", systemImage: "questionmark")
                }
                .environmentObject(appSettings)
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
                .environmentObject(appSettings)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
