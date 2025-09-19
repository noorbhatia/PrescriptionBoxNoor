//
//  KeychainHandler.swift
//  PrescriptionBox
//
//  Created by Noor Bhatia on 19/09/25.
//

import Foundation
import Security

enum KeychainError: Error {
    case duplicateEntry
    case unknown(OSStatus)
    case itemNotFound
    case invalidData
}


enum KeychainValues {
    case openAIKey

    var service: String {
        switch self {
        case .openAIKey:
            return "com.prescriptionbox.openai"
        }
    }

    var account: String {
        switch self {
        case .openAIKey:
            return "openai_api_key"
        }
    }
}


final class KeychainHandler {
    
    private let queue = DispatchQueue(label: "keychain.access", attributes: .concurrent)

    func getValue(_ for: KeychainValues) -> String? {
        return queue.sync {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: `for`.service,
                kSecAttrAccount as String: `for`.account,
                kSecReturnData as String: true,
                kSecMatchLimit as String: kSecMatchLimitOne
            ]

            var dataTypeRef: AnyObject?
            let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

            guard status == errSecSuccess else {
                return nil
            }

            guard let data = dataTypeRef as? Data,
                  let value = String(data: data, encoding: .utf8) else {
                return nil
            }

            return value
        }
    }

    @discardableResult
    func setValue(_ value: String, for key: KeychainValues) -> Bool {
        return queue.sync(flags: .barrier) {
            guard let data = value.data(using: .utf8) else {
                return false
            }

            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: key.service,
                kSecAttrAccount as String: key.account,
                kSecValueData as String: data
            ]

            SecItemDelete(query as CFDictionary)
            let status = SecItemAdd(query as CFDictionary, nil)

            return status == errSecSuccess
        }
    }

    @discardableResult
    func deleteValue(_ for: KeychainValues) -> Bool {
        return queue.sync(flags: .barrier) {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: `for`.service,
                kSecAttrAccount as String: `for`.account
            ]

            let status = SecItemDelete(query as CFDictionary)
            return status == errSecSuccess || status == errSecItemNotFound
        }
    }
}
