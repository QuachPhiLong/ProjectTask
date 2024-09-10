//
//  HomeCardView.swift
//  DreamerlyTest
//
//  Created by Long Quách on 09/09/2024.
//

import SwiftUI

struct HomeCardView: View {
    var task: Task

    var body: some View {
        var gradient = Gradient(colors: [])
        switch task.taskType {
        case TaskType.work.rawValue:
            gradient = Gradient(colors: [.red, .yellow])
        case TaskType.personal.rawValue:
            gradient = Gradient(colors: [Assets.primaryColor.swiftUIColor, .cyan])
        default:
            gradient = Gradient(colors: [])
        }
        
        var imageStatus: Image?
        var statusColor: Color = .gray
        switch task.status {
        case TaskStatus.pending.rawValue:
            imageStatus = Image(systemName: "exclamationmark.arrow.circlepath")
            statusColor = .orange
        case TaskStatus.completed.rawValue:
            imageStatus = Image(systemName: "checkmark.seal.fill")
            statusColor = .green
        default:
            imageStatus = Image(systemName: "list.bullet.clipboard.fill")
            statusColor = .gray
        }
        return VStack(alignment: .leading){
            HStack {
                Circle()
                    .fill(RadialGradient(
                        gradient   : gradient,
                        center     : UnitPoint(x: 0.25, y: 0.25),
                        startRadius: 0.2,
                        endRadius  : 200
                    )).frame(width: 16)
                Spacer()
                Text(task.status ?? "").font(.caption2).foregroundStyle(statusColor)
                imageStatus?.foregroundColor(statusColor)
            }
            Text(task.title ?? "")
                .font(.title3)
                .foregroundColor(.gray)
            Text(task.desc ?? "")
                .font(.subheadline)
                .foregroundColor(.gray)
            if task.date != nil {
                HStack {
                    Image(systemName: "calendar.badge.clock")
                    Text(task.date?.getFormattedDate(format: "dd/MM/yyyy HH:mm") ?? "")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
        .frame(height: 100)
        .background(Assets.whiteColor.swiftUIColor)
        .cornerRadius(12)
    }
}
