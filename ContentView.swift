
import SwiftUI

struct ContentView: View {
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

            // Plant Image
            Image("plant")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)

            // Title
            Text("Start your plant journey!")
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(.white)
                .padding(.top, 20)

            // Description
            Text("Now all your plants will be in one place and we will help you take care of them :) 🪴")
                .font(.system(size: 14))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 35)
                .padding(.top, 12)

            Spacer()

            // Button
            Button(action: {
                // Navigate to next screen
            }) {
                Text("Set Plant Reminder")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color(red: 51/255, green: 128/255, blue: 105/255))
                    .clipShape(Capsule())
            }
            .padding(.horizontal, 65)
            .padding(.bottom, 90)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.ignoresSafeArea())
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
