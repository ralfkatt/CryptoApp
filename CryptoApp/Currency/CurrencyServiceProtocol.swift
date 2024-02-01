import Foundation

/// The CurrencyServiceProtocol  describes a method fetchCurrencyExchangeRate
/// whose purpose is to fetch the currency exchange rate for USD to other currencies.
/// In this MVP the only returned exchange rate is SEK but it could easily be extended to return
/// rates from several currencies.
protocol CurrencyServiceProtocol {
    func fetchCurrencyExchangeRate(completion: @escaping (Result<Double, NetworkError>) -> Void)
}
