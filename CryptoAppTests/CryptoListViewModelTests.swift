import Foundation
import Combine
import XCTest

class MockCryptoService: CryptoServiceProtocol {
    var testCryptos: [CryptoModel]?
    func fetchCryptos(completion: @escaping (Result<[CryptoModel], NetworkError>) -> Void) {
        if let cryptos = testCryptos {
            completion(.success(cryptos))
        }
        else {
            completion(.failure(.noData))
        }
    }
}

class MockCurrencyService: CurrencyServiceProtocol {
    var sekRate = 0.0
    func fetchCurrencyExchangeRate(completion: @escaping (Result<Double, NetworkError>) -> Void) {
        return completion(.success(sekRate))
    }
    
    
}

class CryptoListViewModelTests: XCTestCase {
    var cryptoListViewModel: CryptoListViewModel!
    var mockCryptoService: MockCryptoService!
    var mockCurrencyService: MockCurrencyService!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        mockCryptoService = MockCryptoService()
        mockCurrencyService = MockCurrencyService()
        cryptoListViewModel = CryptoListViewModel(cryptoService: mockCryptoService, currencyService: mockCurrencyService)
    }
    
    func testGetCryptos() {
        let expectation = XCTestExpectation(description: "Published property should update")
        
        let cryptos = CryptoModel(
            symbol: "BTC",
            baseAsset: "Bitcoin",
            openPrice: 50000.0,
            lowPrice: 49000.0,
            highPrice: 51000.0,
            lastPrice: 50500.0,
            bidPrice: 50400.0,
            askPrice: 50600.0,
            volume: 1000.0,
            at: 1234567890
        )
        mockCryptoService?.testCryptos = [cryptos]
        
        // subscribe to updates to cryptos since it's asynchrounus
        cryptoListViewModel.$cryptos
            .dropFirst()
            .sink { cryptos in
                XCTAssertFalse(cryptos.isEmpty, "Cryptos should not be empty")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        cryptoListViewModel?.getCryptos()
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testGetCryptosEmpty() {
        let expectation = XCTestExpectation(description: "Published property should update")
        
        mockCryptoService?.testCryptos = []
        
        // subscribe to updates to cryptos since it's asynchrounus
        cryptoListViewModel.$cryptos
            .dropFirst()
            .sink { cryptos in
                XCTAssertTrue(cryptos.isEmpty, "Cryptos should not be empty")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        cryptoListViewModel?.getCryptos()
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testShowSekCurrency() {
        let expectation = XCTestExpectation(description: "Published property should update")
        
        mockCurrencyService.sekRate = 10
        let cryptos = CryptoModel(
            symbol: "BTC",
            baseAsset: "Bitcoin",
            openPrice: 50000.0,
            lowPrice: 49000.0,
            highPrice: 51000.0,
            lastPrice: 50500.0,
            bidPrice: 50400.0,
            askPrice: 1000.0,
            volume: 1000.0,
            at: 1234567890
        )
        cryptoListViewModel.cryptos = [cryptos]
        
        // subscribe to updates to cryptos since it's asynchrounus
        cryptoListViewModel.$cryptos
            .dropFirst()
            .sink { cryptos in
                XCTAssertFalse(cryptos.isEmpty, "Cryptos should not be empty")
                
                // original ask price was 1000 so should be 100
                XCTAssertEqual(cryptos[0].askPrice, 100)
                
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        cryptoListViewModel?.changeToSek(cryptos: [cryptos])
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testShowSekCurrencyZero() {        
        mockCurrencyService.sekRate = 0
        let cryptos = CryptoModel(
            symbol: "BTC",
            baseAsset: "Bitcoin",
            openPrice: 50000.0,
            lowPrice: 49000.0,
            highPrice: 51000.0,
            lastPrice: 50500.0,
            bidPrice: 50400.0,
            askPrice: 1000.0,
            volume: 1000.0,
            at: 1234567890
        )
        cryptoListViewModel.cryptos = [cryptos]
        
        
        cryptoListViewModel?.changeToSek(cryptos: [cryptos])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            guard let resultingCrypto = self.cryptoListViewModel.cryptos.first else {
                XCTFail("Cryptos array is unexpectedly empty")
                return
            }
            
            XCTAssertEqual(resultingCrypto.askPrice, cryptos.askPrice, "Ask price should remain unchanged")
        }
    }
    
    func testGetCryptosAndConvertToSek() {
        let expectation = XCTestExpectation(description: "Published property should update")
        
        mockCurrencyService.sekRate = 10
        let cryptos = CryptoModel(
            symbol: "BTC",
            baseAsset: "Bitcoin",
            openPrice: 50000.0,
            lowPrice: 49000.0,
            highPrice: 51000.0,
            lastPrice: 50500.0,
            bidPrice: 50400.0,
            askPrice: 1000.0,
            volume: 1000.0,
            at: 1234567890
        )
        mockCryptoService.testCryptos = [cryptos]
                
        // subscribe to updates to cryptos since it's asynchrounus
        cryptoListViewModel.$cryptos
            .dropFirst()
            .sink { cryptos in
                XCTAssertFalse(cryptos.isEmpty, "Cryptos should not be empty")
                
                // original ask price was 1000 so should be 100
                XCTAssertEqual(cryptos[0].askPrice, 100)
                
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        cryptoListViewModel?.getCryptosAndConvertToSek()
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
