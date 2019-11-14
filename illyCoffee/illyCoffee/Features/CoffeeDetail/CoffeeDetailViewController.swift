import UIKit

final class CoffeeDetailViewController: UITableViewController {
    var coffeeDetailViewModel: CoffeeDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = coffeeDetailViewModel.coffee.name
        self.setupNavigationBar()
        self.setupTableView()
    }
}

// MARK: - Setup Functions
extension CoffeeDetailViewController {
    private func setupNavigationBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back",
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(done))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                                 target: self,
                                                                 action: #selector(saveCoffeeToFavorites))
    }

    private func setupTableView() {
        self.tableView.estimatedRowHeight = 44
        self.tableView.allowsSelection = false
        CoffeeImageTableViewCell.register(with: self.tableView)
        CoffeeLabelTableViewCell.register(with: self.tableView)
    }

    @objc func saveCoffeeToFavorites() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func done() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDataSource
extension CoffeeDetailViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
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
            return "Ingredients"
        case 3:
            return "Preparation"
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
            cell.configure(with: self.coffeeDetailViewModel.coffee.description)
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            return cell
        case 2:
            let cell = CoffeeLabelTableViewCell.dequeue(from: tableView, for: indexPath)
            cell.configure(with: self.coffeeDetailViewModel.coffee.ingredients[indexPath.row])
            return cell
        case 3:
            let cell = CoffeeLabelTableViewCell.dequeue(from: tableView, for: indexPath)
            cell.configure(with: self.coffeeDetailViewModel.coffee.preparation[indexPath.row])
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
            return 44
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0, 1, 3:
            return UITableView.automaticDimension
        case 2:
            return max(44, UITableView.automaticDimension)
        default:
            return 44
        }
    }
}
