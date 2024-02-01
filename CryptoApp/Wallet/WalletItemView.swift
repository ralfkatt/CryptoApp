import SwiftUI

struct WalletItemView: View {
    let crypto: CryptoModel
    var body: some View {
        HStack(spacing: 10) {
            Text(crypto.baseAsset)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(crypto.symbol)
                .frame(maxWidth: .infinity, alignment: .leading)
            PriceWithCurrencyView(price: crypto.askPrice)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
