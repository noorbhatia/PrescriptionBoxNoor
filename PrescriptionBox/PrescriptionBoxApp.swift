//
//  PrescriptionBoxApp.swift
//  PrescriptionBox
//
//  Created by Aditya Kadam on 31/08/25.
//

import SwiftUI

@main
struct PrescriptionBoxApp: App {
    private let keychainHandler = KeychainHandler()
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        
    }
}
