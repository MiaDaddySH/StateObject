//
//  ContentView.swift
//  StateObject
//
//  Created by Yuangang Sheng on 2021/5/14.
//

import SwiftUI

struct ContentView: View {
  @State private var showRealName = false
  var body: some View {
    NavigationView {
      VStack {
        Button("Toggle Name") {
          showRealName.toggle()
        }
        Text("Current User: \(showRealName ? "Wei Wang" : "onevcat")")
        NavigationLink("Next", destination: ScorePlate().padding(.top, 20))
      }
    }
  }
}

class Model: ObservableObject {
  init() { print("Model Created") }
  @Published var score: Int = 0
}

struct ScorePlate: View {
  @ObservedObject var model: Model = Model()
  @State private var niceScore = false
  
  var body: some View {
    VStack {
      Button("+1") {
        if model.score > 3 {
          niceScore = true
        }
        model.score += 1
      }
      Text("Score: \(model.score)")
      Text("Nice? \(niceScore ? "YES" : "NO")")
      ScoreText(aModel: model).padding(.top, 20)
    }
    .background(Color.green)
  }
}

struct ScoreText: View {
  @ObservedObject var aModel: Model
  
  var body: some View {
    if aModel.score > 10 {
      return Text("Fantastic")
    } else if aModel.score > 3 {
      return Text("Good")
    } else {
      return Text("Ummmm...")
    }
  }
}
