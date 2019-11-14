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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.coffeeListViewModel.numberOfCoffees
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CoffeeTableViewCell.dequeue(from: tableView, for: indexPath)
        cell.configure(with: self.coffeeListViewModel.coffeeList[indexPath.row])
        cell.backgroundColor = .white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CoffeeListViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
        let coffee = self.coffeeListViewModel.coffeeList[indexPath.row]
        let coffeeDetailViewController = CoffeeDetailViewController()
        coffeeDetailViewController.coffeeDetailViewModel = CoffeeDetailViewModel(with: coffee)
        self.navigationController?.pushViewController(coffeeDetailViewController, animated: true)
    }
}
