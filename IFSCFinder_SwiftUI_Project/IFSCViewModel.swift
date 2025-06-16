
import Foundation

class IFSCViewModel: ObservableObject {
    @Published var ifscCode: String = ""
    @Published var bank: Bank?
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchBankDetails() {
        guard !ifscCode.isEmpty else {
            errorMessage = "Please enter a valid IFSC code."
            return
        }

        let urlString = "https://ifsc.razorpay.com/\(ifscCode.uppercased())"
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL."
            return
        }

        isLoading = true
        errorMessage = nil
        bank = nil

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false

                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    self.errorMessage = "Bank details not found."
                    return
                }

                if let data = data {
                    do {
                        let decoded = try JSONDecoder().decode(Bank.self, from: data)
                        self.bank = decoded
                    } catch {
                        self.errorMessage = "Failed to decode response."
                    }
                }
            }
        }.resume()
    }
}
