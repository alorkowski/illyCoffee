import UIKit

final class CoffeeImageTableViewCell: UITableViewCell, ProgrammaticView {
    private let coffeeImage = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .systemRed
        self.setupImageView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup functions
extension CoffeeImageTableViewCell {
    private func setupImageView() {
        self.contentView.addSubview(self.coffeeImage)
        self.coffeeImage.contentMode = .scaleAspectFit
        self.coffeeImage.translatesAutoresizingMaskIntoConstraints = false
        self.coffeeImage.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor).isActive = true
        self.coffeeImage.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.coffeeImage.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.coffeeImage.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
    }
}

// MARK: - Utility Functions
extension CoffeeImageTableViewCell {
    func configure(with coffee: Coffee?) {
        guard let coffee = coffee else { return }
        self.coffeeImage.image = coffee.image
    }
}
