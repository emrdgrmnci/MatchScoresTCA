//
//  TeamView.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 6.08.2023.
//

import SwiftUI
import ComposableArchitecture

public extension View {
    func onFirstAppear(_ action: @escaping () -> ()) -> some View {
        modifier(FirstAppear(action: action))
    }
}

private struct FirstAppear: ViewModifier {
    let action: () -> ()
    
    // Use this to only fire your block one time
    @State private var hasAppeared = false
    
    func body(content: Content) -> some View {
        // And then, track it here
        content.onAppear {
            guard !hasAppeared else { return }
            hasAppeared = true
            action()
        }
    }
}

struct TeamView: View {
        
    let team: TeamData
    
    init(team: TeamData) {
        self.team = team
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            
            VStack {
                Image(avatars[team.id - 1])
                    .resizable()
                    .frame(width: 50, height: 50)
                
                Text(team.name)
                    .font(
                        .system(.title, design: .rounded)
                    )
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 150.0)
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
            
            VStack {
                PillView(id: team.id)
                    .padding(.leading, 10)
                    .padding(.top, 10)
            }
            
        }
        .background(Color.blue._50)
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
        .shadow(color: Theme.text.opacity(0.1),
                radius: 2,
                x: 0,
                y: 1)
        .edgesIgnoringSafeArea([.top, .leading, .trailing])
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
                // await vm.fetchTeams()
            }
        } label: {
            Symbols.refresh
        }
        // .disabled(vm.isLoading)
    }
}

struct TeamView_Previews: PreviewProvider {
    static var previews: some View {
        TeamView(team: .init(id: 1, abbreviation: "ATL", city: "Atlanta", conference: "East", division: "Southeast", fullName: "Atlanta Hawks", name: "Hawks"))
    }
}
