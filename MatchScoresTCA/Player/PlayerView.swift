//
//  PlayerView.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 6.08.2023.
//

import SwiftUI
import ComposableArchitecture

struct PlayerView: View {
    
    let store: Store<PlayerFeature.State, PlayerFeature.Action>
    
  var body: some View {
      WithViewStore(self.store, observe: {$0} ) { viewStore in
      HStack {
        Spacer()
        VStack(spacing: 8) {
            Text(viewStore.resultPlayerRequestInFlight?.firstName ?? "")
            .font(.title)
            Text(viewStore.resultPlayerRequestInFlight?.lastName ?? "")
            .bold()
            + Text(" Players | ")
            + Text(viewStore.resultPlayerRequestInFlight?.position ?? "")
              .bold()
            + Text(" player")
          Spacer()
        }
        .padding()
        .onAppear {
            guard let data = viewStore.resultPlayerRequestInFlight else { return }
            viewStore.send(.onAppear(data))
        }
        Spacer()
      }
    }
    .background(Color("launch-screen-background").edgesIgnoringSafeArea([.top, .leading, .trailing]))
  }
}

//struct UserView_Previews: PreviewProvider {
//  static var previews: some View {
//    return UserView(
//      store: Store(
//        initialState: UserState(),
//        reducer: userReducer,
//        environment: .dev(
//          environment: UserEnvironment(
//            userRequest: dummyUserEffect))))
//  }
//}

