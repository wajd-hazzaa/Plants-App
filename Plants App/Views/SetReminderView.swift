

import SwiftUI

struct SetReminderView: View {

    @Environment(\.dismiss) private var dismiss

    // Existing Plant (if editing)
    var reminder: PlantReminder?

    // Actions
    var onSave: (PlantReminder) -> Void
    var onDelete: () -> Void

    // Plant Information
    @State private var plantName: String
    @State private var room: String
    @State private var light: String
    @State private var wateringDays: String
    @State private var water: String

    // Initialize the form
    init(
        reminder: PlantReminder? = nil,
        onSave: @escaping (PlantReminder) -> Void,
        onDelete: @escaping () -> Void = {}
    ) {

        self.reminder = reminder
        self.onSave = onSave
        self.onDelete = onDelete

        _plantName = State(initialValue: reminder?.plantName ?? "Pothos")
        _room = State(initialValue: reminder?.room ?? "Bedroom")
        _light = State(initialValue: reminder?.light ?? "Full Sun")
        _wateringDays = State(initialValue: reminder?.wateringDays ?? "Every day")
        _water = State(initialValue: reminder?.water ?? "20-50 ml")
    }

    // App Colors
    let backgroundColor = Color.black

    let panelColor = Color(
        red: 28/255.0,
        green: 28/255.0,
        blue: 30/255.0
    )

    let cardColor = Color(
        red: 58/255.0,
        green: 58/255.0,
        blue: 60/255.0
    )

    let fieldColor = Color(
        red: 67/255.0,
        green: 67/255.0,
        blue: 69/255.0
    )

    // Green #338069
    let greenColor = Color(
        red: 51/255.0,
        green: 128/255.0,
        blue: 105/255.0
    )

    var body: some View {

        ZStack {

            // App Background
            backgroundColor
                .ignoresSafeArea()

            // Main Panel
            VStack(spacing: 0) {

                // Header
                HStack {

                    // Close Button
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.white)
                            .frame(width: 46, height: 46)
                            .glassEffect(
                                .regular.tint(.gray),
                                in: Circle()
                            )
                    }
                    .buttonStyle(.plain)

                    Spacer()

                    Text(reminder == nil ? "Set Reminder" : "Edit Reminder")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.white)

                    Spacer()

                    // Confirm Button
                    Button {

                        let updatedReminder = PlantReminder(
                            plantName: plantName,
                            room: room,
                            light: light,
                            wateringDays: wateringDays,
                            water: water,
                            isCompleted: reminder?.isCompleted ?? false
                        )

                        onSave(updatedReminder)
                        dismiss()

                    } label: {
                        Image(systemName: "checkmark")
                            .font(.system(size: 19, weight: .semibold))
                            .foregroundStyle(.white)
                            .frame(width: 50, height: 50)
                            .glassEffect(
                                .regular.tint(greenColor),
                                in: Circle()
                            )
                    }
                    .buttonStyle(.plain)
                }
                .padding(.bottom, 35)

                // Plant Name
                HStack {

                    Text("Plant Name")
                        .font(.system(size: 15, weight: .semibold))

                    Rectangle()
                        .fill(greenColor)
                        .frame(width: 2, height: 22)

                    TextField("Plant name", text: $plantName)
                        .font(.system(size: 15))
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 18)
                .frame(height: 58)
                .background(fieldColor)
                .clipShape(Capsule())

                // Room and Light
                VStack(spacing: 0) {

                    // Room
                    HStack {

                        Image(systemName: "location.north")

                        Text("Room")
                            .fontWeight(.semibold)

                        Spacer()

                        Menu {
                            Button("Bedroom") {
                                room = "Bedroom"
                            }

                            Button("Living Room") {
                                room = "Living Room"
                            }

                            Button("Kitchen") {
                                room = "Kitchen"
                            }

                            Button("Balcony") {
                                room = "Balcony"
                            }

                            Button("Bathroom") {
                                room = "Bathroom"
                            }

                        } label: {
                            HStack {
                                Text(room)

                                Image(systemName: "chevron.up.chevron.down")
                                    .font(.system(size: 11))
                            }
                            .foregroundStyle(.white)
                        }
                    }
                    .padding(.vertical, 13)

                    Divider()
                        .overlay(Color.white.opacity(0.2))

                    // Light
                    HStack {

                        Image(systemName: "sun.max")

                        Text("Light")
                            .fontWeight(.semibold)

                        Spacer()

                        Menu {
                            Button("Full Sun") {
                                light = "Full Sun"
                            }

                            Button("Partial Sun") {
                                light = "Partial Sun"
                            }

                            Button("Low Light") {
                                light = "Low Light"
                            }

                        } label: {
                            HStack {
                                Text(light)

                                Image(systemName: "chevron.up.chevron.down")
                                    .font(.system(size: 11))
                            }
                            .foregroundStyle(.white)
                        }
                    }
                    .padding(.vertical, 13)
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 15)
                .background(cardColor)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .padding(.top, 45)

                // Watering Information
                VStack(spacing: 0) {

                    // Watering Days
                    HStack {

                        Image(systemName: "drop")

                        Text("Watering Days")
                            .fontWeight(.semibold)

                        Spacer()

                        Menu {
                            Button("Every day") {
                                wateringDays = "Every day"
                            }

                            Button("Every 2 days") {
                                wateringDays = "Every 2 days"
                            }

                            Button("Every 3 days") {
                                wateringDays = "Every 3 days"
                            }

                            Button("Once a week") {
                                wateringDays = "Once a week"
                            }

                            Button("Every 10 days") {
                                wateringDays = "Every 10 days"
                            }

                            Button("Every 2 weeks") {
                                wateringDays = "Every 2 weeks"
                            }

                        } label: {
                            HStack {
                                Text(wateringDays)

                                Image(systemName: "chevron.up.chevron.down")
                                    .font(.system(size: 11))
                            }
                            .foregroundStyle(.white)
                        }
                    }
                    .padding(.vertical, 13)

                    Divider()
                        .overlay(Color.white.opacity(0.2))

                    // Water Amount
                    HStack {

                        Image(systemName: "drop")

                        Text("Water")
                            .fontWeight(.semibold)

                        Spacer()

                        Menu {
                            Button("20-50 ml") {
                                water = "20-50 ml"
                            }

                            Button("50-100 ml") {
                                water = "50-100 ml"
                            }

                            Button("100-200 ml") {
                                water = "100-200 ml"
                            }

                            Button("200-300 ml") {
                                water = "200-300 ml"
                            }

                        } label: {
                            HStack {
                                Text(water)

                                Image(systemName: "chevron.up.chevron.down")
                                    .font(.system(size: 11))
                            }
                            .foregroundStyle(.white)
                        }
                    }
                    .padding(.vertical, 13)
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 15)
                .background(cardColor)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .padding(.top, 35)

                // Delete Button (Edit Mode Only)
                if reminder != nil {

                    Button(role: .destructive) {

                        onDelete()
                        dismiss()

                    } label: {

                        Text("Delete Reminder")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(.red)
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                            .background(cardColor)
                            .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)
                    .padding(.top, 45)
                }

                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 35)
            .padding(.bottom, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Main Panel Background
            .background {
                UnevenRoundedRectangle(
                    topLeadingRadius: 35,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 35
                )
                .fill(panelColor)
                .ignoresSafeArea(edges: [.bottom, .horizontal])
            }
            .padding(.top, 25)
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    SetReminderView(
        onSave: { _ in },
        onDelete: {}
    )
}
