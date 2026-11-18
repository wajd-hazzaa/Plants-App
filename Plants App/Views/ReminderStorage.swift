

import Foundation

final class ReminderStorage {

    private let remindersKey = "SavedPlantReminders"

    // Save Reminders
    func save(_ reminders: [PlantReminder]) {
        do {
            let encodedData = try JSONEncoder().encode(reminders)

            UserDefaults.standard.set(
                encodedData,
                forKey: remindersKey
            )

        } catch {
            print("Error saving reminders: \(error)")
        }
    }

    // Load Reminders
    func load() -> [PlantReminder] {
        guard let savedData = UserDefaults.standard.data(
            forKey: remindersKey
        ) else {
            return []
        }

        do {
            return try JSONDecoder().decode(
                [PlantReminder].self,
                from: savedData
            )

        } catch {
            print("Error loading reminders: \(error)")
            return []
        }
    }
}
