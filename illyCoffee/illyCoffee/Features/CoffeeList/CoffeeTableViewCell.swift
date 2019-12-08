import UIKit

class CoffeeTableViewCell: UITableViewCell, ProgrammaticView {
    let mainView = WhiteRoundedView()
    let coffeeImage = UIImageView()
    let coffeeLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.setupContentView()
        self.setupImageView()
        self.setupLabelView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }
}

// MARK: - Setup Methods
extension CoffeeTableViewCell {
    private func setupContentView() {
        self.contentView.addSubview(self.mainView)
        self.contentView.sendSubviewToBack(self.mainView)
        self.mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.mainView.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor, constant: 2),
            self.mainView.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor, constant: -2),
            self.mainView.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor),
            self.mainView.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    private func setupImageView() {
        self.mainView.addSubview(self.coffeeImage)
        self.coffeeImage.contentMode = .scaleAspectFit
        self.coffeeImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.coffeeImage.topAnchor.constraint(equalTo: self.mainView.safeAreaLayoutGuide.topAnchor),
            self.coffeeImage.bottomAnchor.constraint(equalTo: self.mainView.safeAreaLayoutGuide.bottomAnchor),
            self.coffeeImage.leadingAnchor.constraint(equalTo: self.mainView.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            self.coffeeImage.widthAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setupLabelView() {
        self.mainView.addSubview(self.coffeeLabel)
        self.coffeeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.coffeeLabel.topAnchor.constraint(equalTo: self.mainView.safeAreaLayoutGuide.topAnchor),
            self.coffeeLabel.bottomAnchor.constraint(equalTo: self.mainView.safeAreaLayoutGuide.bottomAnchor),
            self.coffeeLabel.leadingAnchor.constraint(equalTo: self.coffeeImage.trailingAnchor, constant: 8),
            self.coffeeLabel.trailingAnchor.constraint(equalTo: self.mainView.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

// MARK: - Methods
extension CoffeeTableViewCell {
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
        self.coffeeLabel.text = coffee.name
    }
}
