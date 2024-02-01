import SwiftUI
import Charts

struct CryptoDetailView: View {
    let crypto: CryptoModel
    @EnvironmentObject var walletViewModel: WalletViewModel
    @EnvironmentObject var cryptoListViewModel: CryptoListViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            HStack(alignment: .bottom) {
                Text(crypto.baseAsset)
                    .font(.largeTitle)
                    .bold()
                Text(crypto.symbol)
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.gray)
            }
            PriceWithCurrencyView(price: crypto.askPrice)
                .font(.title)
                .bold()
                .foregroundStyle(.white)
            HStack {
             Text("Volume")
                    .font(.title)
                    .foregroundStyle(.gray)
                Text(String(crypto.volume))
                       .font(.title)
                       .foregroundStyle(.white)
            }
            
            PriceScaleView(lowPrice: crypto.lowPrice, highPrice: crypto.highPrice)
            DetailInfoRow(category: "Open price", priceValue: crypto.openPrice)
            DetailInfoRow(category: "Last price", priceValue: crypto.lastPrice)
            
            HStack {
                Spacer()
                Button {
                    walletViewModel.buyCrypto(crypto: crypto)
                } label: {
                    Text("Buy")
                }
                .tint(.purple)
                .buttonStyle(.borderedProminent)
                .font(.largeTitle)
                Spacer()
            }
        }
        .padding(.horizontal)
        .toolbar {
            ToolbarItem(placement: .principal) {
                CurrencySwitchView()
            }
        }
        .alert("Successfully bought \(crypto.baseAsset)", isPresented: $walletViewModel.showingBoughtAlert) { }
    }
}
