//
//  KeychainStore.swift
//  Amadeus
//
//  Created by Mehran on 7/6/1401 AP.
//

import Foundation
import Security

struct KeychainStore {
    
    private static let kSavedItemAccessDescription = "savedItemAccessDescriptionKeychainItem"
    
    /// Saves value to Keychain.
    ///
    /// ```
    /// save(value: "Hello", key: "secureKey") // true
    /// ```
    ///
    /// - Warning: Value must be confirmed to Codable.
    /// - Parameter value: Data that should be saved to Keychain.
    /// - Parameter key: Unique data identifier.
    /// - Returns: Success of saving.
    @discardableResult
    public static func save<T: Codable>(value: T, key: String, succes: (() -> Void)? = nil, failure: ((OSStatus?) -> Void)? = nil) -> Bool {
        guard let descriptionType = getStringType(for: value) else {
            failure?(nil)
            return false
        }
        
        guard let valueData = descriptionType == .string ? (value as? String)?.data(using: .utf8) : try? JSONEncoder().encode(value) else {
            failure?(nil)
            return false
        }
        
        let keychainItem = [kSecClass: kSecClassGenericPassword,
                            kSecAttrComment: descriptionType.rawValue,
                            kSecReturnData: true,
                            kSecReturnAttributes: true,
                            kSecAttrDescription: kSavedItemAccessDescription,
                            kSecAttrAccount: key,
                            kSecValueData: valueData] as CFDictionary
        
        var result: AnyObject?
        let status = SecItemAdd(keychainItem, &result)
        
        if status == 0 {
            succes?()
            return true
        } else {
            failure?(status)
            return false
        }
    }
    
    /// Returns data from Keychain without declaring type in parameters.
    ///
    /// ```
    /// get(forKey: "secureKey") as? String // "Hello"
    /// ```
    ///
    /// - Warning: You need to cast the type of function result.
    /// - Parameter key: Unique data identifier.
    /// - Returns: Saved info with type Any?
    @discardableResult
    public static func get(forKey key: String, succes: ((Any?) -> Void)? = nil, failure: (() -> Void)? = nil) -> Any? {
        
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrDescription: kSavedItemAccessDescription,
            kSecAttrAccount: key,
            kSecReturnData: true,
            kSecReturnAttributes: true,
            kSecMatchLimit: 1,
        ] as CFDictionary
        
        var result: AnyObject?
        let _ = SecItemCopyMatching(query, &result)
        
        guard let resultDict = result as? NSDictionary else {
            failure?()
            return nil
        }
        
        guard let savedTypeData = resultDict[kSecAttrComment] as? String else {
            failure?()
            return nil
        }
        
        guard let savedStandartDataType = StandartDataTypes(rawValue: savedTypeData) else {
            failure?()
            return nil
        }
        
