import UIKit

class CoffeeTableViewCell: UITableViewCell, ProgrammaticView {
    let coffeeImage = UIImageView()
    let coffeeLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupImageView()
        self.setupLabelView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup functions
extension CoffeeTableViewCell {
    private func setupImageView() {
        self.contentView.addSubview(coffeeImage)
        self.coffeeImage.contentMode = .scaleAspectFit
        self.coffeeImage.translatesAutoresizingMaskIntoConstraints = false
        self.coffeeImage.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor).isActive = true
        self.coffeeImage.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.coffeeImage.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.coffeeImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func setupLabelView() {
        self.contentView.addSubview(coffeeLabel)
        self.coffeeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.coffeeLabel.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor).isActive = true
        self.coffeeLabel.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.coffeeLabel.leadingAnchor.constraint(equalTo: self.coffeeImage.trailingAnchor).isActive = true
        self.coffeeLabel.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}

// MARK: - Utility Functions
extension CoffeeTableViewCell {
    func configure(with coffee: Coffee?) {
        guard let coffee = coffee else { return }
        coffeeImage.image = coffee.image
        coffeeLabel.text = coffee.name
    }
}
