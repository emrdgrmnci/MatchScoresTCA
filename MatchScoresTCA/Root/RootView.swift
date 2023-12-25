//
//  RootView.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 6.08.2023.
//

import SwiftUI
import ComposableArchitecture

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

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(
            store: Store(
                initialState: RootFeature.State()
            ) {
                RootFeature(
                    fetchTeams: { _ in TeamsModel.sample },
                    fetchGames: { GamesModel.sample },
                    fetchPlayers: { _ in PlayersModel.sample },
                    uuid: { UUID() }
                )
            }
        )
    }
}
