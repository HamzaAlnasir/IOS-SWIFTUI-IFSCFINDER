
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = IFSCViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("IFSC Finder")
                    .font(.largeTitle)
                    .bold()

                TextField("Enter IFSC Code", text: $viewModel.ifscCode)
                    .textInputAutocapitalization(.characters)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)

                Button(action: {
                    viewModel.fetchBankDetails()
                }) {
                    Text("Get Bank Details")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(viewModel.ifscCode.isEmpty || viewModel.isLoading)

                if viewModel.isLoading {
                    ProgressView()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else if let bank = viewModel.bank {
                    BankDetailView(bank: bank)
                        .transition(.opacity)
                }

                Spacer()
            }
            .padding()
        }
    }
}
