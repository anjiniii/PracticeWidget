//
//  TargetWidget.swift
//  TargetWidget
//
//  Created by Anjin on 10/8/24.
//

import WidgetKit
import SwiftUI

import NetworkModule

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct TargetWidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry

    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            viewss
        case .systemMedium:
            viewss
        case .systemLarge:
            viewss
        case .systemExtraLarge:
            viewss
        case .accessoryCorner:
            viewss
        case .accessoryCircular:
            viewss
        case .accessoryRectangular:
            viewss
        case .accessoryInline:
            viewss
        }
//        GeometryReader { geo in
//            HStack {
//                VStack {
//                    Text("\(entry.date.day)")
//                        .font(.title)
//                    Text("\(getWeekdayString(entry.date.weekday))")
//                }
//                .frame(width: geo.size.width * 0.15)
//                .background(Color.yellow.opacity(0.4))
//                
//                VStack(alignment: .leading) {
//                    //            Text("Time:")
//                    //            Text(entry.date, style: .time)
//                    //
//                    //            Text("Emoji:")
//                    //            Text(entry.emoji)
//                    
//                    
//                    Text("오늘의 소확행 🍀")
//                        .bold()
//                    
//                    Text("평소에 좋아하던 책 꺼내 읽기")
//                }
//            }
//        }
    }
    
    var viewss: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                Text(getString())
                    .foregroundStyle(Color.white)
                Spacer()
            }
            Spacer()
        }
        .background(Color.black)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    func getString() -> String {
        return TestNetworkss().dummy
    }
    
    func getWeekdayString(_ weekday: Int) -> String {
        let weekdays = ["일", "월", "화", "수", "목", "금", "토"]
        return weekdays[weekday - 1]
    }
}

extension Date {
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }
}

struct TargetWidget: Widget {
    let kind: String = "TargetWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                TargetWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                TargetWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("오늘의 소확행 🍀")
        .description("오늘의 소확행 선물을 미리 받아볼 수 있어요!")
    }
}

#Preview(as: .systemMedium) {
    TargetWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
}
