//
//  TimerCountDownText.swift
//  Timer
//
//  Created by billy on 10/2/23.
//

import SwiftUI

struct TimerCountDownText: View {
    @ObservedObject var viewModel: TimerViewModel

    var body: some View {
        HStack(alignment: .top) {
            Text(viewModel.displayString)
                .font(Font.custom("DigitaldreamNarrow", size: 50, relativeTo: .largeTitle))
            Text(viewModel.subSecondDisplayString)
                .font(Font.custom("DigitaldreamNarrow", size: 30, relativeTo: .title3))
        }
    }
}

#Preview {
    TimerCountDownText(viewModel: TimerViewModel())
}
