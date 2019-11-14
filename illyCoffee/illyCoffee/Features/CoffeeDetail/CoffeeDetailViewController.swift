import UIKit

final class CoffeeDetailViewController: UITableViewController {
    var coffeeDetailViewModel: CoffeeDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = coffeeDetailViewModel.coffee.name
        self.setupTableView()
    }
}

// MARK: - Setup Functions
extension CoffeeDetailViewController {
    private func setNavigationBar() {
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
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return self.coffeeDetailViewModel.numberOfIngredients
        case 2:
            return self.coffeeDetailViewModel.numberOfPreparations
        default:
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "Ingredients"
        case 2:
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
            return cell
        case 1:
            let cell = CoffeeLabelTableViewCell.dequeue(from: tableView, for: indexPath)
            cell.configure(with: self.coffeeDetailViewModel.coffee.ingredients[indexPath.row])
            return cell
        case 2:
            let cell = CoffeeLabelTableViewCell.dequeue(from: tableView, for: indexPath)
            cell.configure(with: self.coffeeDetailViewModel.coffee.preparation[indexPath.row])
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
        case 1, 2:
            return 44
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0, 2:
            return UITableView.automaticDimension
        default:
            return 44
        }
    }
}
