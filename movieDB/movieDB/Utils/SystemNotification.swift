import Foundation

// sourcery: AutoMockable
protocol SystemNotification {
    func addObserver(forName name: NSNotification.Name?, object obj: Any?, queue: OperationQueue?, using block: @escaping (Notification) -> Void) -> NSObjectProtocol
    func removeObserver(_ observer: Any)
}

extension NotificationCenter: SystemNotification {}

