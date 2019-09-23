//
//  StartViewController.swift
//  RxswiftBasicsPractice
//
//  Created by ChanWook Park on 21/09/2019.
//  Copyright © 2019 Ios_Park. All rights reserved.
//

import UIKit

enum nextViews: Int {
    case observableCreations = 0
    case subjectPratice
    case relay
    case plusThreeNumbersViewController
    case multiplicationTableViewController
    case mutiplicationTable2ViewController
    case animationViewController
}

class StartViewController: UIViewController {

    let tableOfContents = ["ObservableCreations", "Subject", "Relay", "PlusThreeNumbers", "Multiplication", "Mutiplication2", "AnimationView"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}

extension StartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableOfContents.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = tableOfContents[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case nextViews.observableCreations.rawValue:
            if let storyboard = self.storyboard, let observableCreationsViewController = storyboard.instantiateViewController(withIdentifier: "ObservableCreationsViewController") as? ObservableCreationsViewController {
                self.navigationController?.pushViewController(observableCreationsViewController, animated: true)
            }
        case nextViews.subjectPratice.rawValue:
            if let storyboard = self.storyboard, let subjectPraticeViewController = storyboard.instantiateViewController(withIdentifier: "SubjectPracticeViewController") as? SubjectPracticeViewController {
                self.navigationController?.pushViewController(subjectPraticeViewController, animated: true)
            }
        case nextViews.relay.rawValue:
            if let storyboard = self.storyboard, let relayViewController = storyboard.instantiateViewController(withIdentifier: "RelayViewController") as? RelayViewController {
                self.navigationController?.pushViewController(relayViewController, animated: true)
            }
        case nextViews.plusThreeNumbersViewController.rawValue:
            if let storyboard = self.storyboard, let plusThreeNumbersViewController = storyboard.instantiateViewController(withIdentifier: "PlusThreeNumbersViewController") as? PlusThreeNumbersViewController {
                self.navigationController?.pushViewController(plusThreeNumbersViewController, animated: true)
            }
        case nextViews.multiplicationTableViewController.rawValue:
            if let storyboard = self.storyboard, let multiplicationTableViewController = storyboard.instantiateViewController(withIdentifier: "MultiplicationTableViewController") as? MultiplicationTableViewController {
                self.navigationController?.pushViewController(multiplicationTableViewController, animated: true)
            }
        case nextViews.mutiplicationTable2ViewController.rawValue:
            if let storyboard = self.storyboard, let multiplicationTable2ViewController = storyboard.instantiateViewController(withIdentifier: "MultiplicationTable2ViewController") as? MultiplicationTable2ViewController {
                self.navigationController?.pushViewController(multiplicationTable2ViewController, animated: true)
            }
        case nextViews.animationViewController.rawValue:
            if let storyboard = self.storyboard, let animationViewController = storyboard.instantiateViewController(withIdentifier: "AnimationViewController") as? AnimationViewController {
                self.navigationController?.pushViewController(animationViewController, animated: true)
            }
        default:
            break
        }
    }
}
