//
//  TranslationContract.swift
//  CoreML_test
//
//  Created Осина П.М. on 19.03.18.
//  Copyright © 2018 Осина П.М.. All rights reserved.
//

import Foundation

protocol TranslationView: class {
    func setTranslatedText(text: [String])
}

protocol TranslationPresenter {
    func translationRequest(language: String, text: String)
    func navigateToTextDetectionView()
    func textFromTextDetectionVC() -> [String]
}

protocol TranslationRouter {
    func navigateToTextDetectionView()
    func textFromTextDetectionVC() -> [String]

}
