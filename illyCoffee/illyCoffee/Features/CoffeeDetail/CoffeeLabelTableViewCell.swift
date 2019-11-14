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
        self.coffeeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.coffeeLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.coffeeLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        self.coffeeLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.coffeeLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.coffeeLabel.numberOfLines = 0
        self.coffeeLabel.textAlignment = .left
    }
}

// MARK: - Utility Functions
extension CoffeeLabelTableViewCell {
    func configure(with message: String?) {
        guard let message = message else { return }
        self.coffeeLabel.text = message
    }
}
