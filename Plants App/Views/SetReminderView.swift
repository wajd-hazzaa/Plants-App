
import SwiftUI

struct SetReminderView: View {

    @Environment(\.dismiss) private var dismiss

    // MARK: - Properties

    let reminder: PlantReminder?
    let onSave: (PlantReminder) -> Void
    let onDelete: () -> Void

    // MARK: - Form State

    @State private var plantName: String
    @State private var room: String
    @State private var light: String
    @State private var wateringDays: String
    @State private var water: String

    // MARK: - Initializer

    init(
        reminder: PlantReminder? = nil,
        onSave: @escaping (PlantReminder) -> Void,
        onDelete: @escaping () -> Void = {}
    ) {
        self.reminder = reminder
        self.onSave = onSave
        self.onDelete = onDelete

        _plantName = State(initialValue: reminder?.plantName ?? "")
        _room = State(initialValue: reminder?.room ?? "Bedroom")
        _light = State(initialValue: reminder?.light ?? "Full Sun")
        _wateringDays = State(initialValue: reminder?.wateringDays ?? "Every day")
        _water = State(initialValue: reminder?.water ?? "20-50 ml")
    }

    // MARK: - Colors

    private let backgroundColor = Color.black

    private let panelColor = Color(
        red: 28 / 255.0,
        green: 28 / 255.0,
        blue: 30 / 255.0
    )

    private let cardColor = Color(
        red: 58 / 255.0,
        green: 58 / 255.0,
        blue: 60 / 255.0
    )

    private let fieldColor = Color(
        red: 67 / 255.0,
        green: 67 / 255.0,
        blue: 69 / 255.0
    )

    private let greenColor = Color(
        red: 51 / 255.0,
        green: 128 / 255.0,
        blue: 105 / 255.0
    )

    // MARK: - Body

    var body: some View {

        ZStack {

            backgroundColor
                .ignoresSafeArea()

            formContent
                .padding(.horizontal, 24)
                .padding(.top, 35)
                .padding(.bottom, 20)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background {
                    panelBackground
                }
                .padding(.top, 25)
        }
        .preferredColorScheme(.dark)
    }

    // MARK: - Form Content

    private var formContent: some View {

        VStack(spacing: 0) {

            headerView
            plantNameField
            locationSection
            wateringSection

            if reminder != nil {
                deleteButton
            }

            Spacer()
        }
    }

    // MARK: - Header

    private var headerView: some View {

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

            // Save Button - Liquid Glass

            Button {
                saveReminder()
            } label: {
                Image(systemName: "checkmark")
                    .font(.system(size: 19, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 50, height: 50)
                    .glassEffect(
                        .regular.tint(
                            isPlantNameValid ? greenColor : .gray
                        ),
                        in: Circle()
                    )
            }
            .buttonStyle(.plain)
            .disabled(!isPlantNameValid)
        }
        .padding(.bottom, 35)
    }

    // MARK: - Plant Name Validation

    private var isPlantNameValid: Bool {
        !plantName.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty
    }

    // MARK: - Plant Name Field

    private var plantNameField: some View {

        TextField("Plant Name", text: $plantName)
            .font(.system(size: 15))
            .foregroundStyle(.white)
            .tint(greenColor)
            .padding(.horizontal, 18)
            .frame(height: 58)
            .background(fieldColor)
            .clipShape(Capsule())
    }

    // MARK: - Location Section

    private var locationSection: some View {

        VStack(spacing: 0) {

            HStack {

                Image(systemName: "location.north")

                Text("Room")
                    .fontWeight(.semibold)

                Spacer()

                Menu {
                    ForEach(
                        ["Bedroom", "Living Room", "Kitchen", "Balcony", "Bathroom"],
                        id: \.self
                    ) { option in
                        Button(option) {
                            room = option
                        }
                    }
                } label: {
                    menuLabel(room)
                }
            }
            .padding(.vertical, 13)

            sectionDivider

            HStack {

                Image(systemName: "sun.max")

                Text("Light")
                    .fontWeight(.semibold)

                Spacer()

                Menu {
                    ForEach(
                        ["Full Sun", "Partial Sun", "Low Light"],
                        id: \.self
                    ) { option in
                        Button(option) {
                            light = option
                        }
                    }
                } label: {
                    menuLabel(light)
                }
            }
            .padding(.vertical, 13)
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 15)
        .background(cardColor)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .padding(.top, 45)
    }

    // MARK: - Watering Section

    private var wateringSection: some View {

        VStack(spacing: 0) {

            HStack {

                Image(systemName: "drop")

                Text("Watering Days")
                    .fontWeight(.semibold)

                Spacer()

                Menu {
                    ForEach(
                        [
                            "Every day",
                            "Every 2 days",
                            "Every 3 days",
                            "Once a week",
                            "Every 10 days",
                            "Every 2 weeks"
                        ],
                        id: \.self
                    ) { option in
                        Button(option) {
                            wateringDays = option
                        }
                    }
                } label: {
                    menuLabel(wateringDays)
                }
            }
            .padding(.vertical, 13)

            sectionDivider

            HStack {

                Image(systemName: "drop")

                Text("Water")
                    .fontWeight(.semibold)

                Spacer()

                Menu {
                    ForEach(
                        [
                            "20-50 ml",
                            "50-100 ml",
                            "100-200 ml",
                            "200-300 ml"
                        ],
                        id: \.self
                    ) { option in
                        Button(option) {
                            water = option
                        }
                    }
                } label: {
                    menuLabel(water)
                }
            }
            .padding(.vertical, 13)
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 15)
        .background(cardColor)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .padding(.top, 35)
    }

    // MARK: - Menu Label

    private func menuLabel(_ title: String) -> some View {

        HStack {

            Text(title)

            Image(systemName: "chevron.up.chevron.down")
                .font(.system(size: 11))
        }
        .foregroundStyle(.white)
    }

    // MARK: - Divider

    private var sectionDivider: some View {

        Divider()
            .overlay(Color.white.opacity(0.2))
    }

    // MARK: - Delete Button

    private var deleteButton: some View {

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

    // MARK: - Panel Background

    private var panelBackground: some View {

        UnevenRoundedRectangle(
            topLeadingRadius: 35,
            bottomLeadingRadius: 0,
            bottomTrailingRadius: 0,
            topTrailingRadius: 35
        )
        .fill(panelColor)
        .ignoresSafeArea(edges: [.bottom, .horizontal])
    }

    // MARK: - Save Reminder

    private func saveReminder() {

        guard isPlantNameValid else {
            return
        }

        let newReminder = PlantReminder(
            id: reminder?.id ?? UUID(),
            plantName: plantName.trimmingCharacters(
                in: .whitespacesAndNewlines
            ),
            room: room,
            light: light,
            wateringDays: wateringDays,
            water: water,
            isCompleted: reminder?.isCompleted ?? false
        )

        onSave(newReminder)
        dismiss()
    }
}

#Preview {
    SetReminderView(
        onSave: { _ in },
        onDelete: {}
    )
}

