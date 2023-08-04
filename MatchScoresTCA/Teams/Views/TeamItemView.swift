//
//  TeamItemView.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 4.08.2023.
//

import SwiftUI

struct TeamItemView: View {
    
    let teams: Datum
    
    
    var body: some View {
        VStack(spacing: .zero) {
            VStack(alignment: .leading) {
                Text("\(teams.name)")
                //                    .foregroundColor(Theme.text)
                    .font(
                        .system(.largeTitle, design: .rounded)
                    )
                //                    .background(
                //                        Image(avatars[teams.id - 1])
                //                            .opacity(0.4)
                //                            .aspectRatio(contentMode: .fill)
                //                    )
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 150.0)
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
            //            .background(Theme.detailBackground)
            
            //            VStack {
            //                PillView(id: teams.id)
            //                    .padding(.leading, 10)
            //                    .padding(.top, 10)
            //            }
            
        }
        .clipShape(
            RoundedRectangle(cornerRadius: 16,
                             style: .continuous)
        )
        //        .shadow(color: Theme.text.opacity(0.1),
        //                radius: 2,
        //                x: 0,
        //                y: 1)
        
    }
}
