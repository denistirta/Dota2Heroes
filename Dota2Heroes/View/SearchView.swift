//
//  SearchView.swift
//  Dota2Heroes
//
//  Created by DenisTirta on 13/08/21.
//

import UIKit

@objc protocol SearchViewDelegate{
    @objc optional func textValueDidInput(value: String)
}

class SearchView: UIView, UITextFieldDelegate {
    
    var delegate: SearchViewDelegate?
    @IBOutlet weak var search: UITextField!
    
    private var debouncer: Debouncer!
    private var textFieldValue = "" {
        didSet {
            debouncer.call()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        search.delegate = self
        search.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        debouncer = Debouncer.init(delay: 1, callback: debouncerApiCall)
    }
    
    private func debouncerApiCall() {
        delegate?.textValueDidInput?(value: search.text ?? "")
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        delegate?.textValueDidInput?(value: textField.text ?? "")
    }


}
