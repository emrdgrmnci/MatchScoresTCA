//
//  FavoriteListView.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 6.08.2023.
//

//import SwiftUI
//import ComposableArchitecture
//
//struct FavoritesListView: View {
//  let store: Store<RepositoryState, RepositoryAction>
//
//  var body: some View {
//    WithViewStore(self.store) { viewStore in
//      ScrollView {
//        LazyVStack {
//          ForEach(viewStore.favoriteRepositories) { repository in
//            RepositoryView(store: store, repository: repository)
//              .padding([.leading, .trailing, .bottom])
//          }
//        }
//      }
//      .background(Color("rw-dark")
//        .edgesIgnoringSafeArea([.top, .leading, .trailing]))
//    }
//  }
//}
