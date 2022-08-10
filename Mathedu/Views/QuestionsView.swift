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
    @State private var endGameState = false
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    if !appSettings.operations.isEmpty {
                        
                        HStack {
                            switch appSettings.randomOperation {
                            case "*":
                                Text("\(appSettings.firstRandomNumber) * \(appSettings.secondRandomNumber) =")
                            case "/":
                                Text("\(appSettings.firstRandomNumber) / \(appSettings.secondRandomNumber) =")
                            case "+":
                                Text("\(appSettings.firstRandomNumber) + \(appSettings.secondRandomNumber) =")
                            case "-":
                                Text("\(appSettings.firstRandomNumber) - \(appSettings.secondRandomNumber) =")
                            default:
                                Text("")
                            }
                            
                            TextField("?", text: $appSettings.userAnswer)
                                .keyboardType(.decimalPad)
                                .focused($userAnswerIsFocused)
                        }
                        
                        Button {
                            calculate()
                        } label: {
                            Text("Check")
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    } else {
                        Text("No operations chosen. Check your settings.")
                            .padding()
                    }
                } header: {
                    Text("Question \(appSettings.questionNumber)/\(appSettings.numberOfQuestions.formatted())")
                }
                .onAppear(perform: appSettings.assignOperations)
                .onAppear(perform: assignRandomOperation)
            }
            .navigationTitle("Mathedu")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Score: \(appSettings.score)")
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAlert = true
                    } label: {
                        Image(systemName: "gobackward")
                        
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("Restart"),
                            message: Text("Do you want to restart?"),
                            primaryButton: .cancel(Text("Back")),
                            secondaryButton: .destructive(
                            Text("Restart"),
                            action: appSettings.restartApp
                            )
                            )
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
                    message: Text("You got \(appSettings.score) score!"),
                    dismissButton: .default(Text("Restart"), action: appSettings.restartApp)
                )
            }
        }
    }
    
    func calculate() {
        var result = 0
        
        switch appSettings.randomOperation {
        case "*":
            result = appSettings.firstRandomNumber * appSettings.secondRandomNumber
        case "/":
            result = appSettings.firstRandomNumber / appSettings.secondRandomNumber
        case "+":
            result = appSettings.firstRandomNumber + appSettings.secondRandomNumber
        case "-":
            result = appSettings.firstRandomNumber - appSettings.secondRandomNumber
        default:
            result = 0
        }
        
        assignRandomOperation()
        
        withAnimation {
            appSettings.score = { Int(appSettings.userAnswer) == result ? appSettings.score + 1 : appSettings.score + 0 }()
            
            appSettings.firstRandomNumber = Int.random(in: 2...Int(appSettings.numbersRange))
            appSettings.secondRandomNumber = Int.random(in: 2...Int(appSettings.numbersRange))
            
            if appSettings.randomOperation == "/" {
                while appSettings.firstRandomNumber % appSettings.secondRandomNumber != 0 {
                    appSettings.firstRandomNumber = Int.random(in: 2...Int(appSettings.numbersRange))
                    appSettings.secondRandomNumber = Int.random(in: 2...Int(appSettings.numbersRange))
                }
            } else if appSettings.randomOperation == "*" {
                appSettings.firstRandomNumber = Int.random(in: 2...Int(appSettings.mutliplicationRange))
                appSettings.secondRandomNumber = Int.random(in: 2...Int(appSettings.mutliplicationRange))
            }
            
            appSettings.questionNumber += 1
            appSettings.userAnswer = ""
        }
        
        if appSettings.questionNumber > Int(appSettings.numberOfQuestions) {
            appSettings.questionNumber = Int(appSettings.numberOfQuestions)
            endGameState = true
            userAnswerIsFocused = false
            return
        }
    }
    
    func assignRandomOperation() {
        appSettings.randomOperation = appSettings.operations.randomElement() ?? ""
        
        if appSettings.randomOperation == "/" {
            while appSettings.firstRandomNumber % appSettings.secondRandomNumber != 0 {
                appSettings.firstRandomNumber = Int.random(in: 1...Int(appSettings.numbersRange))
                appSettings.secondRandomNumber = Int.random(in: 1...Int(appSettings.numbersRange))

            }
        }
    }
}

struct QuestionsView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionsView()
            .environmentObject(AppSettings())
    }
}
