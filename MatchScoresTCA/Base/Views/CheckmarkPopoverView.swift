//
//  CheckmarkPopoverView.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 7.08.2023.
//

import SwiftUI

struct CheckmarkPopoverView: View {
    var body: some View {
        Symbols.checkmark
            .font(.system(.largeTitle,
                          design: .rounded).bold())
            .padding()
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 10,
                                                            style: .continuous))
    }
}

struct CheckmarkPopoverView_Previews: PreviewProvider {
    static var previews: some View {
        CheckmarkPopoverView()
            .previewLayout(.sizeThatFits)
            .padding()
            .background(.blue)
    }
}
