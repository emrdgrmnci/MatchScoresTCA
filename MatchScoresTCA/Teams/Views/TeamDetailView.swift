//
//  TeamDetailView.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 4.08.2023.
//

import SwiftUI

struct TeamDetailView: View {
    
    let userId: Int
    //    @EnvironmentObject private var teamsViewModel: TeamsViewModel
    //    @StateObject private var gamesViewModel: GamesViewModel
    @State var selectedSeason = 1949
    
    init(userId: Int) {
        self.userId = userId
#if DEBUG
        
        //        if UITestingHelper.isUITesting {
        //            let mock: NetworkingManagerImpl = UITestingHelper.isDetailsNetworkingSuccessful ? NetworkingManagerTeamsSuccessMock() : NetworkingManagerUserDetailsResponseFailureMock()
        //            _gamesViewModel = StateObject(wrappedValue: GamesViewModel(networkingManager: mock))
        //
        //        } else {
        //            _gamesViewModel = StateObject(wrappedValue: GamesViewModel())
        //        }
        
#else
        //        _gamesViewModel = StateObject(wrappedValue: GamesViewModel())
#endif
    }
    
    var body: some View {
        ZStack {
            background
            
            //            if teamsViewModel.isLoading {
            //                ProgressView()
            //            } else {
            ScrollView {
                VStack(alignment: .leading,
                       spacing: 18) {
                    Group {
                        general
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 18)
                    .background(Theme.detailBackground, in: RoundedRectangle(cornerRadius: 16,
                                                                             style: .continuous))
                    
                    Group {
                        Menu {
                            Picker(selection: $selectedSeason) {
                                ForEach(1949...2023, id:\.self) {
                                    Text("\($0)")
                                        .tag($0)
                                }
                            } label: {}
                        } label: {
                            VStack(alignment: .leading) {
                                Text("Select a season")
                                Divider()
                                Text("Season \(selectedSeason)")
                            }
                        }
                        //                            MatchView(season: selectedSeason, userId: userId)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 18)
                    .background(Theme.detailBackground, in: RoundedRectangle(cornerRadius: 16,
                                                                             style: .continuous))
                    
                }
                       .padding()
            }
            //            }
        }
        //        .navigationTitle(teamsViewModel.teams[userId].abbreviation)
        //        .alert(isPresented: $teamsViewModel.hasError,
        //               error: teamsViewModel.error) { }
    }
}

private extension TeamDetailView {
    
    var background: some View {
        //        Theme.background
        Color(white: 1.0).ignoresSafeArea(edges: .top)
    }
}

private extension TeamDetailView {
    
    var general: some View {
        VStack(alignment: .leading,
               spacing: 8) {
            
            PillView(id: userId + 1)
            
            Group {
                name
                fullName
//                city
            }
            .foregroundColor(Theme.text)
        }
    }
    
        @ViewBuilder
        var name: some View {
            Text("Name")
                .font(
                    .system(.body, design: .rounded)
                    .weight(.heavy)
                )
    
//            Text(teamsViewModel.teams[userId].name)
//                .font(
//                    .system(.subheadline, design: .rounded)
//                )
    
            Divider()
        }
    
        @ViewBuilder
        var fullName: some View {
            Text("Full Name")
                .font(
                    .system(.body, design: .rounded)
                    .weight(.heavy)
                )
    
//            Text(teamsViewModel.teams[userId].fullName)
//                .font(
//                    .system(.subheadline, design: .rounded)
//                )
    
            Divider()
        }
    //
    //    @ViewBuilder
    //    var city: some View {
    //        Text("City")
    //            .font(
    //                .system(.body, design: .rounded)
    //                .weight(.heavy)
    //            )
    //
    //        Text(.teams[userId].city)
    //            .font(
    //                .system(.subheadline, design: .rounded)
    //            )
    //    }
}
