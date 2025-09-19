import SwiftUI
import OpenAI

struct PrescriptionsView: View {
    
    @State var result: String = ""
    @State var queryText:String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(result)
                    .foregroundColor(.secondary)
                    .transition(.opacity)
                    .animation(.easeInOut,value: result)
                
                
                
            }
            
            .toolbar(content: {
                ToolbarItem (placement: .bottomBar){
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
            })
            .navigationTitle("Prescriptions")

        }
    }
    
    func getStructuredData(_ query: String) async throws  {
        let handler = KeychainHandler.shared
        guard let apiKey = handler.getValue(.openAIKey) else { return }
        
        let openAI = OpenAI(apiToken: apiKey)
        let query = Prescription.createModelResponseQuery(input: queryText)
        let response = try await openAI.responses.createResponse(query: query)
        for output in response.output {
            switch output {
            case .outputMessage(let message):
                for content in message.content {
                    switch content {
                    case .OutputTextContent(let textContent):
                        result.append(textContent.text)
                    case .RefusalContent(let refusal):
                        // Handle refusal
                        break
                    }
                }
            default:
                // Handle other OutputItems
                break
            }
        }
        return 
    }
}

#Preview {
    PrescriptionsView(result: "", queryText: "")
}
