//
//  QuestionsView.swift
//  Mathedu
//
//  Created by Maciej on 06/08/2022.
//

import SwiftUI

struct QuestionsView: View {
    @EnvironmentObject var appSettings: AppSettings
    @FocusState private var userAnswerIsFocused: Bool
    @State private var score = 0
    @State private var firstRandomNumber = Int.random(in: 2...Int(AppSettings().mutliplicationRange))
    @State private var secondRandomNumber = Int.random(in: 2...Int(AppSettings().mutliplicationRange))
    @State private var userAnswer = ""
    @State private var questionNumber = 1
    @State private var endGameState = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("\(firstRandomNumber) * \(secondRandomNumber) =")
                            .fontWeight(.bold)
                        TextField("?", text: $userAnswer)
                            .keyboardType(.decimalPad)
                            .focused($userAnswerIsFocused)
                    }
                    
                    Button {
                        calculate()
                    } label: {
                        Text("Check")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                } header: {
                    Text("Question \(questionNumber)/\(appSettings.numberOfQuestions.formatted())")
                }
            }
            .navigationTitle("Mathedu")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Score: \(score)")
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        restartApp()
                    } label: {
                        Image(systemName: "gobackward")

                    }
                }
                
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Check") {
                        calculate()
                    }
                }
                
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Hide") {
                        userAnswerIsFocused = false
                    }
                }
            }
            .alert (isPresented: $endGameState) {
                Alert(
                    title: Text("That was the last question"),
                    message: Text("You got \(score) score!"),
                    dismissButton: .default(Text("Restart"), action: restartApp)
                )
            }
        }
    }
    
    func calculate() {
        let result = firstRandomNumber * secondRandomNumber
        
        withAnimation {
            score = { Int(userAnswer) == result ? score + 1 : score + 0 }()
            firstRandomNumber = Int.random(in: 2...Int(appSettings.mutliplicationRange))
            secondRandomNumber = Int.random(in: 2...Int(appSettings.mutliplicationRange))
            questionNumber += 1
            userAnswer = ""
        }
        
        if questionNumber > Int(appSettings.numberOfQuestions) {
            questionNumber = Int(appSettings.numberOfQuestions)
            endGameState = true
            userAnswerIsFocused = false
            return
        }
    }
    
    func restartApp() {
        score = 0
        questionNumber = 1
        firstRandomNumber = Int.random(in: 2...Int(appSettings.mutliplicationRange))
        secondRandomNumber = Int.random(in: 2...Int(appSettings.mutliplicationRange))
        userAnswer = ""
        userAnswerIsFocused = false
    }
}

struct QuestionsView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionsView()
            .environmentObject(AppSettings())
    }
}
