import Foundation

struct LaunchModelInfo: Decodable
{
    struct LaunchLinks: Decodable
    {
        let missionPatchSmall: String?
    }

    let missionName: String
    let launchDateUtc: String
    let links: LaunchLinks
    let launchSuccess: Bool?
}
