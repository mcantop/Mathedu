//
//  ContentView.swift
//  Mathedu
//
//  Created by Maciej on 06/08/2022.
//

import SwiftUI

class AppSettings: ObservableObject {
    @Published var operations = [String]()
    @Published var numbersRange = 150.0
    @Published var mutliplicationRange = 10.0
    @Published var numberOfQuestions = 10.0
    @Published var randomOperation = ""
    
    @Published var additionOn = true
    @Published var subtractionOn = false
    @Published var multiplicationOn = true
    @Published var divisionOn = false
    
    @Published var firstRandomNumber = 0
    @Published var secondRandomNumber = 0
    @Published var score = 0
    @Published var questionNumber = 1
    @Published var userAnswer = ""
    @Published var userAnswerIsFocused = false
    
    func restartApp() {
        score = 0
        questionNumber = 1
        
        firstRandomNumber = Int.random(in: 0...Int(numbersRange))
        secondRandomNumber = Int.random(in: 0...Int(numbersRange))
        
        if randomOperation == "/" {
            while firstRandomNumber % secondRandomNumber != 0 {
                firstRandomNumber = Int.random(in: 1...Int(numbersRange))
                secondRandomNumber = Int.random(in: 1...Int(numbersRange))
            }
        } else if randomOperation == "*" {
            firstRandomNumber = Int.random(in: 0...Int(mutliplicationRange))
            secondRandomNumber = Int.random(in: 0...Int(mutliplicationRange))
        }

        userAnswer = ""
        userAnswerIsFocused = false
    }
    
    func assignOperations() {
        if multiplicationOn == true {
            if !operations.contains("*") {
                operations.append("*")
            }
        }
        
        if divisionOn == true {
            if !operations.contains("/") {
                operations.append("/")
            }
        }
        
        if additionOn == true {
            if !operations.contains("+") {
                operations.append("+")
            }
        }
        
        if subtractionOn == true {
            if !operations.contains("-") {
                operations.append("-")
            }
        }
        
        if multiplicationOn == false {
            if operations.contains("*") {
                operations.remove(at: operations.firstIndex(of: "*")!)
            }
        }
        
        if divisionOn == false {
            if operations.contains("/") {
                operations.remove(at: operations.firstIndex(of: "/")!)
            }
        }
        
        if additionOn == false {
            if operations.contains("+") {
                operations.remove(at: operations.firstIndex(of: "+")!)
            }
        }
        
        if subtractionOn == false {
            if operations.contains("-") {
                operations.remove(at: operations.firstIndex(of: "-")!)
            }
        }
    }
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
        .onAppear(perform: assignRandom)
    }
    
    func assignRandom() {
        appSettings.firstRandomNumber = Int.random(in: 2...Int(appSettings.mutliplicationRange))
        appSettings.secondRandomNumber = Int.random(in: 2...Int(appSettings.mutliplicationRange))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
