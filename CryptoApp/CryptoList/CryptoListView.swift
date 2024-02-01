import SwiftUI

struct CryptoListView: View {
    @EnvironmentObject var cryptoListViewModel: CryptoListViewModel
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 30) {
                CryptoListHeader()
                ScrollView {
                    LazyVStack(spacing: 30) {
                        ForEach(cryptoListViewModel.cryptos) { crypto in
                            NavigationLink {
                                CryptoDetailView(crypto: crypto)
                            } label: {
                                CryptoListItem(crypto: crypto)
                            }
                            Divider()
                        }
                    }
                }
                .refreshable {
                    if(cryptoListViewModel.isShowingUsd) {
                        cryptoListViewModel.getCryptos()
                    }
                    else {
                        cryptoListViewModel.getCryptosAndConvertToSek()
                    }
                }
            }
            .onAppear {
                if(cryptoListViewModel.isShowingUsd) {
                    cryptoListViewModel.getCryptos()
                }
                else {
                    cryptoListViewModel.getCryptosAndConvertToSek()
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    CurrencySwitchView()
                }
            }
        }
       
    }
}
