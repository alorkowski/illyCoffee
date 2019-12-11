import UIKit

final class CoffeeDetailViewController: UITableViewController {
    var coffeeDetailViewModel: CoffeeDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppData.Colors.illyCoffee
        self.title = self.coffeeDetailViewModel.name
        self.setupNavigationBar()
        self.setupTableView()
    }
}

// MARK: - CoffeeDetailTraits
extension CoffeeDetailViewController {
    struct CoffeeDetailTraits {
        static let numberOfSections: Int = 4
        static let heightForRowAt: CGFloat = 44
        static let heightForCoffeeImageTableViewCell: CGFloat = min(400, UIScreen.main.bounds.height / 2)
        static let heightForHeaderInSection: CGFloat = 70
        static let titleForHeaderInIngredientsSection: String = "Ingredients"
        static let titleForHeaderInPreparationSection: String = "Preparation"
    }
}

// MARK: - Setup Methods
extension CoffeeDetailViewController {
    private func setupNavigationBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back",
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(done))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                                 target: self,
                                                                 action: #selector(saveCoffeeToFavorites))
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        self.navigationItem.rightBarButtonItem?.tintColor = .white
    }

    private func setupTableView() {
        self.tableView.estimatedRowHeight = CoffeeDetailTraits.heightForRowAt
        self.tableView.allowsSelection = false
        self.tableView.backgroundColor = AppData.Colors.illyCoffee
        self.setupTableFooter()
        CoffeeImageTableViewCell.register(with: self.tableView)
        CoffeeLabelTableViewCell.register(with: self.tableView)
    }

    private func setupTableFooter() {
        let footerView = UIView()
        footerView.backgroundColor = .white
        self.tableView.tableFooterView = footerView
    }
}

// MARK: - @objc Methods
extension CoffeeDetailViewController {
    @objc func saveCoffeeToFavorites() {
        self.coffeeDetailViewModel.addFavorite()
        self.navigationController?.popViewController(animated: true)
    }

    @objc func done() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDataSource
extension CoffeeDetailViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return CoffeeDetailTraits.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 1:
            return 1
        case 2:
            return self.coffeeDetailViewModel.numberOfIngredients
        case 3:
            return self.coffeeDetailViewModel.numberOfPreparations
        default:
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 2:
            return CoffeeDetailTraits.titleForHeaderInIngredientsSection
        case 3:
            return CoffeeDetailTraits.titleForHeaderInPreparationSection
        default:
            return nil
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = CoffeeImageTableViewCell.dequeue(from: tableView, for: indexPath)
            cell.configure(with: self.coffeeDetailViewModel.coffee)
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            return cell
        case 1:
            let cell = CoffeeLabelTableViewCell.dequeue(from: tableView, for: indexPath)
            cell.configure(with: self.coffeeDetailViewModel.description)
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            return cell
        case 2:
            let cell = CoffeeLabelTableViewCell.dequeue(from: tableView, for: indexPath)
            cell.configure(with: self.coffeeDetailViewModel.ingredients[indexPath.row])
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            return cell
        case 3:
            let cell = CoffeeLabelTableViewCell.dequeue(from: tableView, for: indexPath)
            cell.configure(with: self.coffeeDetailViewModel.preparation[indexPath.row])
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UItableViewDelegate
extension CoffeeDetailViewController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 2, 3:
            return CoffeeDetailTraits.heightForRowAt
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return CoffeeDetailTraits.heightForCoffeeImageTableViewCell
        case 1, 3:
            return UITableView.automaticDimension
        case 2:
            return max(CoffeeDetailTraits.heightForRowAt, UITableView.automaticDimension)
        default:
            return CoffeeDetailTraits.heightForRowAt
        }
    }
}
