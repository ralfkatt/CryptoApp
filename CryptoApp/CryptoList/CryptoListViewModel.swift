import Foundation

class CryptoListViewModel: ObservableObject {
    let cryptoService: CryptoServiceProtocol
    let currencyService: CurrencyServiceProtocol
    @Published var cryptos: [CryptoModel]
    @Published var isShowingUsd = true
    
    init(cryptos: [CryptoModel] = [], cryptoService: CryptoServiceProtocol, currencyService: CurrencyServiceProtocol) {
        self.cryptos = cryptos
        self.cryptoService = cryptoService
        self.currencyService = currencyService
    }
    
    /// Fetches the currency exchange rate and applying the new price for all cryptos
    func changeToSek(cryptos: [CryptoModel]) {
        currencyService.fetchCurrencyExchangeRate { [weak self] result in
            switch result {
            case .success(let sekRate):
                guard sekRate != 0 else {
                    return
                }
                DispatchQueue.main.async {
                    self?.cryptos = cryptos.map { crypto in
                        var newCrypto = crypto
                        newCrypto.askPrice /= sekRate
                        newCrypto.bidPrice /= sekRate
                        newCrypto.highPrice /= sekRate
                        newCrypto.lastPrice /= sekRate
                        newCrypto.lowPrice /= sekRate
                        newCrypto.openPrice /= sekRate
                        return newCrypto
                    }
                    
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /// Fetches the cryptos and converts the fetched price information to SEK
    func getCryptosAndConvertToSek() {
        cryptoService.fetchCryptos { [weak self] result in
            switch result {
            case .success(let fetchedCryptos):
                self?.changeToSek(cryptos: fetchedCryptos)
            case .failure(let error):
                print("Error fetching cryptos: \(error)")
            }
        }
    }
    
    /// Fetches  the cryptos and sets the field cryptos to the result. The resulting currency for the prices  is USD.
    func getCryptos() {
        cryptoService.fetchCryptos { [weak self] result in
            switch result {
            case .success(let cryptos):
                DispatchQueue.main.async {
                    self?.cryptos = cryptos
                }
            case .failure(let error):
                print(error.localizedDescription)
                print(error)
            }
        }
    }
}
