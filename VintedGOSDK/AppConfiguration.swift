enum AppConfiguration {

    static var isDebug: Bool {
#if DEBUG
        return true
#else
        return false
#endif
    }
}
