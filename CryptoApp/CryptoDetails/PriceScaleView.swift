import SwiftUI

struct PriceScaleView: View {
    let lowPrice: Double
    let highPrice: Double
    @EnvironmentObject var cryptoListViewModel: CryptoListViewModel
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("Low")
                        .foregroundStyle(.gray)
                    PriceWithCurrencyView(price: lowPrice)
                }
                Spacer()
                VStack {
                    Text("High")
                        .foregroundStyle(.gray)
                    PriceWithCurrencyView(price: lowPrice)
                }
            }
            Divider()
                .frame(minHeight: 5)
                .background(Color.white)
        }
        .foregroundColor(.white)
    }
}
