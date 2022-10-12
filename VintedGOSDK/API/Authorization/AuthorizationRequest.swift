struct AuthorizationRequest {
    
    let base64encodedClientIdAndSecret: String
}

extension AuthorizationRequest: Requestable {
    
    var path: String { "/oauth2/default/v1/token" }
    var method: RequestMethod { .post }
    var headers: [String : String] {
        [
            "authorization": base64encodedClientIdAndSecret,
            "cache-control": "no-cache",
            
        ]
    }
}
