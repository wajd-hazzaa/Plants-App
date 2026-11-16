//
//  TodayReminderView.swift
//  Plants App
//
//  Created by wajd on 05/06/1448 AH.
//


import SwiftUI

struct TodayReminderView: View {

    // Sample Plants
    @State private var reminders = [
        PlantReminder(
            plantName: "Monstera",
            room: "Kitchen",
            light: "Full Sun",
            wateringDays: "Every day",
            water: "20-50 ml",
            isCompleted: false
        ),

        PlantReminder(
            plantName: "Pothos",
            room: "Bedroom",
            light: "Full Sun",
            wateringDays: "Every 2 days",
            water: "20-50 ml",
            isCompleted: false
        ),

        PlantReminder(
            plantName: "Orchid",
            room: "Living Room",
            light: "Partial Sun",
            wateringDays: "Every 3 days",
            water: "50-100 ml",
            isCompleted: false
        ),

        PlantReminder(
            plantName: "Spider",
            room: "Kitchen",
            light: "Low Light",
            wateringDays: "Once a week",
            water: "20-50 ml",
            isCompleted: false
        )
    ]

    @State private var showEditor = false
    @State private var selectedReminder: PlantReminder?

    // App Colors
    let greenColor = Color(
        red: 51/255.0,
        green: 128/255.0,
        blue: 105/255.0
    )

    let yellowColor = Color(
        red: 204/255.0,
        green: 199/255.0,
        blue: 133/255.0
    )

    let blueColor = Color(
        red: 202/255.0,
        green: 243/255.0,
        blue: 251/255.0
    )

    // Completed Plants
    var completedCount: Int {
        reminders.filter { $0.isCompleted }.count
    }

    // Check if all plants are completed
    var allCompleted: Bool {
        !reminders.isEmpty && completedCount == reminders.count
    }

    // Progress
    var progress: Double {
        if reminders.isEmpty {
            return 0
        }

        return Double(completedCount) / Double(reminders.count)
    }

    var body: some View {

        Group {

            // Show All Done Page
            if allCompleted {

                AllDone {
                    selectedReminder = nil
                    showEditor = true
                }

            } else {

                // Today Reminder Page
                ZStack(alignment: .bottomTrailing) {

                    // Background
                    Color.black
                        .ignoresSafeArea()

                    VStack(spacing: 0) {

                        // Header
                        HStack {
                            Text("My Plants 🌱")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundStyle(.white)

                            Spacer()
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 25)

                        // Divider
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 1)
                            .padding(.top, 15)

                        // Progress Section
                        VStack(spacing: 12) {

                            Text(
                                "\(completedCount) of your plants feel loved today✨"
                            )
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(.white)

                            ProgressView(value: progress)
                                .tint(greenColor)
                                .scaleEffect(
                                    x: 1,
                                    y: 1.5,
                                    anchor: .center
                                )
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 25)
                        .padding(.bottom, 30)

                        // Plants List
                        List {

                            ForEach(reminders) { reminder in

                                HStack(spacing: 12) {

                                    // Check Button
                                    Button {
                                        toggleReminder(reminder)
                                    } label: {

                                        Image(
                                            systemName: reminder.isCompleted
                                            ? "checkmark.circle.fill"
                                            : "circle"
                                        )
                                        .font(.system(size: 23))
                                        .foregroundStyle(
                                            reminder.isCompleted
                                            ? greenColor
                                            : .white
                                        )
                                    }
                                    .buttonStyle(.plain)

                                    // Plant Information
                                    VStack(alignment: .leading, spacing: 5) {

                                        Text("➤ in \(reminder.room)")
                                            .font(.system(size: 11))
                                            .foregroundStyle(.gray)

                                        Text(reminder.plantName)
                                            .font(.system(size: 17, weight: .semibold))
                                            .foregroundStyle(.white)
                                            .strikethrough(reminder.isCompleted)

                                        // Plant Details
                                        HStack(spacing: 8) {

                                            HStack(spacing: 3) {
                                                Image(systemName: "sun.max.fill")
                                                    .foregroundStyle(yellowColor)

                                                Text(reminder.light)
                                                    .foregroundStyle(.white)
                                            }

                                            HStack(spacing: 3) {
                                                Image(systemName: "drop.fill")
                                                    .foregroundStyle(blueColor)

                                                Text(reminder.water)
                                                    .foregroundStyle(.white)
                                            }
                                        }
                                        .font(.system(size: 10, weight: .medium))
                                    }

                                    Spacer()
                                }
                                .padding(.vertical, 8)
                                .contentShape(Rectangle())

                                // Open Edit Reminder
                                .onTapGesture {
                                    selectedReminder = reminder
                                    showEditor = true
                                }

                                .listRowBackground(Color.black)
                                .listRowSeparatorTint(
                                    Color.gray.opacity(0.3)
                                )

                                // Swipe to Delete
                                .swipeActions(
                                    edge: .trailing,
                                    allowsFullSwipe: false
                                ) {

                                    Button(role: .destructive) {
                                        deleteReminder(reminder)
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                    .tint(.red)
                                }
                            }
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)

                        Spacer(minLength: 0)
                    }

                    // Add Button
                    Button {
                        selectedReminder = nil
                        showEditor = true
                    } label: {

                        Image(systemName: "plus")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(.white)
                            .frame(width: 48, height: 48)
                            .glassEffect(
                                .regular.tint(greenColor),
                                in: Circle()
                            )
                    }
                    .buttonStyle(.plain)
                    .padding(.trailing, 28)
                    .padding(.bottom, 25)
                }
            }
        }
        .preferredColorScheme(.dark)

        // Add or Edit Reminder
        .sheet(isPresented: $showEditor, onDismiss: {
            selectedReminder = nil
        }) {

            SetReminderView(
                reminder: selectedReminder,

                onSave: { updatedReminder in

                    if let selected = selectedReminder,
                       let index = reminders.firstIndex(
                            where: { $0.id == selected.id }
                       ) {

                        // Update Existing Plant
                        reminders[index] = PlantReminder(
                            plantName: updatedReminder.plantName,
                            room: updatedReminder.room,
                            light: updatedReminder.light,
                            wateringDays: updatedReminder.wateringDays,
                            water: updatedReminder.water,
                            isCompleted: selected.isCompleted
                        )

                    } else {

                        // Add New Plant
                        reminders.append(updatedReminder)
                    }
                },

                onDelete: {

                    if let selected = selectedReminder {
                        deleteReminder(selected)
                    }
                }
            )
            .presentationDetents([.large])
            .presentationDragIndicator(.hidden)
            .presentationBackground(.black)
        }
    }

    // Check / Uncheck
    func toggleReminder(_ reminder: PlantReminder) {

        if let index = reminders.firstIndex(
            where: { $0.id == reminder.id }
        ) {
            reminders[index].isCompleted.toggle()
        }
    }

    // Delete Reminder
    func deleteReminder(_ reminder: PlantReminder) {

        reminders.removeAll {
            $0.id == reminder.id
        }
    }
}

#Preview {
    TodayReminderView()
}
