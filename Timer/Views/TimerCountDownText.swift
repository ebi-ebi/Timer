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
                .font(Font.custom("lcd14", size: 50, relativeTo: .largeTitle))
            Text(viewModel.subSecondDisplayString)
                .font(Font.custom("lcd14", size: 30, relativeTo: .title3))
        }
    }
}

struct TimerCountDownText_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TimerCountDownText(viewModel: TimerViewModel())
        }
    }
}
