
import SwiftUI

struct PlantReminder: Identifiable {

    let id = UUID()

    var plantName: String
    var room: String
    var light: String
    var wateringDays: String
    var water: String

    var isCompleted: Bool
}

