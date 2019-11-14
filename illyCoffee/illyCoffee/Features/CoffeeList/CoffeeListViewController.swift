import UIKit

final class CoffeeListViewController: UITableViewController {
    let coffeeListViewModel = CoffeeListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "illyCoffee"
        self.setupTableView()
    }
}

// MARK: - Setup functions
extension CoffeeListViewController {
    private func setupTableView() {
        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableView.automaticDimension
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
    }
}
