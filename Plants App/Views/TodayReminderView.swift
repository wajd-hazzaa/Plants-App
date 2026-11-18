

import SwiftUI

struct TodayReminderView: View {

    @EnvironmentObject private var viewModel: PlantReminderViewModel

    @State private var showEditor = false
    @State private var selectedReminder: PlantReminder?

    // MARK: - Colors

    private let greenColor = Color(
        red: 51 / 255.0,
        green: 128 / 255.0,
        blue: 105 / 255.0
    )

    private let yellowColor = Color(
        red: 204 / 255.0,
        green: 199 / 255.0,
        blue: 133 / 255.0
    )

    private let blueColor = Color(
        red: 202 / 255.0,
        green: 243 / 255.0,
        blue: 251 / 255.0
    )

    private let detailBackground = Color(
        red: 35 / 255.0,
        green: 35 / 255.0,
        blue: 37 / 255.0
    )

    // MARK: - Body

    var body: some View {

        Group {
            if viewModel.allCompleted {

                AllDone {
                    openEditor(for: nil)
                }

            } else {

                reminderListView
            }
        }
        .preferredColorScheme(.dark)
        .sheet(isPresented: $showEditor, onDismiss: {
            selectedReminder = nil
        }) {
            reminderEditor
        }
    }

    // MARK: - Main View

    private var reminderListView: some View {

        ZStack(alignment: .bottomTrailing) {

            Color.black
                .ignoresSafeArea()

            VStack(spacing: 0) {

                headerView

                progressSection

                plantsList
            }

            addButton
        }
    }

    // MARK: - Header

    private var headerView: some View {

        VStack(spacing: 15) {

            HStack {
                Text("My Plants 🌱")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundStyle(.white)

                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 25)

            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 1)
        }
    }

    // MARK: - Progress Section

    private var progressSection: some View {

        VStack(spacing: 14) {

            Text(
                "\(viewModel.completedCount) of your plants feel loved today✨"
            )
            .font(.system(size: 17, weight: .semibold))
            .foregroundStyle(.white)

            ProgressView(value: viewModel.progress)
                .tint(greenColor)
                .scaleEffect(x: 1, y: 1.8, anchor: .center)
        }
        .padding(.horizontal, 24)
        .padding(.top, 30)
        .padding(.bottom, 25)
    }

    // MARK: - Plants List

    private var plantsList: some View {

        List {

            ForEach(viewModel.reminders) { reminder in

                plantRow(reminder)
                    .listRowBackground(Color.black)
                    .listRowInsets(
                        EdgeInsets(
                            top: 0,
                            leading: 0,
                            bottom: 0,
                            trailing: 0
                        )
                    )
                    .listRowSeparator(.hidden)
                    .swipeActions(
                        edge: .trailing,
                        allowsFullSwipe: false
                    ) {
                        deleteButton(for: reminder)
                    }
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }

    // MARK: - Plant Row

    private func plantRow(_ reminder: PlantReminder) -> some View {

        VStack(spacing: 0) {

            HStack(spacing: 14) {

                completionButton(for: reminder)

                plantInformation(reminder)

                Spacer(minLength: 0)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 13)
            .contentShape(Rectangle())
            .onTapGesture {
                openEditor(for: reminder)
            }

            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 1)
                .padding(.horizontal, 10)
        }
    }

    // MARK: - Completion Button

    private func completionButton(
        for reminder: PlantReminder
    ) -> some View {

        Button {
            viewModel.toggleReminder(reminder)
        } label: {

            Image(
                systemName: reminder.isCompleted
                ? "checkmark.circle.fill"
                : "circle"
            )
            .font(.system(size: 25))
            .foregroundStyle(
                reminder.isCompleted ? greenColor : .white
            )
        }
        .buttonStyle(.plain)
    }

    // MARK: - Plant Information

    private func plantInformation(
        _ reminder: PlantReminder
    ) -> some View {

        VStack(alignment: .leading, spacing: 7) {

            Text("➤ in \(reminder.room)")
                .font(.system(size: 13))
                .foregroundStyle(
                    reminder.isCompleted
                    ? .gray.opacity(0.5)
                    : .gray
                )

            Text(reminder.plantName)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(
                    reminder.isCompleted
                    ? .white.opacity(0.45)
                    : .white
                )

            plantDetails(reminder)
                .opacity(reminder.isCompleted ? 0.45 : 1.0)
        }
    }

    // MARK: - Plant Details

    private func plantDetails(
        _ reminder: PlantReminder
    ) -> some View {

        HStack(spacing: 8) {

            // Light

            HStack(spacing: 5) {

                Image(systemName: "sun.max")
                    .foregroundStyle(yellowColor)

                Text(reminder.light)
                    .foregroundStyle(.white)
            }
            .padding(.horizontal, 9)
            .padding(.vertical, 4)
            .background(detailBackground)
            .clipShape(RoundedRectangle(cornerRadius: 9))

            // Water

            HStack(spacing: 5) {

                Image(systemName: "drop")
                    .foregroundStyle(blueColor)

                Text(reminder.water)
                    .foregroundStyle(.white)
            }
            .padding(.horizontal, 9)
            .padding(.vertical, 4)
            .background(detailBackground)
            .clipShape(RoundedRectangle(cornerRadius: 9))
        }
        .font(.system(size: 12, weight: .medium))
    }

    // MARK: - Delete Button

    private func deleteButton(
        for reminder: PlantReminder
    ) -> some View {

        Button(role: .destructive) {
            viewModel.deleteReminder(reminder)
        } label: {
            Image(systemName: "trash")
        }
        .tint(.red)
    }

    // MARK: - Add Button

    private var addButton: some View {

        Button {
            openEditor(for: nil)
        } label: {

            Image(systemName: "plus")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 54, height: 54)
                .glassEffect(
                    .regular.tint(greenColor),
                    in: Circle()
                )
        }
        .buttonStyle(.plain)
        .padding(.trailing, 28)
        .padding(.bottom, 25)
    }

    // MARK: - Open Editor

    private func openEditor(for reminder: PlantReminder) {
        selectedReminder = reminder
        showEditor = true
    }

    private func openEditor(for reminder: Optional<PlantReminder>) {
        selectedReminder = reminder
        showEditor = true
    }

    // MARK: - Reminder Editor

    private var reminderEditor: some View {

        SetReminderView(
            reminder: selectedReminder,

            onSave: { updatedReminder in

                if selectedReminder != nil {
                    viewModel.updateReminder(updatedReminder)
                } else {
                    viewModel.addReminder(updatedReminder)
                }
            },

            onDelete: {

                if let selected = selectedReminder {
                    viewModel.deleteReminder(selected)
                }
            }
        )
        .presentationDetents([.large])
        .presentationDragIndicator(.hidden)
        .presentationBackground(.black)
    }
}

// MARK: - Preview

#Preview {
    TodayReminderView()
        .environmentObject(PlantReminderViewModel())
}
