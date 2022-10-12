struct NetworkingDependencies {

    let host: String
    let scheme: String
}

extension NetworkingDependencies {

    static let sandbox: NetworkingDependencies = {
        NetworkingDependencies(
            host: "shipping-sandbox.vinted.com",
            scheme: "https"
        )
    }()
    
    static let production: NetworkingDependencies = {
        NetworkingDependencies(
            host: "shipping.vinted.com",
            scheme: "https"
        )
    }()
}
