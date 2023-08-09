import ComposableArchitecture
import SwiftUI

struct TeamFeature: Reducer {
    struct State: Equatable, Identifiable {
        let id: UUID
        let team: TeamData
    }
    
    enum Action: Equatable { }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> { }
}
