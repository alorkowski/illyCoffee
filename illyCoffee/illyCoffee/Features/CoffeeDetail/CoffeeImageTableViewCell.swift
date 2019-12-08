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

// MARK: - Setup Methods
extension CoffeeImageTableViewCell {
    private func setupImageView() {
        self.contentView.addSubview(self.coffeeImage)
        self.coffeeImage.contentMode = .scaleAspectFit
        self.coffeeImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.coffeeImage.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor),
            self.coffeeImage.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor),
            self.coffeeImage.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor,
                                                      constant: 8),
            self.coffeeImage.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor,
                                                       constant: -8)
        ])
    }
}

// MARK: - Methods
extension CoffeeImageTableViewCell {
    func configure(with coffee: Coffee?) {
        guard let coffee = coffee else { return }
        ImageCache.shared.retreiveImage(for: coffee.urlAlias) {
            [weak self] result in
            switch result {
            case .success(let image):
                self?.coffeeImage.image = image
            case .failure:
                self?.coffeeImage.image = UIImage()
            }
        }
    }
}
