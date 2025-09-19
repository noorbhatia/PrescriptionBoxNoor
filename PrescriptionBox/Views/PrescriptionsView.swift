import SwiftUI

struct PrescriptionsView: View {
    
    @State var result: String
    @State var queryText:String
    @EnvironmentObject var keychainHandler: KeychainHandler
    var body: some View {
        NavigationStack {
            VStack {
                Text(result)
                    .foregroundColor(.secondary)
                
                TextField(text: $queryText) {
                    Text("Enter prescription")
                }
                .onSubmit {
                    Task{
                        do{
                            try await getStructuredData(queryText)
                        } catch{
                            debugPrint("Error in getting data: \(error.localizedDescription)")
                        }
                    }
                }
            }
            .navigationTitle("Prescriptions")

        }
    }
    
    func getStructuredData(_ query: String) async throws ->  String {
        
        guard let apiKey =
        return ""
    }
}
