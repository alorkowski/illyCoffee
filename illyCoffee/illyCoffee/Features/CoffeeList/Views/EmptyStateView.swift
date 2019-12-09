import UIKit

final class EmptyStateView: UIView {
    let messageLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupMessageLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Methods
extension EmptyStateView {
    private func setupMessageLabel() {
        self.addSubview(self.messageLabel)
        self.messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.messageLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            self.messageLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20)
        ])
        self.messageLabel.numberOfLines = 0
        self.messageLabel.textAlignment = .center
        self.messageLabel.textColor = .lightText
    }
}

// MARK: Methods
extension EmptyStateView {
    func configure(with message: String) {
        self.messageLabel.text = message
    }
}
