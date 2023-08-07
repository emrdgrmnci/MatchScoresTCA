//
//  TeamView.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 6.08.2023.
//

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
                
                VStack {
                    PillView(id: viewStore.team.id)
                        .padding(.leading, 10)
                        .padding(.top, 10)
                }
                
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

private extension TeamView {
    
    var background: some View {
        Theme.background
            .ignoresSafeArea(edges: .top)
    }
    
    var refresh: some View {
        Button {
            Task {
//                await vm.fetchTeams()
            }
        } label: {
            Symbols.refresh
        }
//        .disabled(vm.isLoading)
    }
}

struct TeamView_Previews: PreviewProvider {
    static var previews: some View {
        return TeamView(
            store: Store(
                initialState: TeamFeature.State(id: UUID(), team: TeamData(id: 1, abbreviation: "ATL", city: "Atlanta", division: "Southeast", fullName: "Atlanta Hawks", name: "Hawks"))) {
                    
                }
        )
    }
}
