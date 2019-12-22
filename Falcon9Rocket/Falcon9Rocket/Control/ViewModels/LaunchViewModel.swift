import Foundation

class LaunchViewModel
{
    var launches: [LaunchModelInfo]?

    var count: Int {
        return launches?.count ?? 0
    }

    func cellViewModel(atIndexPath indexPath: IndexPath) -> LaunchCellViewModel
    {
        let launch = launches?[indexPath.row]
        return LaunchCellViewModel(name: launch?.missionName ?? "name", date: launch?.launchDateUtc ?? "date")
    }
}

struct LaunchCellViewModel
{
   let name: String
   let date: String
}
