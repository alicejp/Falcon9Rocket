import XCTest
@testable import Falcon9Rocket

class LaunchViewModelTests: XCTestCase {

    var viewModel: LaunchViewModel!

    override func setUp() {
        super.setUp()
        viewModel = LaunchViewModel()
        viewModel.launches = [LaunchModelInfo.build()]
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func test_count()
    {
        XCTAssertEqual(viewModel.count, 1)
    }

    func test_cellViewModel_return_Empty_LaunchCellViewModel()
    {
        let cellViewModel = viewModel.cellViewModel(atIndexPath: IndexPath(row: 1, section: 0))
        XCTAssertNotNil(cellViewModel)
        XCTAssertEqual(cellViewModel.name, "Name")
    }

    func test_cellViewModel_return_LaunchCellViewModel()
    {
        let cellViewModel = viewModel.cellViewModel(atIndexPath: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(cellViewModel)
        XCTAssertEqual(cellViewModel.name, viewModel.launches?.first?.missionName)
    }

    func test_formattedDate()
    {
        let launchDateUtc = viewModel.launches?.first?.launchDateUtc
        let formattedDate = launchDateUtc!.formattedDate()

        XCTAssertNotNil(formattedDate)
        XCTAssertEqual(formattedDate, "Mar 24, 10:30 PM")
    }
}

extension LaunchModelInfo
{
    static func build() -> LaunchModelInfo
    {
        let model = LaunchModelInfo(
            missionName: "FalconSat",
            launchDateUtc: "2006-03-24T22:30:00.000Z",
            links: LaunchModelInfo.LaunchLinks(missionPatchSmall: "https://images2.imgbox.com/3c/0e/T8iJcSN3_o.png"),
            launchSuccess: true
        )

        return model
    }
}
