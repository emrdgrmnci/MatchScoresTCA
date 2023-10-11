//
//  PlayerDetailStatsView.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 11.10.2023.
//

import SwiftUI

struct PlayerDetailStatsView: View {
    @State private var statsModel: StatsModel?
    @State private var statsData: [StatsData] = []
    var player: PlayerData

    let columns = ["BY YEAR", "TEAM", "MIN", "PTS", "FGM", "FGA", "FG%", "3PM", "3PA", "3P%", "FTM", "FTA", "FT%", "OREB", "DREB", "REB", "AST", "STL", "BLK", "PF"]

    @State private var columnWidths: [CGFloat] = Array(repeating: 60, count: 20)

    var body: some View {
        NavigationStack {
            ZStack {
                Color.blue._50
                    .edgesIgnoringSafeArea(.all)
                ScrollView([.horizontal, .vertical], showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        // Header Row
                        Text("Player Stats")
                        headerRow
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .fixedSize(horizontal: false, vertical: true)

                        // Data Rows
                        if !statsData.isEmpty {
                            LazyVStack(alignment: .leading, spacing: 50) {
                                ForEach(statsData, id: \.id) { data in
                                    HStack {
                                        ForEach(columns.indices, id: \.self) { columnIndex in
                                            dataRow(data: data, columnIndex: columnIndex)
                                                .frame(width: columnWidths[columnIndex])
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 20, leading: 10, bottom: 10, trailing: 10))
                }
                .scrollContentBackground(.hidden)
                .toolbarBackground(Color.blue._50, for: .navigationBar)
                .toolbarBackground(Color.blue._50, for: .tabBar)
                .onAppear {
                    Task {
                        do {
                            statsModel = try await MatchScoresClient.liveValue.fetchStats(String(player.id))
                            if let data = statsModel?.data {
                                statsData = data
                            }
                        } catch(let error) {
                            print(error)
                        }
                    }
                }
            }
        }
        .background(Color.blue._50)
        .embedInNavigation()
    }

    private var headerRow: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(columns.indices, id: \.self) { columnIndex in
                        Text(columns[columnIndex])
                            .frame(width: columnWidths[columnIndex])
                    }
                }
                .background(Color.blue)
                .foregroundColor(.white)
                .fixedSize(horizontal: false, vertical: true)
                .onChange(of: geometry.size) { newSize in
                    updateColumnWidths(geometry: newSize)
                }
            }
        }
    }

    private func dataRow(data: StatsData, columnIndex: Int) -> Text {
        let columnName = columns[columnIndex]
        return Text(dataValue(data: data, columnName: columnName))
    }

    private func dataValue(data: StatsData, columnName: String) -> String {
        switch columnName {
        case "BY YEAR":
            return "\(data.game?.season ?? 0)"
        case "TEAM":
            return data.team?.abbreviation ?? ""
        case "MIN":
            return data.min ?? ""
        case "PTS":
            return "\(data.pts ?? 0)"
        case "FGM":
            return "\(data.fgm ?? 0)"
        case "FGA":
            return "\(data.fga ?? 0)"
        case "FG%":
            return String(format: "%.2f", data.fgPct ?? 0.0)
        case "3PM":
            return "\(data.fg3M ?? 0)"
        case "3PA":
            return "\(data.fg3A ?? 0)"
        case "3P%":
            return String(format: "%.2f", data.fg3Pct ?? 0.0)
        case "FTM":
            return "\(data.ftm ?? 0)"
        case "FTA":
            return "\(data.fta ?? 0)"
        case "FT%":
            return String(format: "%.2f", data.ftPct ?? 0.0)
        case "OREB":
            return "\(data.oreb ?? 0)"
        case "DREB":
            return "\(data.dreb ?? 0)"
        case "REB":
            return "\(data.reb ?? 0)"
        case "AST":
            return "\(data.ast ?? 0)"
        case "STL":
            return "\(data.stl ?? 0)"
        case "BLK":
            return "\(data.blk ?? 0)"
        case "PF":
            return "\(data.pf ?? 0)"
        default:
            return ""
        }
    }

    private func updateColumnWidths(geometry: CGSize) {
        let availableWidth = geometry.width
        let equalWidth = availableWidth / CGFloat(columns.count)
        columnWidths = Array(repeating: equalWidth, count: columns.count)
    }
}

struct PlayerDetailStatsView_Previews: PreviewProvider {
    static var previews: some View {
        let samplePlayer = PlayersModel.sample
        
        return NavigationView {
            PlayerDetailStatsView(player: samplePlayer.data.first!)
        }
    }
}
