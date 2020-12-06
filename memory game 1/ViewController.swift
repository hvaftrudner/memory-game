//
//  ViewController.swift
//  memory game 1
//
//  Created by Kristoffer Eriksson on 2020-12-05.
//

import UIKit

class ViewController: UICollectionViewController {
    
    var cards = [Card]()
    
    var lastCard: String = ""
    var numOfCards: Int = 1
    var lastCell: UICollectionViewCell?
    
    var pairs: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initializeCards()
        
        
    }
    
    //func to initialize cards and shuffle them
    func initializeCards(){
        var tempDeck = [Card]()
        let colors = ["red", "green", "blue", "yellow", "purple"]
        
        for i in 0..<10 {
            
            if i % 2 == 0 {
                let newCard = Card(name: "card\(i)", type: colors[i / 2], faceUp: false)
                tempDeck.append(newCard)
            } else {
                let newCard = Card(name: "card\(i)", type: colors[i / 2], faceUp: false)
                tempDeck.append(newCard)
            }
        }
        
        cards = tempDeck
        cards.shuffle()
    }
    
    //func to animate cards on click
    
    //func to convert color from string
    
    //func to check win condition
    func winCondition(){
        if pairs == 5 {
            let ac = UIAlertController(title: "WINNER", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "ok", style: .default))
            ac.addAction(UIAlertAction(title: "restart?", style: .default, handler: restartGame))
            present(ac, animated: true)
        }
    }
    
    @objc func restartGame(action: UIAlertAction){
        
        cards = [Card]()
        lastCard = ""
        numOfCards = 1
        lastCell = nil
        pairs = 0
        
        initializeCards()
        collectionView.reloadData()
        
    }
    
    //--Mark CollectionView
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Card", for: indexPath)
        
        //programmaticall settings
        //cell.layoutMargins = UIEdgeInsets(top: 100, left: 20, bottom: 10, right: 20)
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 3
        cell.layer.cornerRadius = 20
        
        cell.backgroundColor = .white
        
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else {return}
        
        let card = cards[indexPath.item]
        
        //......
        card.faceUp = true
        
        let cardColor = card.type
        var newColor: UIColor
        
        if cardColor == "red"{
            newColor = UIColor.red
        } else if cardColor == "green"{
            newColor = UIColor.green
        } else if cardColor == "blue"{
            newColor = UIColor.blue
        } else if cardColor == "yellow" {
            newColor = UIColor.yellow
        } else {
            newColor = UIColor.purple
        }
        
        
        
        //on click Code debug
//        print(cards[indexPath.item].name)
//        print(cards[indexPath.item].type)
//        print(cards[indexPath.item].faceUp)
//        print("---")
//        print(lastCard)
        
        UIView.transition(with: cell, duration: 0.5, options: [.transitionFlipFromRight], animations: nil) {
            finished in
            //put next animation here to chain them instead of having them separate
        }
        UIView.animate(withDuration: 1, animations: {
            //cell?.alpha = 0
            cell.transform = CGAffineTransform(rotationAngle: CGFloat(50))
            cell.backgroundColor = newColor
        })
        
        //logic ...move to own function
        
        //works
        if cardColor == lastCard{
            
            UIView.animate(withDuration: 1, delay: 0.5, animations: {
                //cell?.alpha = 0
                cell.alpha = 0
                self.lastCell?.alpha = 0
            })
            
            //reset
            lastCell = nil
            lastCard = ""
            numOfCards = 0
            //add to wincondition
            pairs += 1
            
        }
        //numOfCards > 1
        if  cardColor != lastCard && numOfCards == 2{
            
            UIView.animate(withDuration: 1, delay: 0.5, animations: {
                //cell?.alpha = 0
                cell.transform = .identity
                cell.backgroundColor = .white
                
                self.lastCell?.transform = .identity
                self.lastCell?.backgroundColor = .white
            })
            
            //card.faceUp = false
            numOfCards = 1
            lastCard = ""
            lastCell = nil
            
        } else {
            card.faceUp = false
            numOfCards += 1
            lastCard = cardColor
            lastCell = cell
        }
        winCondition()
    }
}

