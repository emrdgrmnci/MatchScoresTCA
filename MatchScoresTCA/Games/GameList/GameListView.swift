import SwiftUI
import ComposableArchitecture

struct GameListView: View {
    let store: StoreOf<GameListFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationView {
                List(viewStore.gameList) { game in
                    
                        VStack(alignment: .center) {
                            Text(dateFormatter(inputDate: game.date))
                                .font(.subheadline)
                                .background(Color.blue._50)
                        
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .listRowSeparator(.hidden)
                        
                        Spacer()
                        
                        HStack(spacing: 24) {
                            VStack {
                                Image(systemName: "basketball.circle.fill")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                
                                Text(game.visitorTeam.name)
                                    .font(.callout)
                            }
                            .frame(width: 79)
                            
                            HStack {
                                Text("\(game.visitorTeamScore)")
                                    .font(.callout)
                                
                                Text("-")
                                    .font(.callout)
                                
                                Text("\(game.homeTeamScore)")
                                    .font(.callout)
                            }
                            
                            VStack {
                                Image(systemName: "basketball.circle")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                
                                Text(game.homeTeam.name)
                                    .font(.callout)
                            }
                            .frame(width: 79)
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
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                    .background(Color.blue._50)
                    .cornerRadius(10)
                    .listRowSeparator(.hidden)
                }
                .background(Color.blue._50)
                .frame(maxWidth: .infinity)
                .refreshable {
                    viewStore.send(.onAppear)
                }
                .navigationTitle("Games")
                .onAppear {
                    viewStore.send(.onAppear)
                }
            }
            .background(Color.blue._50)
        }
        .background(Color.blue._50)
    }

}

private extension GameListView {
    
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
