//
//  OnboardingScreen.swift
//  FruitPuzzle
//
//  Created by muser on 20.02.2025.
//

import SwiftUI
import Combine

struct OnboardingScreen: View {
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            RotatingApplesLoader()
            Spacer()
            Text("Loading...")
                .foregroundStyle(.white)
                .font(Font.system(size: 36, weight: .heavy, design: .rounded))
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image(.mainBackground)
                .resizable()
                .ignoresSafeArea()
        )
    }
}

#Preview {
    OnboardingScreen()
}


struct RotatingApplesLoader: View {
    @State private var rotation: Double = 0

    var body: some View {
        ZStack {
            Image(.loader)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 200)
                .padding()
                .background(
                    Image(.ellipse)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 320, height: 320)
                )
            ForEach(0..<3) { i in
                Image(.apple)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .offset(x: 80, y: 0)
                    .rotationEffect(.degrees(Double(i) * 120))
                    .rotationEffect(.degrees(rotation), anchor: .center)
            }
        }
        .onAppear {
            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                rotation = 360
            }
        }
    }
}

//struct LoadingCircleBlinks: View {
//    
//    let timer: Publishers.Autoconnect<Timer.TimerPublisher>
//    let timing: Double
//    
//    let maxCounter: Int = 7
//    @State var counter = 0
//
//    let frame: CGSize
//    let primaryColor: Color
//    
//    init(color: Color = .black, size: CGFloat = 50, speed: Double = 0.5) {
//        timing = speed / 2
//        timer = Timer.publish(every: timing, on: .main, in: .common).autoconnect()
//        frame = CGSize(width: size, height: size)
//        primaryColor = color
//    }
//
//    var body: some View {
//        ZStack {
//            ForEach(0..<maxCounter) { index in
////                Circle()
////                    .fill(primaryColor)
//                Image(.apple)
//                    .resizable()
//                    .frame(width: 80, height: 80)
//                    .frame(height: frame.height / 5)
//                    .frame(width: frame.width, height: frame.height, alignment: .top)
//                    .rotationEffect(Angle(degrees: 360 / Double(maxCounter) * Double(index)))
//                    .opacity(
//                        counter == index ? 1.0 :
//                        counter == index + 1 ? 0.5 :
//                        counter == (maxCounter - 1) && index == (maxCounter - 1) ? 0.5 :
//                        0.0)
//            }
//        }
//        .frame(width: frame.width, height: frame.height, alignment: .center)
//        .onReceive(timer, perform: { _ in
//            withAnimation(Animation.easeInOut(duration: timing).repeatCount(1, autoreverses: true)) {
//                counter = counter == (maxCounter - 1) ? 0 : counter + 1
//            }
//        })
//    }
//}
