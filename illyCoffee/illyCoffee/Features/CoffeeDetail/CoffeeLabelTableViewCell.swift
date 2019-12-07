import UIKit

final class CoffeeLabelTableViewCell: UITableViewCell, ProgrammaticView {
    private let coffeeLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupLabelView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Functions
extension CoffeeLabelTableViewCell {
    private func setupLabelView() {
        self.contentView.addSubview(self.coffeeLabel)
        self.coffeeLabel.numberOfLines = 0
        self.coffeeLabel.textAlignment = .left
        self.coffeeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.coffeeLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.coffeeLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.coffeeLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            self.coffeeLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8)
        ])
    }
}

// MARK: - Utility Functions
extension CoffeeLabelTableViewCell {
    func configure(with message: String?) {
        guard let message = message else { return }
        self.coffeeLabel.text = message
    }
}
