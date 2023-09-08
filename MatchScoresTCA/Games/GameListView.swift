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
                            .foregroundColor(.gray)
                    }
                    .listRowSeparator(.hidden)
                    
                    HStack {
                        HStack {
                            Image(systemName: "basketball.circle.fill")
                                .resizable()
                                .padding(.trailing, 0)
                                .frame(width: 50, height: 50)
                            
                            Text(game.visitorTeam.name)
                                .font(.callout)
                            
                            Text("\(game.visitorTeamScore)")
                                .font(.callout)
                        }
                        .padding()
                        
                        Text("-")
                            .font(.callout)
                        
                        HStack {
                            Text("\(game.homeTeamScore)")
                                .font(.callout)
                            
                            Text(game.homeTeam.name)
                                .font(.callout)
                            
                            Image(systemName: "basketball.circle")
                                .resizable()
                                .padding(.leading, 0)
                                .frame(width: 50, height: 50)
                            
                        }
                    }
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
                    .padding()
                }
                .refreshable {
                    viewStore.send(.onAppear)
                }
                .navigationTitle("Games")
                .listRowSeparator(.hidden)
                .onAppear {
                    viewStore.send(.onAppear)
                }
            }
        }
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
