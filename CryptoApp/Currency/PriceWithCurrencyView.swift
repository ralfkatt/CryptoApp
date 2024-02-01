import SwiftUI

struct PriceWithCurrencyView: View {
    @EnvironmentObject var cryptoListViewModel: CryptoListViewModel

    var price: Double

    private var formattedPrice: String {
        let roundedValue = String((price * 1000).rounded() / 1000)
        return cryptoListViewModel.isShowingUsd ? "$\(roundedValue)" : "\(roundedValue) kr"
    }

    var body: some View {
        Text(formattedPrice)
            .scaledToFill()
    }
}
