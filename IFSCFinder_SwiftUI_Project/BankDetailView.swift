
import SwiftUI

struct BankDetailView: View {
    let bank: Bank

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(bank.BANK).font(.title2).bold()
            Text("Branch: \(bank.BRANCH)")
            Text("City: \(bank.CITY)")
            Text("State: \(bank.STATE)")
            Text("MICR: \(bank.MICR ?? "N/A")")
            Text("Contact: \(bank.CONTACT ?? "N/A")")
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}
