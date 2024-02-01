import SwiftUI

struct CurrencySwitchView: View {
    @EnvironmentObject var cryptoListViewModel: CryptoListViewModel
    var body: some View {
        HStack {
            Button {
                cryptoListViewModel.isShowingUsd = true
                
                /// Fetching the data again when revering to USD.
                /// This would be good in a realistic scenario when we would  the data up to date, contrary to caching the USD
                cryptoListViewModel.getCryptos()
            } label: {
                Text("USD")
                    .bold()
                    .padding(5)
            }
            .background(cryptoListViewModel.isShowingUsd ? .mint : .white)
            .foregroundStyle(cryptoListViewModel.isShowingUsd ? .black : .black)
            .disabled(cryptoListViewModel.isShowingUsd)
            .clipShape(.rect(cornerRadius: 5))
            
            Button {
                cryptoListViewModel.isShowingUsd = false
                cryptoListViewModel.getCryptosAndConvertToSek()
            } label: {
                Text("SEK")
                    .bold()
                    .padding(5)
            }
            .background(!cryptoListViewModel.isShowingUsd ? .mint : .white)
            .foregroundStyle(!cryptoListViewModel.isShowingUsd ? .black : .black)
            .disabled(!cryptoListViewModel.isShowingUsd)
            .clipShape(.rect(cornerRadius: 5))
        }
    }
}
