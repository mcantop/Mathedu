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
                    VStack {
                        Text("Multiplication: 2 - \(appSettings.mutliplicationRange.formatted())")
                        Slider(value: $appSettings.mutliplicationRange, in: 2...12, step: 1) {
                        } minimumValueLabel: {
                            Text("2")
                        } maximumValueLabel: {
                            Text("12")
                        } onEditingChanged: { editing in
                            isEditing = editing
                        }
                    }
                    .padding()
                    VStack {
                        Section {
                            Text("Questions: \(appSettings.numberOfQuestions.formatted())")
                            Slider(value: $appSettings.numberOfQuestions, in: 5...15, step: 1) {
                            } minimumValueLabel: {
                                Text("5")
                            } maximumValueLabel: {
                                Text("15")
                            } onEditingChanged: { editing in
                                isEditing = editing
                            }
                        }
                    }
                    .padding()
                } header: {
                    Text("Settings")
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
