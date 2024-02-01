import Foundation

class WalletViewModel: ObservableObject {
    @Published var cryptos: [CryptoModel] = []
    @Published var showingBoughtAlert = false
    
    func buyCrypto(crypto: CryptoModel) {
        DispatchQueue.main.async { [weak self] in
            self?.showingBoughtAlert = true
            self?.cryptos.append(crypto)
        }
    }
}
