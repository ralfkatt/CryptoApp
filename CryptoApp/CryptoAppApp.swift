import SwiftUI

@main
struct CryptoAppApp: App {
    @StateObject var cryptoListViewModel = CryptoListViewModel(cryptoService: CryptoService(), currencyService: CurrencyService())
    @StateObject var walletViewModel = WalletViewModel()

    var body: some Scene {
        WindowGroup {
            TabView {
                CryptoListView()
                    .environmentObject(cryptoListViewModel)
                    .environmentObject(walletViewModel)
                    .tabItem {
                        Label("All cryptos", systemImage: "bitcoinsign.square.fill")
                    }
                WalletView()
                    .environmentObject(cryptoListViewModel)
                    .environmentObject(walletViewModel)
                    .tabItem {
                        Label("Your wallet", systemImage: "wallet.pass.fill")
                    }
            }
           
        }
    }
}
