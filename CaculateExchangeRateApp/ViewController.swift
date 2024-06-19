//
//  ViewController.swift
//  CaculateExchangeRateApp
//
//  Created by 김정현 on 6/18/24.
//

import UIKit

class ExchangeRateService {
    let apiKey = "444713ec1cddc7fcb868e42f"
    let url = "https://api.exchangerate-api.com/v4/latest/KRW"

    func fetchExchangeRates(completion: @escaping (ExchangeRate?) -> Void) {
        guard let url = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let exchangeRate = try? JSONDecoder().decode(ExchangeRate.self, from: data)
            completion(exchangeRate)
        }
        task.resume()
    }
}

struct ExchangeRate: Codable {
    let rates: [String: Double]
}

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var fromCurrencyPicker: UIPickerView!
    @IBOutlet weak var toCurrencyPicker: UIPickerView!
    @IBOutlet weak var resultLabel: UILabel!

    var exchangeRates: [String: Double] = [:]
    var currencies: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fromCurrencyPicker.dataSource = self
        fromCurrencyPicker.delegate = self
        toCurrencyPicker.dataSource = self
        toCurrencyPicker.delegate = self

        let service = ExchangeRateService()
        service.fetchExchangeRates { exchangeRate in
            guard let exchangeRate = exchangeRate else { return }
            self.exchangeRates = exchangeRate.rates
            self.currencies = Array(exchangeRate.rates.keys).sorted() // 알파벳 순으로 정렬
            DispatchQueue.main.async {
                self.fromCurrencyPicker.reloadAllComponents()
                self.toCurrencyPicker.reloadAllComponents()
            }
        }
    }

    @IBAction func convertButtonTapped(_ sender: UIButton) {
        guard let amountText = amountTextField.text, let amount = Double(amountText) else {
            return
        }
        let fromRow = fromCurrencyPicker.selectedRow(inComponent: 0)
        let toRow = toCurrencyPicker.selectedRow(inComponent: 0)
        let fromCurrency = currencies[fromRow]
        let toCurrency = currencies[toRow]

        guard let fromRate = exchangeRates[fromCurrency], let toRate = exchangeRates[toCurrency] else {
            return
        }

        let convertedAmount = amount * (toRate / fromRate)
        resultLabel.text = "\(convertedAmount) \(toCurrency)"
    }

    // UIPickerViewDataSource & UIPickerViewDelegate methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencies[row]
    }
}
