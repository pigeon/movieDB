import Network
import os

// sourcery: AutoMockable
protocol ConnectionManager {
    var connected: Bool { get }
}

class ConnectionManagerImpl: ConnectionManager {
    var connected: Bool {
        return connectionStatus
    }

    private var connectionStatus: Bool = true
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
        monitor.start(queue: DispatchQueue.global(qos: .background))
    }

    deinit {
        monitor.cancel()
    }
}
