protocol Logging {

    func log(message: String)
    func log(_ object: Any)
}

struct Logger {

    private init() {}

    static let shared: Logging = ConsoleLogger()
}

struct ConsoleLogger: Logging {

    func log(message: String) {
        log(string: message)
    }

    func log(_ object: Any) {
        log(string: String(describing: object))
    }

    private func log(string: String) {
        if AppConfiguration.isDebug {
            print("📜" + string)
        }
    }
}
