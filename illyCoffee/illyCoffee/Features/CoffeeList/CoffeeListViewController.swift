import UIKit

final class CoffeeListViewController: UITableViewController {
    let coffeeListViewModel = CoffeeListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemRed
        self.title = "illyCoffee"
        self.setupNavigationBar()
        self.setupTableView()
    }
}

// MARK: - Setup functions
extension CoffeeListViewController {
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.isOpaque = true
    }

    private func setupTableView() {
        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.separatorStyle = .none
        CoffeeTableViewCell.register(with: self.tableView)
    }
}

// MARK: - UITableViewDataSource
extension CoffeeListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.coffeeListViewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.coffeeListViewModel.numberOfCoffees(in: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CoffeeTableViewCell.dequeue(from: tableView, for: indexPath)
        cell.configure(with: self.coffeeListViewModel.getCoffee(for: indexPath))
        cell.backgroundColor = .white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.coffeeListViewModel.getCoffeeCategory(for: section)
    }
}

// MARK: - UITableViewDelegate
extension CoffeeListViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let coffee = self.coffeeListViewModel.getCoffee(for: indexPath) else { return }
        let coffeeDetailViewController = CoffeeDetailViewController()
        coffeeDetailViewController.coffeeDetailViewModel = CoffeeDetailViewModel(with: coffee)
        self.navigationController?.pushViewController(coffeeDetailViewController, animated: true)
    }
}
