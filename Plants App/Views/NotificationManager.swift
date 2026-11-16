//
//  NotificationManager.swift
//  Plants App
//
//  Created by wajd on 05/06/1448 AH.
//

import Foundation
import UserNotifications

final class NotificationManager {

    static let shared = NotificationManager()

    private init() {}

    private let notificationCenter = UNUserNotificationCenter.current()

    private let notificationHour = 9
    private let notificationMinute = 0

    private let numberOfNotifications = 60

    // MARK: - Request Permission

    func requestPermission() {
        notificationCenter.requestAuthorization(
            options: [.alert, .sound, .badge]
        ) { granted, error in

            if let error = error {
                print("Notification Error: \(error)")
                return
            }

            print("Permission granted: \(granted)")
        }
    }

    // MARK: - Schedule Notifications

    func scheduleNotification(for reminder: PlantReminder) {

        guard !reminder.isCompleted else {
            cancelNotification(for: reminder)
            return
        }

        cancelNotification(for: reminder)

        let days = wateringInterval(
            for: reminder.wateringDays
        )

        let content = UNMutableNotificationContent()
        content.title = "Planto 🌱"
        content.body = "Hey! Let's water your \(reminder.plantName)"
        content.sound = .default

        let calendar = Calendar.current
        let now = Date()

        guard let firstNotificationDate = nextNotificationDate(
            from: now,
            interval: days,
            calendar: calendar
        ) else {
            return
        }

        for index in 0..<numberOfNotifications {

            guard let notificationDate = calendar.date(
                byAdding: .day,
                value: index * days,
                to: firstNotificationDate
            ) else {
                continue
            }

            let components = calendar.dateComponents(
                [.year, .month, .day, .hour, .minute],
                from: notificationDate
            )

            let trigger = UNCalendarNotificationTrigger(
                dateMatching: components,
                repeats: false
            )

            let request = UNNotificationRequest(
                identifier: notificationIdentifier(
                    for: reminder,
                    index: index
                ),
                content: content,
                trigger: trigger
            )

            notificationCenter.add(request) { error in
                if let error = error {
                    print("Schedule Error: \(error)")
                }
            }
        }

        print("Notifications scheduled for \(reminder.plantName)")
    }

    // MARK: - Next Notification Date

    private func nextNotificationDate(
        from date: Date,
        interval: Int,
        calendar: Calendar
    ) -> Date? {

        let todayAtNine = calendar.date(
            bySettingHour: notificationHour,
            minute: notificationMinute,
            second: 0,
            of: date
        )

        guard let todayAtNine = todayAtNine else {
            return nil
        }

        let firstDate: Date

        if todayAtNine > date {
            firstDate = todayAtNine
        } else {
            guard let nextDate = calendar.date(
                byAdding: .day,
                value: 1,
                to: todayAtNine
            ) else {
                return nil
            }

            firstDate = nextDate
        }

        return calendar.date(
            byAdding: .day,
            value: interval - 1,
            to: firstDate
        )
    }

    // MARK: - Watering Interval

    private func wateringInterval(for wateringDays: String) -> Int {

        switch wateringDays {
        case "Every day":
            return 1

        case "Every 2 days":
            return 2

        case "Every 3 days":
            return 3

        case "Once a week":
            return 7

        case "Every 10 days":
            return 10

        case "Every 2 weeks":
            return 14

        default:
            return 1
        }
    }

    // MARK: - Notification Identifier

    private func notificationIdentifier(
        for reminder: PlantReminder,
        index: Int
    ) -> String {
        "\(reminder.id.uuidString)_\(index)"
    }

    // MARK: - Cancel Notifications

    func cancelNotification(for reminder: PlantReminder) {

        let identifiers = (0..<numberOfNotifications).map {
            notificationIdentifier(
                for: reminder,
                index: $0
            )
        }

        notificationCenter.removePendingNotificationRequests(
            withIdentifiers: identifiers
        )
    }
}


