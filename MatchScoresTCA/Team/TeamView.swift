//
//  TeamView.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 6.08.2023.
//

import SwiftUI
import ComposableArchitecture

struct TeamView: View {
    
    let store: Store<TeamFeature.State, TeamFeature.Action>
    
    var body: some View {
        WithViewStore(self.store, observe: {$0} ) { viewStore in
            HStack {
                Spacer()
                VStack(spacing: 8) {
                    Text(viewStore.resultTeamRequestInFlight?.fullName ?? "")
                        .font(.title)
                    Text(viewStore.resultTeamRequestInFlight?.city ?? "")
                        .bold()
                    + Text(" Players | ")
                    + Text(viewStore.resultTeamRequestInFlight?.name ?? "")
                        .bold()
                    + Text(" player")
                    Spacer()
                }
                .padding()
                .onAppear {
                    guard let data = viewStore.resultTeamRequestInFlight else { return }
                    viewStore.send(.onAppear(data))
                }
                Spacer()
            }
        }
        .background(Color("launch-screen-background").edgesIgnoringSafeArea([.top, .leading, .trailing]))
    }
}

//struct TeamView_Previews: PreviewProvider {
//  static var previews: some View {
//    return TeamView(
//      store: Store(
//        initialState: TeamFeature.State(),
//        reducer: userReducer))
//  }
//}


