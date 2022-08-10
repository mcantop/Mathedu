//
//  SettingsView.swift
//  Mathedu
//
//  Created by Maciej on 06/08/2022.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appSettings: AppSettings
    
    @State private var isEditing = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Slider(value: $appSettings.numberOfQuestions, in: 5...15, step: 1) {
                    } minimumValueLabel: {
                        Text("5")
                    } maximumValueLabel: {
                        Text("15")
                    } onEditingChanged: { editing in
                        isEditing = editing
                        appSettings.restartApp()
                    }
                    .padding(5)
                } header: {
                    Text("Questions: \(appSettings.numberOfQuestions.formatted())")
                }
                
                Section {
                    Toggle("Addition", isOn: $appSettings.additionOn)
                    Toggle("Subtraction", isOn: $appSettings.subtractionOn)
                    Toggle("Multiplication", isOn: $appSettings.multiplicationOn)
                    Toggle("Division", isOn: $appSettings.divisionOn)
                } header: {
                    Text("Operations")
                }
                .onAppear(perform: appSettings.restartApp)
                .toggleStyle(.switch)
                
                Section {
                    Slider(value: $appSettings.numbersRange, in: 100...200, step: 5) {
                    } minimumValueLabel: {
                        Text("100")
                    } maximumValueLabel: {
                        Text("200")
                    } onEditingChanged: { editing in
                        isEditing = editing
                        appSettings.restartApp()
                    }
                    .padding(5)
                } header: {
                    Text("Numbers range: 0 - \(appSettings.numbersRange.formatted())")
                }
                
                Section {
                    Slider(value: $appSettings.mutliplicationRange, in: 0...20, step: 1) {
                    } minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("20")
                    } onEditingChanged: { editing in
                        isEditing = editing
                        appSettings.restartApp()
                    }
                    .padding(5)
                } header: {
                    Text("Multiplication range: 0 - \(appSettings.mutliplicationRange.formatted())")
                }
            }
            .navigationTitle("Mathedu")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(AppSettings())
    }
}
