//
//  TimerListItemView.swift
//  Timer
//
//  Created by billy on 10/16/23.
//

import SwiftUI

struct TimerListItemView: View {
    @ObservedObject var viewModel: TimerListItemViewModel

    var body: some View {
        Text(viewModel.displayString)
            .font(Font.custom("DigitaldreamNarrow", size: 24, relativeTo: .title))
    }
}

#Preview {
    TimerListItemView(viewModel: TimerListItemViewModel())
}
