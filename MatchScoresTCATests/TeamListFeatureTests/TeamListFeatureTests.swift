import XCTest
import ComposableArchitecture
@testable import MatchScoresTCA

let testTeamUUID = UUID(uuidString: "K3B246EW-9SQD-4506-A57C-8E116DB50774")

@MainActor
final class TeamListFeatureTests: XCTestCase {
    
    func testSearchAndClearQuery() async {
        let store = TestStore(
            initialState: TeamListFeature.State()) {
                TeamListFeature()
            }
        
        await store.send(.searchQueryChanged("P")) {
            $0.searchQuery = "P"
        }
        
        await store.send(.searchQueryChanged("")) {
            $0.searchQuery = ""
        }
    }
}
