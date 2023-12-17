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
            $0.searchQuery = "P"
        }
        
        await store.send(.searchQueryChanged("")) {
            $0.searchQuery = ""
        }
    }
    
    func testGetTeams() async {
        let store = TestStore(initialState: TeamListFeature.State()) {
            TeamListFeature()
        } withDependencies: {
            $0.matchScoresClient.fetchTeams = { _ in TeamsModel.sample }
        }

        // Simulate the onAppear action and set state to loading
        await store.send(.onAppear) {
            $0.dataLoadingStatus = .loading
        }

        await store.receive(.fetchTeamResponse(.success(TeamsModel.sample))) {
//            $0.dataLoadingStatus = .success
            $0.totalPages = TeamsModel.sample.meta.totalCount
            $0.teamsData = TeamsModel.sample.data
            $0.teamList = IdentifiedArrayOf(uniqueElements: TeamsModel.sample.data)
            // Update other relevant parts of the state as necessary
        }

    }
}
/*
 This is the problem with use dependencies that talk to the outside world that we cannot control. We simply cannot write a test for this feature because there is no way to predict what the numbers API is going to send back to us.
 
 And really we don’t care about testing the teams API works as expected. That’s an external service that we do not control. For the purpose of this test it would be fine to assume that the teams API works perfectly and sends us back some specific data so that we can then see how that data feeds into the system and affects our feature’s state.
 
 func testGetTeams() async {
 let store = TestStore(initialState: TeamListFeature.State(), reducer: TeamListFeature()) {
 $0.matchScoresClient.fetchTeams = { _ in
 return TaskResult { TeamsModel.sample }
 }
 }
 }
 */
