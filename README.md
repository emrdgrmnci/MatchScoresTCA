# MatchScoresTCA

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fpointfreeco%2Fswift-composable-architecture%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/pointfreeco/swift-composable-architecture)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fpointfreeco%2Fswift-composable-architecture%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/pointfreeco/swift-composable-architecture)

The Composable Architecture (TCA, for short) is a library for building applications in a consistent 
and understandable way, with composition, testing, and ergonomics in mind. It can be used in 
SwiftUI, UIKit, and more, and on any Apple platform (iOS, macOS, tvOS, and watchOS).

* [Mockup](#mockup)
* [Recording](#recording)
* [Source](#source)
* [What is the Composable Architecture?](#what-is-the-composable-architecture)
* [TCA Data-flow Diagram](#tca-data-flow-diagram)
* [Basic usage](#basic-usage)

### Mockup

![Alt text](https://github.com/emrdgrmnci/MatchScoresTCA/blob/main/MatchScoresTCA/Resources/MSTCA-Screens.png "MatchScoresTCA Mockup")

### Recording
</br>
</br>
<p align="center">
<img src="https://github.com/emrdgrmnci/MatchScoresTCA/blob/main/MatchScoresTCA/Resources/LM.gif" width="400px" alt="Image 1">
<img src="https://github.com/emrdgrmnci/MatchScoresTCA/blob/main/MatchScoresTCA/Resources/DM.gif" width="400px" alt="Image 2">
</p>
</br>
</br>

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

As a basic example, consider a UI that shows a 2-columns grid list along with "#" team/player ids, names and, team logos. When the views appear, there is an API request to fetch NBA teams and players and then displays in a 2-columns grid list.

🧑🏼‍🦳👨🏼‍🦳 To implement this root (grand-parent) feature we create a new type that will house the root domain and behavior of the feature by conforming to Reducer:

```swift
import ComposableArchitecture

struct RootFeature: Reducer {}
```
In here we need to define a type for the root feature's state, which consists of a selected tab, as well as parent feature states that are `TeamListFeature.State()` and `PlayerListFeature.State()`:

```swift
struct RootFeature: Reducer {
    struct State: Equatable {
        var selectedTab = Tab.teams
        var teamListState = TeamListFeature.State()
        var playerListState = PlayerListFeature.State()
    }
}
```
We need to define a type for the feature's tabs. There are the obvious tabbar items, such as teams, favorites and players.

```swift
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

```swift
struct RootFeature: Reducer {
    struct State: Equatable {
        var selectedTab = Tab.teams
        var teamListState = TeamListFeature.State()
        var gameListState = GameListFeature.State()
        var playerListState = PlayerListFeature.State()
    }
    enum Tab {
        case stats
        case teams
        case games
        case players
        case favorites
    }
    
    enum Action: Equatable {
        case tabSelected(Tab)
        case teamList(TeamListFeature.Action)
        case gameList(GameListFeature.Action)
        case playerList(PlayerListFeature.Action)
    }
}
```
And then we implement the reduce method which is responsible for handling the actual logic and behavior for the feature. It describes how to change the current state to the next state, and describes what effects need to be executed. Some actions don't need to execute effects, and they can return .none to represent that:

```swift
struct RootFeature: Reducer {
    struct State: Equatable {
        var selectedTab = Tab.teams
        var teamListState = TeamListFeature.State()
        var gameListState = GameListFeature.State()
        var playerListState = PlayerListFeature.State()
    }
    
    enum Tab {
        case stats
        case teams
        case games
        case players
        case favorites
    }
    
    enum Action: Equatable {
        case tabSelected(Tab)
        case teamList(TeamListFeature.Action)
        case gameList(GameListFeature.Action)
        case playerList(PlayerListFeature.Action)
    }
    
    var fetchTeams: (Int) async throws -> TeamsModel
    var fetchGames: () async throws -> GamesModel
    var fetchPlayers: (Int) async throws -> PlayersModel
    var uuid: @Sendable () -> UUID
    
    static let live = Self(
        fetchTeams: MatchScoresClient.liveValue.fetchTeams,
        fetchGames: MatchScoresClient.liveValue.fetchGames,
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
            case .gameList:
                return .none
            case .tabSelected(let tab):
                state.selectedTab = tab
                return .none
            }
        }
        Scope(state: \.teamListState, action: /RootFeature.Action.teamList) {
            TeamListFeature()
        }
        Scope(state: \.gameListState, action: /RootFeature.Action.gameList) {
            GameListFeature()
        }
        Scope(state: \.playerListState, action: /RootFeature.Action.playerList) {
            PlayerListFeature()
        }
    }
}
```
And then finally we define the view that displays the feature. It holds onto a `StoreOf<RootFeature>` so that it can observe all changes to the state and re-render, and we can send all user actions to the store so that state changes. `WithViewStore` is a view helper that transforms a `Store` into a `ViewStore` so that its state can be observed by a view builder:

```swift
struct RootView: View {
    
    let store: Store<RootFeature.State, RootFeature.Action>
    
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
                    Image(systemName: "tshirt.fill")
                    Text("Teams")
                }
                .tag(RootFeature.Tab.teams)
                
                GameListView(
                    store: self.store.scope(
                    state: \.gameListState,
                    action: RootFeature.Action.gameList
                )
                )
                .tabItem {
                    Image(systemName: "sportscourt.fill")
                    Text("Games")
                }
                .tag(RootFeature.Tab.games)
                
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
            .background(Color.blue._400)
        }
    }
}
```
Once we are ready to display these views, for example in the app's entry point, we can construct a store. This can be done by specifying the initial state to start the application in, as well as the reducer that will power the application:

```swift
import SwiftUI
import ComposableArchitecture

@main
struct MatchScoresTCAApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            RootView(
                store: Store(initialState: RootFeature.State()) {
                    RootFeature(
                        fetchTeams: { _ in
                            TeamsModel.sample
                        },
                        fetchGames: {
                            GamesModel.sample
                        },
                        fetchPlayers: { _ in 
                            PlayersModel.sample
                        },
                        uuid: { UUID() }
                    )
                    ._printChanges()
                }
            )
        }
    }
}
```

👱🏻‍♂️👱🏼To implement this parent feature we create a new type that will house the domain and behavior of the feature by conforming to Reducer:

```swift
import ComposableArchitecture

