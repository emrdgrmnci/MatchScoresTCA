import XCTest
@testable import MatchScoresTCA

class MatchScoresTCAAppTests: XCTestCase {
    
    func test_RootView_store_initialization() {
        let store = Store(initialState: RootFeature.State()) {
            RootFeature(
                fetchTeams: {
                    TeamsModel.sample
                },
                fetchPlayers: {
                    PlayersModel.sample
                },
                fetchGames: {
                    GamesModel.sample
                },
                uuid: { UUID() }
            )
        }
        
        let rootView = RootView(store: store)
        
        XCTAssertNotNil(rootView, "RootView should not be nil")
        XCTAssertEqual(rootView.store, store, "RootView store should be initialized with the correct store")
    }
    
    func test_MatchScoresTCAApp_body() {
        let matchScoresTCAApp = MatchScoresTCAApp()
        let scene = matchScoresTCAApp.body
        
        XCTAssertNotNil(scene, "Scene should not be nil")
        XCTAssertTrue(scene is WindowGroup, "Scene should be a WindowGroup")
        
        let windowGroup = scene as! WindowGroup
        let rootView = windowGroup.content as! RootView
        
        XCTAssertNotNil(rootView, "RootView should not be nil")
        XCTAssertTrue(rootView.store is Store<RootFeature.State, RootFeature.Action>, "RootView store should be a Store")
    }
}