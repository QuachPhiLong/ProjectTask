//
//  ChartView.swift
//  DreamerlyTest
//
//  Created by Long Quách on 10/09/2024.
//

import SwiftUI
import Charts

struct ToyShape: Identifiable {
    var type: String
    var status: String
    var count: Int
    var id = UUID()
}

struct ChartView: View {
    
    let data: [ToyShape]
    
    var body: some View {
        Chart {
            ForEach(data) { shape in
                BarMark(
                    x: .value("Task type", shape.type),
                    y: .value("Total Count", shape.count)
                )
                .foregroundStyle(by: .value("Task status", shape.status))
            }
        }
        .chartForegroundStyleScale([
            TaskStatus.completed.rawValue: .green, TaskStatus.toDo.rawValue: .gray, TaskStatus.pending.rawValue: .orange
        ])
        .chartBackground { _ in
            Rectangle().fill(Color.clear)
        }
        .frame(height: 200)
        .padding()
    }
}
