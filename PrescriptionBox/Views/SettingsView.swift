import SwiftUI

struct SettingsView: View {
    @State private var key: String = ""
    @State private var saveStatus: String = ""
    private let keychainHandler = KeychainHandler()
    
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

                    if !saveStatus.isEmpty {
                        Text(saveStatus)
                            .foregroundColor(saveStatus.contains("saved") ? .green : .red)
                            .font(.caption)
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
        if let existingKey = keychainHandler.getValue(.openAIKey) {
            key = existingKey
        }
    }

    private func saveAPIKey() {
        guard !key.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            saveStatus = "Please enter a valid API key"
            return
        }

        if keychainHandler.setValue(key, for: .openAIKey) {
            saveStatus = "API key saved successfully"
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                saveStatus = ""
            }
        } else {
            saveStatus = "Failed to save API key"
        }
    }
}


