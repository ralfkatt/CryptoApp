import SwiftUI

struct CryptoListItem: View {
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
            Image(systemName: "arrow.right.square.fill")
                .font(.title)
                .frame(alignment: .trailing)
                .foregroundStyle(.purple)
        }
        .foregroundStyle(.white)
        .padding(.horizontal)
    }
}
