import SwiftUI

struct WalletListHeader: View {
    var body: some View {
        HStack(spacing: 10) {
            Text("Base asset")
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Symbol").fontWeight(.bold).frame(maxWidth: .infinity, alignment: .leading)
            Text("Value")
                .fontWeight(.bold).frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
