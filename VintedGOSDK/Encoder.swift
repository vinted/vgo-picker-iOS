protocol Encoding {
    
    func convertToBase64(string: String) -> String
}

struct Encoder: Encoding {
    
    func convertToBase64(string: String) -> String {
        Data(string.utf8).base64EncodedString()
    }
}
