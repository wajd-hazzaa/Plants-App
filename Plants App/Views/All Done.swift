
import SwiftUI

struct AllDone: View {

    // MARK: - Actions

    let onAdd: () -> Void

    // MARK: - Colors

    private let greenColor = Color(
        red: 51 / 255.0,
        green: 128 / 255.0,
        blue: 105 / 255.0
    )

    // MARK: - Body

    var body: some View {

        VStack(spacing: 0) {

            headerView

            Spacer()

            completionMessage

            Spacer()

            addButton
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.ignoresSafeArea())
        .preferredColorScheme(.dark)
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

    // MARK: - Completion Message

    private var completionMessage: some View {

        VStack(spacing: 0) {

            Image("Plant 2")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)

            Text("All Done! 🎉")
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(.white)
                .padding(.top, 20)

            Text("All Reminders Completed")
                .font(.system(size: 14))
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 35)
                .padding(.top, 12)
        }
    }

    // MARK: - Add Button

    private var addButton: some View {

        HStack {
            Spacer()

            Button {
                onAdd()
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

// MARK: - Preview

#Preview {
    AllDone(onAdd: {})
}

