import SwiftUI

struct SettingsView: View {
    @State private var key: String = ""
    
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section("API Configuration") {
                    Text("Placeholder for API Config")
                        .foregroundColor(.secondary)
                }
                
                Section("App Settings") {
                    Text("Placeholder for App Settings")
                        .foregroundColor(.secondary)
                }
                Section("OPEN AI API Key"){
                    SecureField("Enter your api key", text: $key)
                        .onSubmit {
                            saveAPIKey()
                        }

                   
                }
                Section("About") {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Settings")
            .onAppear {
                loadExistingAPIKey()
            }
        }
    }

    private func loadExistingAPIKey() {
        let keychainHandler = KeychainHandler.shared
        if let existingKey = keychainHandler.getValue(.openAIKey) {
            key = existingKey
        }
    }

    private func saveAPIKey() {
        let keychainHandler = KeychainHandler.shared

        guard !key.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            
            return
        }

        if keychainHandler.setValue(key, for: .openAIKey) {
            
        
        } else {
            debugPrint("Failed to save key")
        }
    }
}


