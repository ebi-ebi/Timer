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
                .font(.largeTitle)
                .monospaced()
            Text(viewModel.subSecondDisplayString)
                .font(.title3)
                .monospaced()
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
