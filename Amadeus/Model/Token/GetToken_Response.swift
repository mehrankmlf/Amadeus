//
//  RegisterDevice_Resposne.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 10/11/21.
//

import Foundation

struct GetToken_Response : Decodable, Equatable {
    
    var type, username, application_name, client_id: String?
    var token_type: String?
    var access_token: String?
    var expires_in: Int?
    var state: String?
    var scope: String?
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case username = "username"
        case application_name = "application_name"
        case client_id = "client_id"
        case token_type = "token_type"
        case access_token = "access_token"
        case expires_in = "expires_in"
        case state = "state"
        case scope = "scope"
    }
}

extension GetToken_Response {
    static func ==(lhs: GetToken_Response, rhs: GetToken_Response) -> Bool {
        return lhs.access_token == rhs.access_token
    }
}

extension GetToken_Response {
    
    var tokenData : String {
        get{
            guard let token = self.access_token else {return ""}
            return token.trimmingString()
        }
    }
}


