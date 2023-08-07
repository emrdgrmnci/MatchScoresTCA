//
//  TeamListView.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 6.08.2023.
//

import SwiftUI
import Combine
import ComposableArchitecture

struct TeamListView: View {
    let store: Store<TeamFeature.State, TeamFeature.Action>

  var body: some View {
      WithViewStore(self.store, observe: { $0 }) { viewStore in
      ScrollView {
        LazyVStack {
            ForEach(viewStore.results) { repository in
                TeamView(store: store)
              .padding([.leading, .trailing, .bottom])
                
          }
        }
      }
        .edgesIgnoringSafeArea([.top, .leading, .trailing])
      .onAppear {
          guard let data = viewStore.resultTeamRequestInFlight else { return }
          viewStore.send(.onAppear(data))
      }
    }
  }
}

