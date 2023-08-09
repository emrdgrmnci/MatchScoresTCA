# MatchScoresTCA

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fpointfreeco%2Fswift-composable-architecture%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/pointfreeco/swift-composable-architecture)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fpointfreeco%2Fswift-composable-architecture%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/pointfreeco/swift-composable-architecture)

The Composable Architecture (TCA, for short) is a library for building applications in a consistent 
and understandable way, with composition, testing, and ergonomics in mind. It can be used in 
SwiftUI, UIKit, and more, and on any Apple platform (iOS, macOS, tvOS, and watchOS).

* [What is the Composable Architecture?](#what-is-the-composable-architecture)
* [TCA Data-flow Diagram](#tca-data-flow-diagram)
* [Basic usage](#basic-usage)

### Source 

⚠️ For the all first-hand info:

Please visit: https://github.com/pointfreeco/swift-composable-architecture

## What is the Composable Architecture?

This library provides a few core tools that can be used to build applications of varying purpose and 
complexity. It provides compelling stories that you can follow to solve many problems you encounter 
day-to-day when building applications, such as:

* **State management**
  <br> How to manage the state of your application using simple value types, and share state across 
  many screens so that mutations in one screen can be immediately observed in another screen.

* **Composition**
  <br> How to break down large features into smaller components that can be extracted to their own, 
  isolated modules and be easily glued back together to form the feature.

* **Side effects**
  <br> How to let certain parts of the application talk to the outside world in the most testable 
  and understandable way possible.

* **Testing**
  <br> How to not only test a feature built in the architecture, but also write integration tests 
  for features that have been composed of many parts, and write end-to-end tests to understand how 
  side effects influence your application. This allows you to make strong guarantees that your 
  business logic is running in the way you expect.

* **Ergonomics**
  <br> How to accomplish all of the above in a simple API with as few concepts and moving parts as 
  possible.

## TCA Data-flow Diagram

![Alt text](https://github.com/emrdgrmnci/MatchScoresTCA/blob/main/MatchScoresTCA/Resources/TCA-Diagram.png "TCA Data Flow Diagram")


## Basic Usage

To build a feature using the Composable Architecture you define some types and values that model 
your domain:

* **State**: A type that describes the data your feature needs to perform its logic and render its 
UI.
* **Action**: A type that represents all of the actions that can happen in your feature, such as 
user actions, notifications, event sources and more.
* **Reducer**: A function that describes how to evolve the current state of the app to the next 
state given an action. The reducer is also responsible for returning any effects that should be 
run, such as API requests, which can be done by returning an `Effect` value.
* **Store**: The runtime that actually drives your feature. You send all user actions to the store 
so that the store can run the reducer and effects, and you can observe state changes in the store 
so that you can update UI.

The benefits of doing this are that you will instantly unlock testability of your feature, and you 
will be able to break large, complex features into smaller domains that can be glued together.

As a basic example, consider a UI that shows a number along with "+" and "−" buttons that increment 
and decrement the number. To make things interesting, suppose there is also a button that when 
tapped makes an API request to fetch a random fact about that number and then displays the fact in 
an alert.

To implement this feature we create a new type that will house the domain and behavior of the 
feature by conforming to `Reducer`:

As a basic example, consider a UI that shows a 2-columns grid list along with "#" team/player ids, names and, team logos. When the views appear, there is an API request to fetch NBA teams and players and then displays in a 2-columns grid list.

🧑🏼‍🦳👨🏼‍🦳 To implement this root (grand-parent) feature we create a new type that will house the root domain and behavior of the feature by conforming to Reducer:

```
import ComposableArchitecture

struct RootFeature: Reducer {
}
```
In here we need to define a type for the root feature's state, which consists of a selected tab, as well as parent feature states that are `TeamListFeature.State()` and `PlayerListFeature.State()`:

```
struct RootFeature: Reducer {
    struct State: Equatable {
        var selectedTab = Tab.teams
        var teamListState = TeamListFeature.State()
        var playerListState = PlayerListFeature.State()
    }
}
```
We need to define a type for the feature's tabs. There are the obvious tabbar items, such as teams, favorites and players.

```
struct RootFeature: Reducer {
    struct State: Equatable {
        var selectedTab = Tab.teams
        var teamListState = TeamListFeature.State()
        var playerListState = PlayerListFeature.State()
    }
    enum Tab {
        case teams
        case favorites
        case players
    }
}
```
We also need to define a type for the root (grand-parent) feature's actions. There are the obvious actions, such as tabbar item selected, and the actions that are encapsulate all actions from the child domain/feature of the root (grand-parent) domain/feature, providing a comprehensive and cohesive approach.

```
struct RootFeature: Reducer {
    struct State: Equatable {
        var selectedTab = Tab.teams
        var teamListState = TeamListFeature.State()
        var playerListState = PlayerListFeature.State()
    }
    enum Tab {
        case teams
        case favorites
        case players
    }
    enum Action: Equatable {
        case tabSelected(Tab)
        case teamList(TeamListFeature.Action)
        case playerList(PlayerListFeature.Action)
    }
}
```
And then we implement the reduce method which is responsible for handling the actual logic and behavior for the feature. It describes how to change the current state to the next state, and describes what effects need to be executed. Some actions don't need to execute effects, and they can return .none to represent that:

```
struct RootFeature: Reducer {
    struct State: Equatable {
        var selectedTab = Tab.teams
        var teamListState = TeamListFeature.State()
        var playerListState = PlayerListFeature.State()
    }
    
    enum Tab {
        case teams
        case favorites
        case players
    }
    
    enum Action: Equatable {
        case tabSelected(Tab)
        case teamList(TeamListFeature.Action)
        case playerList(PlayerListFeature.Action)
    }
    
    // Dependencies
    var fetchTeams: () async throws -> TeamsModel
    var fetchPlayers:  @Sendable () async throws -> PlayersModel
    var uuid: @Sendable () -> UUID
    
    static let live = Self(
        fetchTeams: MatchScoresClient.liveValue.fetchTeams,
        fetchPlayers: MatchScoresClient.liveValue.fetchPlayers,
        uuid: { UUID() }
    )
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .teamList:
                return .none
            case .playerList:
                return .none
            case .tabSelected(let tab):
                state.selectedTab = tab
                return .none
            }
        }
        Scope(state: \.teamListState, action: /RootFeature.Action.teamList) {
            TeamListFeature(uuid: uuid)
        }
        Scope(state:  \.playerListState, action: /RootFeature.Action.playerList) {
            PlayerListFeature(uuid: uuid)
        }
    }
}
```
And then finally we define the view that displays the feature. It holds onto a `StoreOf<RootFeature>` so that it can observe all changes to the state and re-render, and we can send all user actions to the store so that state changes. `WithViewStore` is a view helper that transforms a `Store` into a `ViewStore` so that its state can be observed by a view builder:

```
struct RootView: View {
    let store: StoreOf<RootFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            TabView(
                selection: viewStore.binding(
                    get: \.selectedTab,
                    send: RootFeature.Action.tabSelected
                )
            ) {
                TeamListView(
                    store: self.store.scope(
                        state: \.teamListState,
                        action: RootFeature.Action
                            .teamList
                    )
                )
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Teams")
                }
                .tag(RootFeature.Tab.teams)
                
                PlayerListView(
                    store: self.store.scope(
                        state: \.playerListState,
                        action: RootFeature.Action.playerList
                    )
                )
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Players")
                }
                .tag(RootFeature.Tab.players)
            }
            .accentColor(Color("launch-screen-background"))
        }
    }
}
```
Once we are ready to display these views, for example in the app's entry point, we can construct a store. This can be done by specifying the initial state to start the application in, as well as the reducer that will power the application:

```
import SwiftUI
import ComposableArchitecture

@main
struct MatchScoresTCAApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(
                store: Store(initialState: RootDomain.State()) {
                    RootDomain(fetchTeams: { TeamsModel.sample}, fetchPlayers: { PlayersModel.sample }, uuid: { UUID() }
                    )
                }
            )
        }
    }
}
```

👱🏻‍♂️👱🏼To implement this parent feature we create a new type that will house the domain and behavior of the feature by conforming to Reducer:

```
import ComposableArchitecture

struct TeamListFeature: Reducer {
}
```
In here we need to define a type for the feature's state, which consists of a data loading status, as well as an TeamsModel that is an Identified collection which are designed to solve all of the collection problems by providing data structures for working with collections (teams and meta) of identifiable elements in an ergonomic, performant way:

```
struct TeamListFeature: Reducer {
    struct State: Equatable {
        var dataLoadingStatus = DataLoadingStatus.notStarted
        var resultTeamRequestInFlight: TeamsModel?
        var teamList: IdentifiedArrayOf<TeamFeature.State> = []
        
        var shouldShowError: Bool {
            dataLoadingStatus == .error
        }
        
        var isLoading: Bool {
            dataLoadingStatus == .loading
        }   
    }
}
```
We also need to define a type for the feature's actions. There are the obvious action, such as view on appear and the action that occurs when we receive a response from the team/player API request, and define a `team(id: TeamFeature.State.ID, action: TeamFeature.Action)` case to handle actions sent to the child domain `(TeamFeature: Reducer)`:

```
struct TeamListFeature: Reducer {
    struct State: Equatable {
        var dataLoadingStatus = DataLoadingStatus.notStarted
        var teamList: IdentifiedArrayOf<TeamFeature.State> = []
        var shouldShowError: Bool {
            dataLoadingStatus == .error
        }
        var isLoading: Bool {
            dataLoadingStatus == .loading
        }   
    }
    enum Action: Equatable {
        case fetchTeamResponse(TaskResult<TeamsModel>)
        case team(id: TeamFeature.State.ID, action: TeamFeature.Action)
        case onAppear
    }
}
```
And then we implement the reduce method which is responsible for handling the actual logic and behavior for the feature. It describes how to change the current state to the next state, and describes what effects need to be executed. Some actions don't need to execute effects, and they can return .none to represent that:

```
struct TeamListFeature: Reducer {
  struct State: Equatable { /* ... */ }
  enum Action: Equatable { /* ... */ }

func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .fetchTeamResponse(.failure(let error)):
            state.dataLoadingStatus = .error
            print(error)
            print("Error getting products, try again later.")
            return .none
            
        case let .fetchTeamResponse(.success(teamData)):
            state.teamList = IdentifiedArrayOf(
                uniqueElements: teamData.data.map {
                    TeamFeature.State(
                        id: uuid(),
                        team: $0
                    )
                }
            )
            state.dataLoadingStatus = .loading
            return .none
            
        case .onAppear:
            return .run { send in
                await send (
                    .fetchTeamResponse(
                        TaskResult { try await MatchScoresClient.liveValue.fetchTeams()
                        }
                    )
                )
            }
        case .team:
            return .none
        }
    }
}
```
And then finally we define the view that displays the feature. It holds onto a `StoreOf<TeamListFeature>` so that it can observe all changes to the state and re-render, and we can send all user actions to the store so that state changes. `ForEachStore` loops over a store’s collection with a store scoped to the domain of each element. This allows us to extract and modularize an element’s view and avoid concerns around collection index math and parent-child store communication:

```
struct TeamListView: View {
    let store: StoreOf<TeamListFeature>
    
    private let columns = Array(
        repeating: GridItem( .flexible()),
        count: 2
    )
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack{
                ScrollView {
                    LazyVGrid(columns: columns,
                              spacing: 16) {
                        ForEachStore(
                            self.store.scope(
                                state: \.teamList,
                                action: TeamListFeature.Action.team(id:action:)
                            )
                        ) {
                            TeamView(store: $0)
                        }
                    }
                              .padding()
                              .accessibilityIdentifier("peopleGrid")
                }
                .refreshable {
                    viewStore.send(.onAppear)
                }
            }
            .navigationTitle("Teams")
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}
```

👶🏼👶🏼 To implement this child (grand-child of `RootFeature` or child of `TeamListFeature`) feature we create a new type that will house the domain and behavior of the child feature by conforming to Reducer:

```
struct TeamFeature: Reducer {
    struct State: Equatable, Identifiable {
        let id: UUID
        let team: TeamData
    }
    enum Action: Equatable {
        case onAppear
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .onAppear:
            return .none
        }
    }
}
```
And then we define the view that displays the feature. It holds onto a `StoreOf<TeamFeature>` so that it can observe all changes to the state and re-render, and we can send all user actions to the store so that state changes. `WithViewStore` is a view helper that transforms a `Store` into a `ViewStore` so that its state can be observed by a view builder:
```
import SwiftUI
import ComposableArchitecture

struct TeamView: View {
    let store: StoreOf<TeamFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: {$0} ) { viewStore in
            VStack(spacing: .zero) {
                
                background
                
                VStack(alignment: .leading) {
                    Text(viewStore.team.fullName)
                        .foregroundColor(Theme.text)
                        .font(
                            .system(.largeTitle, design: .rounded)
                        )
                        .background(
                            Image(avatars[viewStore.team.id - 1])
                                .opacity(0.4)
                                .aspectRatio(contentMode: .fill)
                        )
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 150.0)
                .padding(.horizontal, 8)
                .padding(.vertical, 5)
                .background(Theme.detailBackground)
                
                VStack {
                    PillView(id: viewStore.team.id)
                        .padding(.leading, 10)
                        .padding(.top, 10)
                }
                
            }
            .clipShape(
                RoundedRectangle(cornerRadius: 16,
                                 style: .continuous)
            )
            .shadow(color: Theme.text.opacity(0.1),
                    radius: 2,
                    x: 0,
                    y: 1)
            .edgesIgnoringSafeArea([.top, .leading, .trailing])
        }
    }
}
```
