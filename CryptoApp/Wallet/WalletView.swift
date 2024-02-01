import SwiftUI

struct WalletView: View {
    @EnvironmentObject var walletViewModel: WalletViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text("Your wallet")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.white)
            WalletListHeader()
            ScrollView {
                LazyVStack(spacing: 30) {
                    if(walletViewModel.cryptos.isEmpty) {
                        Text("""
                            Your wallet is empty,
                            go and buy some crypto.
                            """)
                        .font(.title)
                        .bold()
                        .foregroundStyle(.white)
                    }
                    ForEach(Array(walletViewModel.cryptos.enumerated()), id: \.offset) { _, crypto in
                        WalletItemView(crypto: crypto)
                        Divider()
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}
