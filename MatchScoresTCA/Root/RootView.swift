//
//  RootView.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 6.08.2023.
//

import SwiftUI
import ComposableArchitecture

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

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(
            store: Store(
                initialState: RootFeature.State()
            ) {
                RootFeature(
                    fetchTeams: { TeamsModel.sample },
                    fetchPlayers: { PlayersModel.sample },
                    uuid: { UUID() }
                )
            }
        )
    }
}
