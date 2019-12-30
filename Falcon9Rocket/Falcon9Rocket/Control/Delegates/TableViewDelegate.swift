import UIKit

class TableViewDelegate: NSObject
{
    var tableView: UITableView
    var viewModel: LaunchViewModel
    let rowHeight: CGFloat = 100
    init(viewModel: LaunchViewModel, tableView: UITableView)
    {
        self.viewModel = viewModel
        self.tableView = tableView
        super.init()
        setupTableView()
        tableView.reloadData()
    }

    func reloadTableData()
    {
        tableView.reloadData()
    }

    private func setupTableView()
    {
        tableView.register(LaunchCell.self, forCellReuseIdentifier: LaunchCell.defaultReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = rowHeight
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .white
    }
}

extension TableViewDelegate: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return HeaderView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 50))
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellViewModel = viewModel.cellViewModel(atIndexPath: indexPath)

        let cell = tableView.dequeueReusableCell(withIdentifier: LaunchCell.defaultReuseIdentifier, for: indexPath) as! LaunchCell

        cell.setup(with: cellViewModel)
        return cell
    }
}
