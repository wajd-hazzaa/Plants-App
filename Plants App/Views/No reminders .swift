

import SwiftUI

struct NoReminders: View {

    @EnvironmentObject private var viewModel: PlantReminderViewModel

    @State private var showSetReminder = false

    private let greenColor = Color(
        red: 51.0 / 255.0,
        green: 128.0 / 255.0,
        blue: 105.0 / 255.0
    )

    var body: some View {

        Group {
            if viewModel.reminders.isEmpty {
                emptyStateView
            } else {
                TodayReminderView()
            }
        }
        .preferredColorScheme(.dark)
        .sheet(isPresented: $showSetReminder) {
            SetReminderView(
                onSave: { newReminder in
                    viewModel.addReminder(newReminder)
                }
            )
            .presentationDetents([.large])
            .presentationDragIndicator(.hidden)
            .presentationBackground(.black)
        }
    }

    // MARK: - Empty State View

    private var emptyStateView: some View {
        VStack(spacing: 0) {

            headerView

            Spacer()

            emptyMessage

            Spacer()

            addButton
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.ignoresSafeArea())
    }

    // MARK: - Header

    private var headerView: some View {
        VStack(spacing: 20) {

            HStack {
                Text("My Plants 🌱")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundStyle(.white)

                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 30)

            Rectangle()
                .fill(Color.gray.opacity(0.5))
                .frame(height: 1)
                .padding(.horizontal, 24)
        }
    }

    // MARK: - Empty Message

    private var emptyMessage: some View {
        Text("No reminders set yet..")
            .font(.system(size: 14))
            .foregroundStyle(.white)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 35)
    }

    // MARK: - Add Button

    private var addButton: some View {
        HStack {
            Spacer()

            Button {
                showSetReminder = true
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 50, height: 50)
                    .glassEffect(
                        .regular.tint(greenColor),
                        in: Circle()
                    )
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 25)
        .padding(.bottom, 25)
    }
}

#Preview {
    NoReminders()
        .environmentObject(PlantReminderViewModel())
}
