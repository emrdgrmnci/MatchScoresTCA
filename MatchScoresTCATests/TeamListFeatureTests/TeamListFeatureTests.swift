let testTeamUUID = UUID(uuidString: "K3B246EW-9SQD-4506-A57C-8E116DB50774")

import XCTest
import ComposableArchitecture
@testable import MatchScoresTCA

@MainActor
final class TeamListFeatureTests: XCTestCase {
    func testSearchAndClearQuery() async {
        let store = TestStore(
            initialState: TeamListFeature.State()) {
                TeamListFeature()
            }
        await store.send(.searchQueryChanged("P")) {
            $0.dataLoadingStatus = .loading
            $0.isLoading = false
            $0.searchQuery = "P"
        }
        await store.send(.searchQueryChanged("")) {
            $0.isLoading = false
            $0.searchQuery = ""
        }
    }
    
    func testGetTeams() async {
        let store = TestStore(initialState: TeamListFeature.State()) {
            TeamListFeature()
        } withDependencies: {
            $0.matchScoresClient.fetchTeams = { _ in TeamsModel.mockTeamModel
            }
        }
        await store.send(.onAppear) {
            $0.isLoading = true
            $0.dataLoadingStatus = .loading
        }
        await store.receive(.fetchTeamResponse(.success(TeamsModel.mockTeamModel))) {
            $0.dataLoadingStatus = .loading
            $0.isLoading = false
            $0.totalPages = TeamsModel.mockTeamModel.meta.totalCount
            $0.teamsData = TeamsModel.mockTeamModel.data
            $0.teamList += IdentifiedArrayOf(
                uniqueElements: TeamsModel.mockTeamModel.data.sorted(by: >)
            )
        }
    }
}
