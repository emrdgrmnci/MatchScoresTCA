//
//  PlayerListView.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 6.08.2023.
//

import SwiftUI
import Combine
import ComposableArchitecture

struct PlayerListView: View {
    let store: Store<PlayerFeature.State, PlayerFeature.Action>

  var body: some View {
      WithViewStore(self.store, observe: { $0 }) { viewStore in
      ScrollView {
        LazyVStack {
          ForEach(viewStore.results) { repository in
            PlayerView(store: store)
              .padding([.leading, .trailing, .bottom])
          }
        }
      }
        .edgesIgnoringSafeArea([.top, .leading, .trailing])
      .onAppear {
          guard let data = viewStore.resultPlayerRequestInFlight else { return }
        viewStore.send(.onAppear(data))
      }
    }
  }
}