        guard let secureData = resultDict[kSecValueData] as? Data else {
            failure?()
            return nil
        }
        let finalResult = decodedResult(from: secureData, forType: savedStandartDataType)
        succes?(finalResult)
        return finalResult
    }
    
    /// Returns data from Keychain with declaring type in parameters.
    ///
    /// ```
    /// get(forKey: "secureKey", asType: String.self) // "Hello"
    /// ```
    ///
    /// - Warning: Don't forget to safetly unwrap the optional.
    /// - Parameter key: Unique data identifier.
    /// - Parameter type: Original type of value.
    /// - Returns: Saved info with transferred type.
    @discardableResult
    public static func get<T: Codable>(forKey key: String, asType type: T.Type, succes: ((T?) -> Void)? = nil, failure: (() -> Void)? = nil) -> T? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrDescription: kSavedItemAccessDescription,
            kSecAttrAccount: key,
            kSecReturnData: true,
            kSecReturnAttributes: true,
            kSecMatchLimit: 1,
        ] as CFDictionary
        
        var result: AnyObject?
        _ = SecItemCopyMatching(query, &result)
        
        guard let resultDict = result as? NSDictionary else {
            failure?()
            return nil
        }
        
        guard let secureData = resultDict[kSecValueData] as? Data,
              let secureInfo: T = type == String.self ? (String(data: secureData, encoding: .utf8) as? T) : try? JSONDecoder().decode(T.self, from: secureData) else {
            failure?()
            return nil
        }
        succes?(secureInfo)
        return secureInfo
    }
    
    /// Updates saved value by key.
    ///
    /// ```
    /// update(value: 2021, forKey: "secureKey")
    /// ```
    ///
    /// - Parameter value: New value.
    /// - Parameter key: Unique data identifier.
    /// - Returns: Success of updating.
    @discardableResult
    public static func update<T: Codable>(value: T, forKey key: String, succes: (() -> Void)? = nil, failure: ((OSStatus?) -> Void)? = nil) -> Bool {
        
        guard let descriptionType = getStringType(for: value) else {
            failure?(nil)
            return false
        }
        
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrDescription: kSavedItemAccessDescription,
            kSecAttrAccount: key
        ] as CFDictionary
        
        guard let secureData = descriptionType == .string ? (value as? String)?.data(using: .utf8) : try? JSONEncoder().encode(value) else {
            failure?(nil)
            return false
        }
        
        let updateFields = [
            kSecValueData: secureData,
            kSecAttrComment : descriptionType.rawValue
        ] as CFDictionary
        
        let status = SecItemUpdate(query, updateFields)
        
        if status == 0 {
            succes?()
            return true
        } else {
            failure?(status)
            return false
        }
        
    }
    
    /// Removes data from Keychain.
    ///
    /// ```
    /// erase(key: "secureKey")
    /// ```
    ///
    /// - Parameter key: Unique data identifier.
    /// - Returns: Success of removing.
    @discardableResult
    public static func erase(key: String, succes: (() -> Void)? = nil, failure: ((OSStatus?) -> Void)? = nil) -> Bool {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrDescription: kSavedItemAccessDescription,
            kSecAttrAccount: key,
            kSecReturnData: true,
            kSecReturnAttributes: true,
        ] as CFDictionary
        
        let status = SecItemDelete(query)
        if status == 0 {
            succes?()
            return true
        } else {
            failure?(status)
            return false
        }
    }
    
    /// Removes all data related to App from Keychain.
    ///
    /// ```
    /// eraseAll()
    /// ```
    ///
    public static func eraseAll() {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrDescription: kSavedItemAccessDescription,
            kSecMatchLimit: 100,
        ] as CFDictionary
        
        var result: OSStatus
        repeat {
            result = SecItemDelete(query)
        } while result == 0
    }
}

internal enum StandartDataTypes: String {
    case int
    case uInt
    case float
    case double
    case bool
    case string
    case data
}

extension KeychainStore {
    internal static func decodedResult(from data: Data, forType type: StandartDataTypes) -> Any? {
        var finalResult: Any?
        
        switch type {
        case .int:
            finalResult = try? JSONDecoder().decode(Int.self, from: data)
        case .uInt:
            finalResult = try? JSONDecoder().decode(UInt.self, from: data)
        case .float:
            finalResult = try? JSONDecoder().decode(Float.self, from: data)
        case .double:
            finalResult = try? JSONDecoder().decode(Double.self , from: data)
        case .bool:
            finalResult = try? JSONDecoder().decode(Bool.self, from: data)
        case .string:
            finalResult = String(data: data, encoding: .utf8)
        case .data:
            finalResult = data
        }
        
        return finalResult
    }
    
    internal static func getStringType<T: Codable>(for item: T) -> StandartDataTypes? {
        switch item {
        case is Int:
            return .int
        case is UInt:
            return .uInt
        case is Float:
            return .float
        case is Double:
            return .double
        case is Bool:
            return .bool
        case is String:
            return .string
        default:
            return .data
        }
    }
}
