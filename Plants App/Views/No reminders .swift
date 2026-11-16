
import SwiftUI

struct NoReminders: View {

    @State private var showSetReminder = false

    // Green Color
    let greenColor = Color(
        red: 51.0 / 255.0,
        green: 128.0 / 255.0,
        blue: 105.0 / 255.0
    )

    var body: some View {

        VStack(spacing: 0) {

            // Header
            HStack {
                Text("My Plants 🌱")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundStyle(.white)

                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 30)

            // Divider Line
            Rectangle()
                .fill(Color.gray.opacity(0.5))
                .frame(height: 1)
                .padding(.horizontal, 24)
                .padding(.top, 20)

            Spacer()

            // Description
            Text("No reminders set yet..")
                .font(.system(size: 14))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 35)
                .padding(.top, 12)

            Spacer()

            // Add Button
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
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.ignoresSafeArea())
        .preferredColorScheme(.dark)

        // Open Set Reminder
        .sheet(isPresented: $showSetReminder) {
            SetReminderView { _ in
                // Save action will be connected later
            }
            .presentationDetents([.large])
            .presentationDragIndicator(.hidden)
            .presentationBackground(.black)
        }
    }
}

#Preview {
    NoReminders()
        .preferredColorScheme(.dark)
}

