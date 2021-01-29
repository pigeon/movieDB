import Network

protocol ConnectionManager {
    var connected: Bool { get }
}

class ConnectionManagerImpl: ConnectionManager {
    var connected: Bool {
        return connectionStatus
    }

    private var connectionStatus: Bool = false
    private let monitor = NWPathMonitor()

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else {
                return
            }
            if path.status == .satisfied {
                self.connectionStatus = true
            } else {
                self.connectionStatus = false
            }
        }
    }

}