struct TeamListFeature: Reducer {}
```
In here we need to define a type for the feature's state, which consists of a data loading status, as well as an TeamsModel that is an Identified collection which are designed to solve all of the collection problems by providing data structures for working with collections (teams and meta) of identifiable elements in an ergonomic, performant way:

```swift
struct TeamListFeature: Reducer {
    struct State: Equatable { 
        var dataLoadingStatus = DataLoadingStatus.notStarted 
        var teamList: IdentifiedArrayOf<TeamData> = []
        var searchQuery = "" 
        var page = 1 
        var totalPages: Int?
        var teamsData: [TeamData] = []
        
        var shouldShowError: Bool {
            dataLoadingStatus == .error
        }
        
        var isLoading: Bool {
            dataLoadingStatus == .loading
        }
        
        var searchResults: IdentifiedArrayOf<TeamData> {
            guard !searchQuery.isEmpty else {
                return teamList
            }
            
            let filteredAndSortedArray = teamList
                .sorted(by: { $0.fullName.lowercased() > $1.fullName.lowercased() })
                .filter { $0.fullName.lowercased().contains(searchQuery.lowercased()) }
            
            return .init(uniqueElements: filteredAndSortedArray)
        }
        
        var hasReachedEnd: Bool { 
            return teamsData.contains { teamsData in
                teamsData.id == teamList.last?.id
            }
        }
    }
}
```
We also need to define a type for the feature's actions. There are the obvious action, such as view on appear and the action that occurs when we receive a response from the team/player API request, and define a `team(id: TeamFeature.State.ID, action: TeamFeature.Action)` case to handle actions sent to the child domain `(TeamFeature: Reducer)`:

```swift
struct TeamListFeature: Reducer {
    struct State: Equatable { 
        var dataLoadingStatus = DataLoadingStatus.notStarted 
        var teamList: IdentifiedArrayOf<TeamData> = []
        var searchQuery = "" 
        var page = 1 
        var totalPages: Int?
        var teamsData: [TeamData] = []
        
        var shouldShowError: Bool {
            dataLoadingStatus == .error
        }
        
        var isLoading: Bool {
            dataLoadingStatus == .loading
        }
        
        var searchResults: IdentifiedArrayOf<TeamData> {
            guard !searchQuery.isEmpty else {
                return teamList
            }
            
            let filteredAndSortedArray = teamList
                .sorted(by: { $0.fullName.lowercased() > $1.fullName.lowercased() })
                .filter { $0.fullName.lowercased().contains(searchQuery.lowercased()) }
            
            return .init(uniqueElements: filteredAndSortedArray)
        }
        
