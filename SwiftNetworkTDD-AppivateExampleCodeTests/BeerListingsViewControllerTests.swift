//
//  SwiftNetworkTDD_AppivateExampleCodeTests.swift
//  SwiftNetworkTDD-AppivateExampleCodeTests
//
//  Created by Gary Maccabe on 14/12/2021.
//

import XCTest
@testable import SwiftNetworkTDD_AppivateExampleCode

class BeerListingsViewControllerTests : XCTestCase {
    
    var sut : BeerListingViewController!
    var partialMock: PartialMockListingsViewController {
      return sut as! PartialMockListingsViewController
    }

    override func setUpWithError() throws {
        super.setUp()
        sut = BeerListingViewController.instanceFromStoryboard()
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
      sut = nil
      super.tearDown()
    }
    
    // MARK: - Given
    func givenPartialMock() {
      sut = PartialMockListingsViewController()
      sut.loadViewIfNeeded()
    }
    
    func givenViewModels(count: Int = 3) {
      guard count > 0 else {
        sut.beerViewModels = []
        return
      }
      sut.beerViewModels = givenDogs(count: count).map { BeerViewModel(beer: $0) }
    }
    
    func givenMockViewModels(count: Int = 3) {
      guard count > 0 else {
        sut.beerViewModels = []
        return
      }
      sut.beerViewModels = givenDogs(count: count).map { MockBeerViewModel(beer: $0) }
    }
    
    func givenDogs(count: Int = 3) -> [Beer] {
      return (1 ... count).map { i in
        let beer = Beer(
          id: "id_\(i)",
          sellerID: "sellderID_\(i)",
          imageURL: URL(string: "http://example.com/\(i)")!,
          name: "name_\(i)")
        return beer
      }
    }
    
    // MARK: - When
    func whenDequeueTableViewCells() -> [UITableViewCell] {
      return (0 ..< sut.beerViewModels.count).map { i in
        let indexPath = IndexPath(row: i, section: 0)
        return sut.tableView(sut.tableView, cellForRowAt: indexPath)
      }
    }
    
    // MARK: - Outlets - Tests
    func test_tableView_onSet_registersErrorTableViewCell() {
      // when
      let cell = sut.tableView.dequeueReusableCell(
        withIdentifier: ErrorTableViewCell.identifier)
      
      // then
      XCTAssertTrue(cell is ErrorTableViewCell)
    }
    
    // MARK: - Instance Properties - Tests
    func test_viewModels_setToEmptyArray() {
      XCTAssertEqual(sut.beerViewModels.count, 0)
    }
    
    // MARK: - View Life Cycle - Tests
    func test_viewDidLoad_setsRefreshControlAttributedTitle() throws {
      // when
      sut.viewDidLoad()
      
      // then
      let refreshControl = try XCTUnwrap(sut.tableView.refreshControl)
      XCTAssertEqual(refreshControl.attributedTitle, NSAttributedString(string: "Loading..."))
    }
    
    func test_viewDidLoad_setsRefreshControlTarget() throws {
      // when
      sut.viewDidLoad()
      
      // then
      let refreshControl = try XCTUnwrap(sut.tableView.refreshControl)
      
      XCTAssertEqual(refreshControl.allTargets.count, 1)
      let target = try XCTUnwrap(refreshControl.allTargets.first as? BeerListingViewController)
      XCTAssertTrue(sut === target)
    }
    
    func test_viewDidLoad_setsRefreshControlAction() throws {
      // when
      sut.viewDidLoad()
      
      // then
      let refreshControl = try XCTUnwrap(sut.tableView.refreshControl)
      let target = try XCTUnwrap(refreshControl.allTargets.first as? BeerListingViewController)
      let actions = refreshControl.actions(forTarget: target, forControlEvent: .valueChanged)
      let selector = try XCTUnwrap(actions?.first)
      XCTAssertEqual(actions?.count, 1)
      XCTAssertEqual(Selector(selector), #selector(BeerListingViewController.refreshData))
    }
    
    func test_viewWillAppear_calls_refreshData() {
      // given
      givenPartialMock()
      let expectation = self.expectation(description: "Expected refreshData to be called")
      partialMock.onRefreshData = {
        expectation.fulfill()
      }
      
      // when
      sut.viewWillAppear(true)
      
      // then
      waitForExpectations(timeout: 0.0)
    }
    
    // MARK: - UITableViewDataSource Tests
    func test_tableView_numberOfRowsInSection_givenIsRefreshing_returns0() {
      // given
      let expected = 0
      sut.tableView.refreshControl!.beginRefreshing()
      
      // when
      let actual = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
      
      // then
      XCTAssertEqual(actual, expected)
    }

    func test_tableView_numberOfRowsInSection_givenHasViewModels_returnsViewModelsCount() {
      // given
      let expected = 3
      givenViewModels(count: expected)
      
      // when
      let actual = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
      
      // then
      XCTAssertEqual(actual, expected)
    }

    func test_tableView_numberOfRowsInSection_givenNoViewModels_returns1() {
      // given
      let expected = 1
      
      // when
      let actual = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
      
      // then
      XCTAssertEqual(actual, expected)
    }
    
    func test_tableViewCellForRowAt_givenNoViewModelsSet_returns_ErrorTableViewCell() {
      // given
      givenViewModels(count: 0)
      
      // when
      let indexPath = IndexPath(row: 0, section: 0)
      let cell = sut.tableView(sut.tableView, cellForRowAt: indexPath)
      
      // then
      XCTAssertTrue(cell is ErrorTableViewCell)
    }
    
    func test_tableViewCellForRowAt_givenViewModelsSet_returnsListingTableViewCells() {
      // given
      givenViewModels()
      
      // when
      let cells = whenDequeueTableViewCells()
      
      // then
      for cell in cells {
        XCTAssertTrue(cell is BeerListingTableViewCell)
      }
    }
    
    func test_tableViewCellForRowAt_givenViewModelsSet_configuresTableViewCells() throws {
      // given
      givenMockViewModels()
      
      // when
      let cells = try XCTUnwrap(whenDequeueTableViewCells() as? [BeerListingTableViewCell])
      
      // then
      for i in 0 ..< sut.beerViewModels.count {
        let cell = cells[i]
        let viewModel = sut.beerViewModels[i] as! MockBeerViewModel
        XCTAssertTrue(viewModel.configuredCell === cell) // pointer equality
      }
    }
  }

  // MARK: - Mocks
extension BeerListingsViewControllerTests {
    
    class MockBeerViewModel: BeerViewModel {
      var configuredCell: BeerListingTableViewCell?
      override func configure(_ cell: BeerListingTableViewCell) {
        self.configuredCell = cell
      }
    }

    class PartialMockListingsViewController: BeerListingViewController {
      
      override func loadView() {
        super.loadView()
        tableView = UITableView()
      }
      
      var onRefreshData: (()->Void)? = nil
      override func refreshData() {
        guard let onRefreshData = onRefreshData else {
          super.refreshData()
          return
        }
        onRefreshData()
      }
    }
}
