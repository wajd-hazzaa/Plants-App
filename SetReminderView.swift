
import SwiftUI

struct SetReminderView: View {

    @Environment(\.dismiss) var dismiss

    // State Variables
    @State private var plantName = ""
    @State private var room = "Bedroom"
    @State private var light = "Full Sun"
    @State private var wateringDays = "Every day"
    @State private var water = "20-50 ml"

    // Colors
    let greenColor = Color(
        red: 51/255,
        green: 128/255,
        blue: 105/255
    )

    let cardColor = Color(
        red: 0.16,
        green: 0.16,
        blue: 0.16
    )

    let fieldColor = Color(
        red: 0.30,
        green: 0.30,
        blue: 0.30
    )

    // Options
    let rooms = [
        "Bedroom",
        "Living Room",
        "Kitchen",
        "Balcony",
        "Bathroom"
    ]

    let lights = [
        "Full Sun",
        "Partial Sun",
        "Low Light"
    ]

    let days = [
        "Every day",
        "Every 2 days",
        "Every 3 days",
        "Once a week",
        "Every 10 days",
        "Every 2 weeks"
    ]

    let waterAmounts = [
        "20-50 ml",
        "50-100 ml",
        "100-200 ml",
        "200-300 ml"
    ]

    var body: some View {

        ZStack {

            // Background
            Color.black
                .ignoresSafeArea()

            // Main Card
            VStack(spacing: 0) {

                // Header
                HStack {

                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.white)
                            .font(.system(size: 22))
                            .frame(width: 50, height: 50)
                            .background(fieldColor)
                            .clipShape(Circle())
                    }

                    Spacer()

                    Text("Set Reminder")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.white)

                    Spacer()

                    Button {
                        print("Reminder Saved")
                    } label: {
                        Image(systemName: "checkmark")
                            .foregroundStyle(.white)
                            .font(.system(size: 22))
                            .frame(width: 50, height: 50)
                            .background(greenColor)
                            .clipShape(Circle())
                    }
                }
                .padding(.bottom, 55)

                // Plant Name
                HStack {

                    Text("Plant Name")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.white)

                    TextField("Pothos", text: $plantName)
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 20)
                .frame(height: 65)
                .background(fieldColor)
                .clipShape(Capsule())

                .padding(.bottom, 55)

                // Room and Light
                VStack(spacing: 0) {

                    // Room
                    HStack {

                        Label("Room", systemImage: "location.north")

                        Spacer()

                        Picker("Room", selection: $room) {
                            ForEach(rooms, id: \.self) { item in
                                Text(item).tag(item)
                            }
                        }
                        .tint(.white)
                    }
                    .padding(.vertical, 12)

                    Divider()
                        .overlay(Color.white.opacity(0.2))

                    // Light
                    HStack {

                        Label("Light", systemImage: "sun.max")

                        Spacer()

                        Picker("Light", selection: $light) {
                            ForEach(lights, id: \.self) { item in
                                Text(item).tag(item)
                            }
                        }
                        .tint(.white)
                    }
                    .padding(.vertical, 12)
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 18)
                .background(fieldColor)
                .clipShape(RoundedRectangle(cornerRadius: 30))

                .padding(.bottom, 40)

                // Watering Days and Water
                VStack(spacing: 0) {

                    // Watering Days
                    HStack {

                        Label("Watering Days", systemImage: "drop")

                        Spacer()

                        Picker("Watering Days", selection: $wateringDays) {
                            ForEach(days, id: \.self) { item in
                                Text(item).tag(item)
                            }
                        }
                        .tint(.white)
                    }
                    .padding(.vertical, 12)

                    Divider()
                        .overlay(Color.white.opacity(0.2))

                    // Water
                    HStack {

                        Label("Water", systemImage: "drop")

                        Spacer()

                        Picker("Water", selection: $water) {
                            ForEach(waterAmounts, id: \.self) { item in
                                Text(item).tag(item)
                            }
                        }
                        .tint(.white)
                    }
                    .padding(.vertical, 12)
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 18)
                .background(fieldColor)
                .clipShape(RoundedRectangle(cornerRadius: 30))

                Spacer()
            }

            .padding(35)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(cardColor)
            .clipShape(RoundedRectangle(cornerRadius: 50))
            .padding(16)
        }

        .preferredColorScheme(.dark)
    }
}

#Preview {
    SetReminderView()
}
