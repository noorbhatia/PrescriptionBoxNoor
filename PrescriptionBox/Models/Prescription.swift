import Foundation
import OpenAI

struct Prescription: Codable {
    let patientName: String
    let medicationName: String
    let dosage: String
    let frequency: String
    let prescribedDate: Date
    let doctorName: String
    let notes: String?
    
    init(
        patientName: String,
        medicationName: String,
        dosage: String,
        frequency: String,
        prescribedDate: Date,
        doctorName: String,
        notes: String? = nil
    ) {
        self.patientName = patientName
        self.medicationName = medicationName
        self.dosage = dosage
        self.frequency = frequency
        self.prescribedDate = prescribedDate
        self.doctorName = doctorName
        self.notes = notes
    }

    static func openAISchema() -> JSONSchema {
        return .init(
            .type(.object),
            .properties([
                "patientName": .init(.type(.string)),
                "medicationName": .init(.type(.string)),
                "dosage": .init(.type(.string)),
                "frequency": .init(.type(.string)),
                "prescribedDate": .init(.type(.string)),
                "doctorName": .init(.type(.string)),
                "notes": .init(.type(.string))
            ]),
            .required(["patientName", "medicationName", "dosage", "frequency", "prescribedDate", "doctorName"]),
            .additionalProperties(.boolean(false))
        )
    }

    static func createModelResponseQuery(input: String) -> CreateModelResponseQuery {
        return CreateModelResponseQuery(
            input: .textInput(input),
            model: .gpt4_o,
            text: .jsonSchema(.init(
                name: "prescription_extraction",
                schema: .jsonSchema(openAISchema()),
                description: "Extract prescription information from free text into structured data",
                strict: false
            ))
        )
    }
}
