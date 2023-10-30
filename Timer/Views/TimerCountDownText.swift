//
//  TimerCountDownText.swift
//  Timer
//
//  Created by billy on 10/2/23.
//

import SwiftUI

struct TimerCountDownText: View {
    @ObservedObject var timerViewModel: TimerViewModel

    var body: some View {
        HStack(alignment: .top) {
            Text(timerViewModel.displayString)
                .font(Font.custom("DigitaldreamNarrow", size: 50, relativeTo: .largeTitle))
            Text(timerViewModel.subSecondDisplayString)
                .font(Font.custom("DigitaldreamNarrow", size: 30, relativeTo: .title3))
        }
    }
}

#Preview {
    TimerCountDownText(timerViewModel: TimerViewModel())
}
