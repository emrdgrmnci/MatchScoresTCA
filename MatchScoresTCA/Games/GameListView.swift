import SwiftUI
import ComposableArchitecture

enum GameInfoToken: String, Identifiable, Hashable, CaseIterable {
    case season
    case team
    var id: Self { self }
}

struct GameListView: View {
    let store: StoreOf<GameListFeature>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStack {
                GameListContentView(store: store)
                    .navigationTitle("Games")
                    .onAppear {
                        viewStore.send(.onAppear)
                    }
            }
        }
    }
}

struct GameListContentView: View {
    let store: StoreOf<GameListFeature>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack {
                Color.blue._300
                    .edgesIgnoringSafeArea(.all)
                List(viewStore.searchResults) { game in
                    GameRowView(game: game, viewStore: viewStore)
                }
                .scrollContentBackground(.hidden)
            }
            .overlay {
                if viewStore.searchResults.isEmpty {
                    ContentUnavailableView.search
                }
            }
            .searchable(
                text: viewStore.binding(
                    get: \.searchQuery, send: GameListFeature.Action.searchQueryChanged
                ),
                placement: .automatic,
                prompt: "Search All NBA Competitions"
            )
            .toolbarBackground(Color.blue._300, for: .navigationBar)
            .toolbarBackground(Color.blue._300, for: .tabBar)
            .frame(maxWidth: .infinity)
            .refreshable {
                store.send(.onAppear)
            }
        }
    }
}

struct GameRowView: View {
    let game: GameData
    let viewStore: ViewStore<GameListFeature.State, GameListFeature.Action>

    var body: some View {
        ZStack {
            NavigationLink(destination: GameDetailView(
                games: viewStore.gamesData,
                homeTeamID: game.homeTeam.id,
                visitorTeamID: game.visitorTeam.id
            )) {
                EmptyView()
            }
            .opacity(0.0)
            VStack(alignment: .center) {
                Text(dateFormatter(inputDate: game.date))
                    .font(.subheadline)
                
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                HStack(spacing: 24) {
                    VStack {
                        Image(avatars[game.visitorTeam.id - 1])
                            .resizable()
                            .frame(width: 70, height: 70)
                        
                        Text(game.visitorTeam.name)
                            .font(.callout)
                            .frame(width: 110)
                    }
                    .frame(width: 75)
                    
                    HStack {
                        Text("\(game.visitorTeamScore)")
                            .font(.callout)
                        
                        Text("-")
                            .font(.callout)
                        
                        Text("\(game.homeTeamScore)")
                            .font(.callout)
                    }
                    .shadow(color: Theme.text.opacity(0.5),
                            radius: 2,
                            x: 0,
                            y: 1
                    )
                    
                    VStack {
                        Image(avatars[game.homeTeam.id - 1])
                            .resizable()
                            .frame(width: 70, height: 70)
                        
                        Text(game.homeTeam.name)
                            .font(.callout)
                            .frame(width: 110)
                    }
                    .frame(width: 75)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(
                            LinearGradient(
                                gradient: Gradient(colors: [.blue, .green, .red]),
                                startPoint: .leading,
                                endPoint: .trailing
                            ),
                            lineWidth: 1
                        )
                )
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical)
        }
        .listRowBackground(Color.blue._300)
    }
}

private extension GameListView {
    
    var background: some View {
        Theme.background
            .ignoresSafeArea(edges: .top)
    }
    
    var refresh: some View {
        Button {
            Task {
                // await vm.fetchTeams()
            }
        } label: {
            Symbols.refresh
        }
        // .disabled(vm.isLoading)
    }
}
