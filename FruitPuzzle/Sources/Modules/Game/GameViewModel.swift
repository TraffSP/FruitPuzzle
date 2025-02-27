//
//  GameViewModel.swift
//  FruitPuzzle
//
//  Created by muser on 21.02.2025.
//

import SwiftUI
import Foundation

struct Equation: Identifiable {
    let id = UUID()
    let images: [String]
    let result: Int
    var userAnswer: Int?
    var isHint: Bool
}

class GameViewModel: ObservableObject {
    @Published var id: String
    @Published var level: Int
    @Published var equations: [Equation] = []
    @Published var numberMapping: [String: Int] = [:]
    @Published var isCorrect: Bool = false
    @Published var timeElapsed: TimeInterval = 0
    @Published var timerActive: Bool = false
    
    private var timer: Timer?
    private var startTime: Date?

    init(id: String, level: Int) {
        self.id = id
        self.level = level
        generateNumberMapping()
    }
    
    private func generateNumberMapping() {
        let fruits = ["banana", "maize", "pear", "pineapple", "radish", "tomato", "redApple"]
        numberMapping = Dictionary(uniqueKeysWithValues: fruits.map { ($0, getRandomNumber()) })
    }
    
    private func getRandomNumber() -> Int {
        let base = level < 3 ? 10 : level < 5 ? 20 : 50
        return Int.random(in: base...(base * 2))
    }
    var formattedTime: String {
        let minutes = Int(timeElapsed) / 60
        let seconds = Int(timeElapsed) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func startTimer() {
        timeElapsed = 0
        timerActive = true
        startTime = Date()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self, let startTime = self.startTime else { return }
            self.timeElapsed = Date().timeIntervalSince(startTime)
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timerActive = false
    }
    
    func generateEquations() {
        equations.removeAll()
        startTimer()
        
        switch level {
        case 1, 2:
            let firstFruit = "banana"
            let secondFruit = "maize"
            
            equations.append(Equation(images: [firstFruit, firstFruit, firstFruit], result: numberMapping[firstFruit]! * 3, isHint: true))
            equations.append(Equation(images: [firstFruit, secondFruit, secondFruit], result: numberMapping[firstFruit]! + numberMapping[secondFruit]! * 2, isHint: true))
            equations.append(Equation(images: [firstFruit, secondFruit], result: numberMapping[firstFruit]! + numberMapping[secondFruit]!, isHint: false))
            
        case 3, 4:
            let firstFruit = "banana"
            let secondFruit = "maize"
            let thirdFruit = "pear"
            
            equations.append(Equation(images: [firstFruit, firstFruit, firstFruit], result: numberMapping[firstFruit]! * 3, isHint: true))
            equations.append(Equation(images: [firstFruit, secondFruit, secondFruit], result: numberMapping[firstFruit]! + numberMapping[secondFruit]! * 2, isHint: true))
            equations.append(Equation(images: [secondFruit, thirdFruit, thirdFruit], result: numberMapping[secondFruit]! + numberMapping[thirdFruit]! * 2, isHint: true))
            equations.append(Equation(images: [firstFruit, secondFruit, thirdFruit], result: numberMapping[firstFruit]! + numberMapping[secondFruit]! + numberMapping[thirdFruit]!, isHint: false))
            
        case 5...16:
            let firstFruit = "banana"
            let secondFruit = "maize"
            let thirdFruit = "pear"
            let fourthFruit = "pineapple"
            
            equations.append(Equation(images: [firstFruit, firstFruit], result: numberMapping[firstFruit]! * 2, isHint: true))
            equations.append(Equation(images: [secondFruit, secondFruit], result: numberMapping[secondFruit]! * 2, isHint: true))
            equations.append(Equation(images: [thirdFruit, fourthFruit], result: numberMapping[thirdFruit]! + numberMapping[fourthFruit]!, isHint: true))
            equations.append(Equation(images: [firstFruit, secondFruit, thirdFruit, fourthFruit], result: (numberMapping[firstFruit]! * numberMapping[secondFruit]!) / (numberMapping[thirdFruit]! / numberMapping[fourthFruit]!), isHint: false))
            
        default:
            break
        }
    }
    
    func updateAnswer(for id: UUID, with value: Int?) {
        if let index = equations.firstIndex(where: { $0.id == id }) {
            equations[index].userAnswer = value
        }
    }
    
    func checkAnswers() {
        for equation in equations where !equation.isHint {
            guard let userAnswer = equation.userAnswer else {
                isCorrect = false
                return
            }
            let correctSum = equation.images.reduce(0) { $0 + (numberMapping[$1] ?? 0) }
            if userAnswer != correctSum {
                isCorrect = false
                return
            }
        }
        isCorrect = true
        stopTimer()
    }
    
    func levelPassed() {
        let gameStorage = MainDomainModelStorage()
        
        guard var user = gameStorage.read().first else { return }
        
        let levels = user.levels

        guard let currentIndex = levels.firstIndex(where: { $0.id.uuidString == id }) else { return }

        let nextIndex = levels.index(after: currentIndex)

        guard nextIndex < levels.count else { return }

        let currentItem = levels[currentIndex]
        let nextItem = levels[nextIndex]

        do {
            try gameStorage.storage.realm?.write {
                if currentItem.time == 0 || currentItem.time > Int(timeElapsed) {
                    currentItem.time = Int(timeElapsed)
                }

                nextItem.isResolved = true
            }
            
            gameStorage.store(item: user)
        } catch {
            print("Failed to write to Realm, reason: \(error.localizedDescription)")
        }
    }
}



