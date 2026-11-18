import Foundation
import Combine

final class PlantReminderViewModel: ObservableObject {

    @Published private(set) var reminders: [PlantReminder] = []

    private let storage = ReminderStorage()
    private let notificationManager = NotificationManager.shared

    init() {
        reminders = storage.load()
        scheduleNotifications()
    }

    // MARK: - Add Reminder

    func addReminder(_ reminder: PlantReminder) {
        reminders.append(reminder)

        if !reminder.isCompleted {
            notificationManager.scheduleNotification(for: reminder)
        }

        saveReminders()
    }

    // MARK: - Update Reminder

    func updateReminder(_ reminder: PlantReminder) {
        guard let index = reminders.firstIndex(
            where: { $0.id == reminder.id }
        ) else {
            return
        }

        notificationManager.cancelNotification(for: reminders[index])

        reminders[index] = reminder

        if !reminder.isCompleted {
            notificationManager.scheduleNotification(for: reminder)
        }

        saveReminders()
    }

    // MARK: - Delete Reminder

    func deleteReminder(_ reminder: PlantReminder) {
        notificationManager.cancelNotification(for: reminder)

        reminders.removeAll {
            $0.id == reminder.id
        }

        saveReminders()
    }

    // MARK: - Toggle Reminder

    func toggleReminder(_ reminder: PlantReminder) {
        guard let index = reminders.firstIndex(
            where: { $0.id == reminder.id }
        ) else {
            return
        }

        reminders[index].isCompleted.toggle()

        if reminders[index].isCompleted {
            notificationManager.cancelNotification(for: reminders[index])
        } else {
            notificationManager.scheduleNotification(for: reminders[index])
        }

        saveReminders()
    }

    // MARK: - Save Reminders

    private func saveReminders() {
        storage.save(reminders)
    }

    // MARK: - Schedule Notifications

    private func scheduleNotifications() {
        for reminder in reminders where !reminder.isCompleted {
            notificationManager.scheduleNotification(for: reminder)
        }
    }

    // MARK: - Completed Count

    var completedCount: Int {
        reminders.filter { $0.isCompleted }.count
    }

    // MARK: - Progress

    var progress: Double {
        guard !reminders.isEmpty else {
            return 0
        }

        return Double(completedCount) / Double(reminders.count)
    }

    // MARK: - All Completed

    var allCompleted: Bool {
        !reminders.isEmpty && completedCount == reminders.count
    }
}
