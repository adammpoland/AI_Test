//
//  main.swift
//  AI_Test
//
//  Created by Adam Poland on 7/8/21.
//

import Foundation
import NaturalLanguage

print("Speak")
let input = readLine()

var sentence = Sentence(rawSentence: input!)
sentence.tagPartsOfSpeech(sentence: input!);


print(sentence.GetSentenceType(sentence: sentence))



class Sentence {
    var rawSentence: String
    var wordArray = [Word]()
    
    init(rawSentence: String)
    {
        self.rawSentence = rawSentence
        tagPartsOfSpeech(sentence: rawSentence)
    }
    
    func tagPartsOfSpeech(sentence: String) {
        var index = 0
        let text = sentence
        let tagger = NLTagger(tagSchemes: [.lexicalClass])
        tagger.string = text
        let options: NLTagger.Options = [.omitPunctuation, .omitWhitespace]
        tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: .word, scheme: .lexicalClass, options: options) { tag, tokenRange in
            if let tag = tag {
                //print("\(text[tokenRange]): \(tag.rawValue)")
                wordArray.append(Word(rawWord: String(text[tokenRange])))
                wordArray[index].partOfSpeech = String(tag.rawValue)

                index+=1
            }
            return true
        }
    }
    
    func GetSentenceType(sentence: Sentence) -> String {
        if(sentence.wordArray[0].partOfSpeech == "Verb")
        {
            return "Imperative"

        }
        else if(sentence.wordArray[0].partOfSpeech == "Pronoun" || sentence.wordArray[0].partOfSpeech == "Noun" || sentence.wordArray[0].partOfSpeech == "Article")
        {
            return "Declatative"
        }
        else if(sentence.rawSentence.contains("?"))
        {
            return "Interrogative"
        }
        else if(sentence.rawSentence.contains("!"))
        {
            return "Exclamatory"
        }
        else
        {
            return "Unknown"
        }
    }
}

class Word {
    var partOfSpeech: String
    var rawWord: String
    init(rawWord: String) {
        self.rawWord = rawWord
        partOfSpeech = "Unknown"
    }
    
}



