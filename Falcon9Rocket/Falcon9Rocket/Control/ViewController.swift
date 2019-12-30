import UIKit

class ViewController: UIViewController {

    private var tableViewDelegate: TableViewDelegate!
    private var tableView: UITableView!
    private var service: LaunchesService!
    private var viewModel = LaunchViewModel()

    private let refreshControl = UIRefreshControl()

    init(service: LaunchesService)
    {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: self.view.frame)

        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl

        tableViewDelegate = TableViewDelegate(viewModel: viewModel, tableView: tableView)
        view.addSubview(tableView)

        getLaunches()
    }

    @objc
    private func pullToRefresh()
    {
        getLaunches()
    }

    private func getLaunches()
    {
        service.getLaunches {
            [weak self] result in
            switch result
            {
            case .failure:
                self?.viewModel.launches = nil
            case .success(let launches):
                self?.viewModel.launches = launches
            }

            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
                self?.tableViewDelegate.reloadTableData()
            }
        }
    }
}


