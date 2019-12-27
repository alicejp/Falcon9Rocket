import Foundation

class LaunchViewModel
{
    var launches: [LaunchModelInfo]?

    var count: Int {
        return launches?.count ?? 0
    }

    func cellViewModel(atIndexPath indexPath: IndexPath) -> LaunchCellViewModel
    {
        guard
            count > indexPath.row,
            let launch = launches?[indexPath.row]
        else {
            return LaunchCellViewModel(name: "Name", date: "Date", missionPatchSmallImageLink: "", launchSuccess: false)
        }

        return LaunchCellViewModel(name: launch.missionName,
                                   date: launch.launchDateUtc.formattedDate() ?? "Date",
                                   missionPatchSmallImageLink: launch.links.missionPatchSmall ?? "",
                                   launchSuccess: launch.launchSuccess ?? false
        )
    }
}

extension String
{
    func formattedDate() -> String?
    {
        let formatterFrom = DateFormatter()
        formatterFrom.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        let formatterTo = DateFormatter()
        formatterTo.dateFormat = "MMM d, h:mm a"

        if let date = formatterFrom.date(from: self) {
            return formatterTo.string(from: date)
        }
        return nil
    }
}
