

import Foundation

struct PlantReminder: Identifiable, Codable {

    let id: UUID

    var plantName: String
    var room: String
    var light: String
    var wateringDays: String
    var water: String
    var isCompleted: Bool

    init(
        id: UUID = UUID(),
        plantName: String,
        room: String,
        light: String,
        wateringDays: String,
        water: String,
        isCompleted: Bool = false
    ) {
        self.id = id
        self.plantName = plantName
        self.room = room
        self.light = light
        self.wateringDays = wateringDays
        self.water = water
        self.isCompleted = isCompleted
    }
}



