import UIKit

class ViewController: UIViewController {

    private var tableViewDelegate: TableViewDelegate!
    private var tableView: UITableView!
    private var service: LaunchesService!
    private var viewModel = LaunchViewModel()

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

        tableViewDelegate = TableViewDelegate(viewModel: viewModel, tableView: tableView)
        view.addSubview(tableView)

        getLaunches()
    }

    func getLaunches()
    {
        service.getLaunches {
            [weak self] result in
            switch result
            {
            case .failure(let error):
                print(error)
            case .success(let launches):
                self?.viewModel.launches = launches

                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
}


