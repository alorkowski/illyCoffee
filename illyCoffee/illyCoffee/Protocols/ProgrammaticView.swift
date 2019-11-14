import UIKit

public protocol ProgrammaticView {
    static var identifier: String { get }
}

public extension ProgrammaticView where Self: UIView {
    static var identifier: String {
        return String(describing: Self.self)
    }
}

public extension ProgrammaticView where Self: UITableViewCell {
    static func register(with tableView: UITableView) {
        tableView.register(Self.self, forCellReuseIdentifier: Self.identifier)
    }

    static func dequeue(from tableView: UITableView) -> Self {
        return tableView.dequeueReusableCell(withIdentifier: Self.identifier) as! Self
    }

    static func dequeue(from tableView: UITableView, for indexPath: IndexPath) -> Self {
        return tableView.dequeueReusableCell(withIdentifier: Self.identifier, for: indexPath) as! Self
    }
}
