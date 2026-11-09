import SwiftUI

struct NoReminders : View {
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
            Text("No reminders set yet.. ")
                .font(.system(size: 14))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 35)
                .padding(.top, 12)

            Spacer()

            
            // Add Button
            HStack {
                Spacer()

                Button(action: {
                    // Add new plant action
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundStyle(.white)
                        .frame(width: 50, height: 50)
                        .background(Color(red: 51/255, green: 128/255, blue: 105/255))
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal, 25)
            .padding(.bottom, 25)
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.ignoresSafeArea())
        .preferredColorScheme(.dark)
    }


        }

        #Preview {
            NoReminders()
        }
