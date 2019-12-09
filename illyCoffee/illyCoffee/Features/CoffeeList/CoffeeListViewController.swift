import UIKit

final class CoffeeListViewController: UITableViewController {
    let viewModel: CoffeeCollectionManager
    let searchController = UISearchController(searchResultsController: nil)
    var activityView: UIActivityIndicatorView?

    init(viewModel: CoffeeCollectionManager) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppData.Colors.featuredCoffee
        self.setupNavigationBar()
        self.setupTableView()
        self.setupSearchController()
        self.showActivityIndicator()
        self.viewModel.getCoffeeCollection{ [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.hideActivityIndicator()
            }
        }
    }
}

// MARK: - Setup Methods
extension CoffeeListViewController {
    private func setupNavigationBar() {
        self.title = AppData.title
        self.navigationController?.navigationBar.backgroundColor = AppData.Colors.featuredCoffee
        self.navigationController?.navigationBar.barTintColor = AppData.Colors.featuredCoffee
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.isOpaque = true
    }

    private func setupTableView() {
        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.separatorStyle = .none
        CoffeeTableViewCell.register(with: self.tableView)
    }

    private func setupSearchController() {
        if let textField = self.searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = AppData.Colors.lighterGray
        }
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search"
        self.navigationItem.searchController = self.searchController
        self.definesPresentationContext = true
        self.extendedLayoutIncludesOpaqueBars = true
    }

    private func showActivityIndicator() {
        self.activityView = UIActivityIndicatorView(style: .whiteLarge)
        guard let activityView = self.activityView else { return }
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        activityView.startAnimating()
    }

    private func hideActivityIndicator() {
        self.activityView?.stopAnimating()
        self.activityView = nil
    }
}

// MARK: - UITableViewDataSource
extension CoffeeListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSections(filtered: self.isFiltering)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfCoffees(in: section, filtered: self.isFiltering)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CoffeeTableViewCell.dequeue(from: tableView, for: indexPath)
        cell.configure(with: self.viewModel.getCoffee(for: indexPath, filtered: self.isFiltering))
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel.getCoffeeCategory(for: section, filtered: self.isFiltering)
    }
}

// MARK: - UITableViewDelegate
extension CoffeeListViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let coffee = self.viewModel.getCoffee(for: indexPath, filtered: self.isFiltering)
            else { return }
        let coffeeDetailViewController = CoffeeDetailViewController()
        coffeeDetailViewController.coffeeDetailViewModel = CoffeeDetailViewModel(with: coffee)
        self.navigationController?.pushViewController(coffeeDetailViewController, animated: true)
    }

    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        guard self.viewModel.isEditable,
            editingStyle == .delete
            else { return }
        self.viewModel.deleteFavorite(in: indexPath.section, for: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .fade)
    }
}

// MARK: - UISearchResultsUpdating
extension CoffeeListViewController: UISearchResultsUpdating {
    var isSearchBarEmpty: Bool {
        return self.searchController.searchBar.text?.isEmpty ?? true
    }

    var isFiltering: Bool {
        return self.searchController.isActive && !self.isSearchBarEmpty
    }

    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        self.viewModel.filterContentForSearchText(searchBar.text!) {
            [weak self] in DispatchQueue.main.async { self?.tableView.reloadData() }
        }
    }
}
