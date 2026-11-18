import SwiftUI

struct ContentView: View {

    @State private var showNoReminders = false

    private let greenColor = Color(
        red: 51.0 / 255.0,
        green: 128.0 / 255.0,
        blue: 105.0 / 255.0
    )

    var body: some View {

        VStack(spacing: 0) {

            headerView

            Spacer()

            welcomeView

            Spacer()

            startButton
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.ignoresSafeArea())
        .preferredColorScheme(.dark)
        .sheet(isPresented: $showNoReminders) {
            NoReminders()
        }
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

    // MARK: - Welcome View

    private var welcomeView: some View {
        VStack(spacing: 0) {

            Image("plant")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)

            Text("Start your plant journey!")
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(.white)
                .padding(.top, 20)

            Text("Now all your plants will be in one place and we will help you take care of them :) 🪴")
                .font(.system(size: 14))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 35)
                .padding(.top, 12)
        }
    }

    // MARK: - Start Button

    private var startButton: some View {
        Button {
            showNoReminders = true
        } label: {
            Text("Set Plant Reminder")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .glassEffect(
                    .regular.tint(greenColor),
                    in: Capsule()
                )
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 65)
        .padding(.bottom, 90)
    }
}

#Preview {
    ContentView()
        .environmentObject(PlantReminderViewModel())
        .preferredColorScheme(.dark)
}
