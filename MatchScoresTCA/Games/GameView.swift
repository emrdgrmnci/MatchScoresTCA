//
//  GameView.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 8.09.2023.
//

import SwiftUI
import ComposableArchitecture

//struct GameView: View {
//    let game: GameData
//
//    var body: some View {
//        VStack(spacing: .zero) {
//
//            background
//
//            NavigationView {
//                VStack(alignment: .center) {
//
//                    Text(dateFormatter(inputDate: game.date))
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
//                        .padding(.top, 8)
//
//                    HStack{
//                        HStack {
//                            //Visitor Team
//                            Image(systemName: "basketball.circle.fill")
//                                .resizable()
//                                .frame(width: 50, height: 50)
//
//                            Text(game.visitorTeam.name)
//                                .font(.callout)
//                                .padding(.trailing, 8)
//
//                            Text("\(game.visitorTeamScore)")
//                                .font(.callout)
//
//                            HStack {
//                                Text("-")
//                            }
//                            .padding(.leading, 8)
//                        }
//
//                        Spacer()
//
//                        HStack {
//                            // Home team
//                            Text("\(game.homeTeamScore)")
//                                .font(.callout)
//
//                            Text(game.homeTeam.name)
//                                .font(.callout)
//                                .padding(.leading, 8)
//
//                            Image(systemName: "basketball.circle")
//                                .resizable()
//                                .frame(width: 50, height: 50)
//                        }
//                    }
//                }
//                .padding()
//                .overlay(
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(
//                            LinearGradient(
//                                gradient: Gradient(colors: [.blue, .green, .red]), // Customize your gradient colors here
//                                startPoint: .leading,
//                                endPoint: .trailing
//                            ),
//                            lineWidth: 1
//                        )
//                )
//                .padding()
//            }
//            .frame(height: 130)
//            .navigationBarTitle("Games")
//
//        }
//    }
//}
//
//private extension GameView {
//
//    var background: some View {
//        Theme.background
//            .ignoresSafeArea(edges: .top)
//    }
//
//    var refresh: some View {
//        Button {
//            Task {
//                // await vm.fetchTeams()
//            }
//        } label: {
//            Symbols.refresh
//        }
//        // .disabled(vm.isLoading)
//    }
//}

//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView(game: GamesModel.sample.data.first!)
//    }
//}

func dateFormatter(inputDate: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" // Input date format
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC") // Set the input timezone

    if let inputDate = dateFormatter.date(from: inputDate) {
        dateFormatter.dateFormat = "dd.MM.yyyy" // Desired output date format
        dateFormatter.timeZone = TimeZone.current // Set the desired output timezone (local)
        
        let outputDateString = dateFormatter.string(from: inputDate)
        return outputDateString // Output: 30.01.2019
    } else {
        return ""
    }
}