        var hasReachedEnd: Bool { 
            return teamsData.contains { teamsData in
                teamsData.id == teamList.last?.id
            }
        }
    }
    enum Action: Equatable {
        case fetchTeamResponse(TaskResult<TeamsModel>)
        case fetchTeamNextResponse(TaskResult<TeamsModel>)
        case searchQueryChanged(String)
        case onAppear
        case onAppearTeamForNextPage
    }
}
```
And then we implement the reduce method which is responsible for handling the actual logic and behavior for the feature. It describes how to change the current state to the next state, and describes what effects need to be executed. Some actions don't need to execute effects, and they can return .none to represent that:

```swift
struct TeamListFeature: Reducer {
  struct State: Equatable { /* ... */ }
  enum Action: Equatable { /* ... */ }

@Dependency(\.matchScoresClient) var matchScoresClient
    var body: some ReducerOf<TeamListFeature> {
        Reduce { state, action in
            switch action {
                case let .fetchTeamResponse(.failure(error)):
                    state.dataLoadingStatus = .error
                    MatchScoresLogger.log(error, level: .error)
                    MatchScoresLogger.log("DEBUG: getting teams, try again later.", level: .debug)
                    return .none // We don't have any action so, no side-effect to run
                    
                case let .fetchTeamResponse(.success(teamData)):
                    state.totalPages =
                    teamData.meta.totalCount
                    state.teamsData = teamData.data
                    state.teamList = IdentifiedArrayOf(
                        uniqueElements: teamData.data.sorted(by: >)
                    )
                    state.dataLoadingStatus = .loading
                    return .none // We don't have any action so, no side-effect to run
                    
                case .onAppear:
                    state.dataLoadingStatus = .loading
                    return .run { [page = state.page] send in
                        await send (
                            .fetchTeamResponse(
                                TaskResult { try await matchScoresClient.fetchTeams(page) }
                            )
                        )
                    }
                    
                case let .searchQueryChanged(query):
                    state.searchQuery = query
                    guard !query.isEmpty else {
                        return .cancel(id: CancelID.team)
                    }
                    return .none // We don't have any action so, no side-effect to run
                    
                case let .fetchTeamNextResponse(.failure(error)):
                    state.dataLoadingStatus = .error
                MatchScoresLogger.log(error, level: .error)
                MatchScoresLogger.log("DEBUG: getting teams next page, try again later.", level: .debug)
                    return .none
                    
                case let .fetchTeamNextResponse(.success(teamData)):
                    state.totalPages = teamData.meta.totalCount
                    state.teamList += IdentifiedArrayOf(uniqueElements: teamData.data.sorted(by: >))
                    state.dataLoadingStatus = .loading
                    return .none // We don't have any action so, no side-effect to run
                    
                case .onAppearTeamForNextPage:
                    guard state.page != state.totalPages else { return .none }
                    state.page += 1
                    
                    return .run { [page = state.page] send in
                        await send (
                            .fetchTeamNextResponse(
                                TaskResult { try await MatchScoresClient.liveValue.fetchTeams(page) }
                            )
                        )
                    }
            }
        }
    }
}
```
And then finally we define the view that displays the feature. It holds onto a `StoreOf<TeamListFeature>` so that it can observe all changes to the state and re-render, and we can send all user actions to the store so that state changes. `ForEachStore` loops over a store’s collection with a store scoped to the domain of each element. This allows us to extract and modularize an element’s view and avoid concerns around collection index math and parent-child store communication:

```swift
struct TeamListView: View {
    let store: Store<TeamListFeature.State, TeamListFeature.Action>
    private let columns = Array(repeating: GridItem(.flexible()),
                                count: 2)
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack {
                ScrollView {
                    LazyVGrid(columns: columns,
                              spacing: 16) {
                        ForEach(viewStore.searchResults) { team in
                            NavigationLink {
                                if avatars.indices.contains(team.id - 1) {
                                    TeamDetailView(team: team, avatars: avatars[team.id - 1])
                                } else {
                                    TeamDetailView(team: team, avatars: "basketball.circle.fill")
                                }
                            } label: {
                                TeamView(team: team)
                                    .onFirstAppear {
                                        if viewStore.hasReachedEnd {
                                            viewStore.send(.onAppearTeamForNextPage)
                                        }
                                    }
                            }
                        }
                    }
                              .padding()
                              .accessibilityIdentifier("teamsGrid")
                }
                .overlay {
                    if viewStore.searchResults.isEmpty {
                        ContentUnavailableView.search
                    }
                }
                .refreshable {
                    viewStore.send(.onAppear)
                }
                .searchable(text: viewStore.binding(
                    get: \.searchQuery, send: TeamListFeature.Action.searchQueryChanged
                ), placement: .automatic, prompt: "Search NBA Teams")
            }
            .navigationTitle("Teams")
            .toolbarBackground(Color.blue._300, for: .navigationBar)
            .toolbarBackground(Color.blue._300, for: .tabBar)
            .onFirstAppear {
                viewStore.send(.onAppear)
            }
        }
        .background(Color.blue._300)
        .embedInNavigation()
    }
}
```

👶🏼👶🏼 To implement this child (grand-child of `RootFeature` or child of `TeamListFeature`) feature we create a new type that will house the domain and behavior of the child feature by conforming to Reducer:

```swift
struct TeamFeature: Reducer {
    struct State: Equatable, Identifiable {
        let id: UUID
        let team: TeamData
    }
    enum Action: Equatable { }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> { }
}
```
And then we define the view that displays the feature. It holds onto a `StoreOf<TeamFeature>` so that it can observe all changes to the state and re-render, and we can send all user actions to the store so that state changes. `WithViewStore` is a view helper that transforms a `Store` into a `ViewStore` so that its state can be observed by a view builder:

```swift
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
