
import SwiftUI

@main
struct MyApp: App {

    // MARK: - Shared ViewModel

    @StateObject private var reminderViewModel =
        PlantReminderViewModel()

    // MARK: - App Life Cycle

    var body: some Scene {

        WindowGroup {

            ContentView()
                .environmentObject(reminderViewModel)
                .task {
                    NotificationManager.shared.requestPermission()
                }
        }
    }
}

