//
//  WorldDataDetailViewController.swift
//  CoronavirusStats
//

import UIKit
import Alamofire
import Lottie

class WorldDataDetailViewController: UIViewController {
    
    var chosenCountry : String = ""
    let endpoint = URL(string: "https://api.covid19api.com/country/")!
    
    @IBOutlet weak var worldCountryNameLabel: UILabel!
    
    @IBOutlet weak var worldDateLabel: UILabel!
    
    @IBOutlet weak var worldConfirmedLabel: UILabel!
    
    @IBOutlet weak var worldDeathsLabel: UILabel!
    
    @IBOutlet weak var worldRecoveredLabel: UILabel!
    
    @IBOutlet weak var worldActiveLabel: UILabel!
    
    @IBOutlet weak var graphControl: UIButton!
    var worldDataDetailLoad = false
    
    var worldSevenDeathsVariable = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        
        getData(country: chosenCountry)
        getLastSevenDayData(country: chosenCountry)
        
        addCardCountry()
        addCardConfirmed()
        addCardDate()
        addCardDeaths()
        addCardRecovered()
        addCardActive()
        
    }
    
    
    
    func getData(country: String){
        
        let countryNameEdited = country.replacingOccurrences(of: " ", with: "-")
        print(countryNameEdited)
        let request = AF.request("\(endpoint)\(countryNameEdited)", requestModifier: { $0.timeoutInterval = 10 }).validate()
        request.responseJSON { (data) in
            // print(data)
        }
        
        request.responseDecodable(of: [CountryModel].self) { (response) in
            
            switch response.result {
            case .success(let model):
                if model.count > 0 {
                    
                    self.worldCountryNameLabel.text = "Country: \(model.last!.country)"
                    print("Country: \(model.last!.country)")
                    
                    
                    var date = model.last!.date
                    let dateArray = date.components(separatedBy: "T")
                    date = dateArray[0].replacingOccurrences(of: "-", with: ".")
                    
                    self.worldDateLabel.text = "Date: \(date)"
                    print("Date: \(date)")
                    
                    self.worldConfirmedLabel.text = "Confirmed: \(model.last!.confirmed)"
                    print("Confirmed: \(model.last!.confirmed)")
                    
                    self.worldDeathsLabel.text = "Deaths: \(model.last!.deaths)"
                    print("Deaths: \(model.last!.deaths)")
                    
                    self.worldRecoveredLabel.text = "Recovered: \(model.last!.recovered)"
                    print("Recovered: \(model.last!.recovered)")
                    
                    self.worldActiveLabel.text = "Active: \(model.last!.active)"
                    print("Active: \(model.last!.active)")
                    
                    self.worldDataDetailLoad = true
                    
                    if(model.last!.deaths == 0){
                        self.graphControl.isEnabled = false
                    }
                    
                } else {
                    self.makeAlert(alertTitle: "We are sorry...", alertMessage: "We do not have data for this country")
                    self.graphControl.isEnabled = false
                }
                
            case .failure(let error):
                do {
                    
                    self.makeAlert(alertTitle: "We are sorry...", alertMessage: "Something went wrong!")
                    //print(error)
                    self.graphControl.isEnabled = false
                    
                }
            }
            
        }
        
    }
    
    func addCardCountry(){
        let width: CGFloat = 350
        let height: CGFloat = 60
        
        let card = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        //vw.image = UIImage(named: "YourPictureHere")
        card.center = view.center
        view.addSubview(card)
        card.backgroundColor = UIColor(red: 0.88, green: 0.12, blue: 0.22, alpha: 1.00)
        card.layer.shadowOpacity = 1
        card.layer.cornerRadius = 10
        card.layer.shadowColor = UIColor.red.cgColor
        
        let shadowRadius: CGFloat = 20
        card.layer.shadowRadius = shadowRadius
        card.layer.shadowOffset = CGSize(width: 0, height: 20)
        card.layer.shadowOpacity = 0.5
        
        // how strong to make the curling effect
        let curveAmount: CGFloat = 20
        let shadowPath = UIBezierPath()
        
        // the top left and right edges match our view, indented by the shadow radius
        shadowPath.move(to: CGPoint(x: shadowRadius, y: 0))
        shadowPath.addLine(to: CGPoint(x: width - shadowRadius, y: 0))
        
        // the bottom-right edge of our shadow should overshoot by the size of our curve
        shadowPath.addLine(to: CGPoint(x: width - shadowRadius, y: height + curveAmount))
        
        // the bottom-left edge also overshoots by the size of our curve, but is added with a curve back up towards the view
        shadowPath.addCurve(to: CGPoint(x: shadowRadius, y: height + curveAmount), controlPoint1: CGPoint(x: width, y: height - shadowRadius), controlPoint2: CGPoint(x: 0, y: height - shadowRadius))
        card.layer.shadowPath = shadowPath.cgPath
        self.worldCountryNameLabel?.textColor = .white
        
        card.addSubview(worldCountryNameLabel)
        card.center = self.worldCountryNameLabel.center
        
        
    }
    
    func addCardDate(){
        
        let width: CGFloat = 350
        let height: CGFloat = 60
        
        let card = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        //vw.image = UIImage(named: "YourPictureHere")
        card.center = view.center
        view.addSubview(card)
        card.backgroundColor = UIColor(red: 0.78, green: 0.12, blue: 0.22, alpha: 1.00)
        card.layer.shadowOpacity = 1
        card.layer.cornerRadius = 10
        card.layer.shadowColor = UIColor.red.cgColor
        
        let shadowRadius: CGFloat = 20
        card.layer.shadowRadius = shadowRadius
        card.layer.shadowOffset = CGSize(width: 0, height: 20)
        card.layer.shadowOpacity = 0.5
        
        // how strong to make the curling effect
        let curveAmount: CGFloat = 20
        let shadowPath = UIBezierPath()
        
        // the top left and right edges match our view, indented by the shadow radius
        shadowPath.move(to: CGPoint(x: shadowRadius, y: 0))
        shadowPath.addLine(to: CGPoint(x: width - shadowRadius, y: 0))
        
        // the bottom-right edge of our shadow should overshoot by the size of our curve
        shadowPath.addLine(to: CGPoint(x: width - shadowRadius, y: height + curveAmount))
        
        // the bottom-left edge also overshoots by the size of our curve, but is added with a curve back up towards the view
        shadowPath.addCurve(to: CGPoint(x: shadowRadius, y: height + curveAmount), controlPoint1: CGPoint(x: width, y: height - shadowRadius), controlPoint2: CGPoint(x: 0, y: height - shadowRadius))
        card.layer.shadowPath = shadowPath.cgPath
        self.worldDateLabel?.textColor = .white
        
        card.addSubview(worldDateLabel)
        card.center = self.worldDateLabel.center
    }
    
    
    
    func addCardConfirmed(){
        
        let width: CGFloat = 350
        let height: CGFloat = 60
        
        let card = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        //vw.image = UIImage(named: "YourPictureHere")
        card.center = view.center
        view.addSubview(card)
        card.backgroundColor = UIColor(red: 0.70, green: 0.12, blue: 0.21, alpha: 1.00)
        card.layer.shadowOpacity = 1
        card.layer.cornerRadius = 10
        card.layer.shadowColor = UIColor.red.cgColor
        
        let shadowRadius: CGFloat = 20
        card.layer.shadowRadius = shadowRadius
        card.layer.shadowOffset = CGSize(width: 0, height: 20)
        card.layer.shadowOpacity = 0.5
        
        // how strong to make the curling effect
        let curveAmount: CGFloat = 20
        let shadowPath = UIBezierPath()
        
        // the top left and right edges match our view, indented by the shadow radius
        shadowPath.move(to: CGPoint(x: shadowRadius, y: 0))
        shadowPath.addLine(to: CGPoint(x: width - shadowRadius, y: 0))
        
        // the bottom-right edge of our shadow should overshoot by the size of our curve
        shadowPath.addLine(to: CGPoint(x: width - shadowRadius, y: height + curveAmount))
        
        // the bottom-left edge also overshoots by the size of our curve, but is added with a curve back up towards the view
        shadowPath.addCurve(to: CGPoint(x: shadowRadius, y: height + curveAmount), controlPoint1: CGPoint(x: width, y: height - shadowRadius), controlPoint2: CGPoint(x: 0, y: height - shadowRadius))
        card.layer.shadowPath = shadowPath.cgPath
        self.worldConfirmedLabel?.textColor = .white
        
        card.addSubview(worldConfirmedLabel)
        card.center = self.worldConfirmedLabel.center
        
        
    }
    
    func addCardDeaths(){
        let width: CGFloat = 350
        let height: CGFloat = 60
        
        let card = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        //vw.image = UIImage(named: "YourPictureHere")
        card.center = view.center
        view.addSubview(card)
        card.backgroundColor = UIColor(red: 0.63, green: 0.11, blue: 0.20, alpha: 1.00)
        card.layer.shadowOpacity = 1
        card.layer.cornerRadius = 10
        card.layer.shadowColor = UIColor.red.cgColor
        
        let shadowRadius: CGFloat = 20
        card.layer.shadowRadius = shadowRadius
        card.layer.shadowOffset = CGSize(width: 0, height: 20)
        card.layer.shadowOpacity = 0.5
        
        // how strong to make the curling effect
        let curveAmount: CGFloat = 20
        let shadowPath = UIBezierPath()
        
        // the top left and right edges match our view, indented by the shadow radius
        shadowPath.move(to: CGPoint(x: shadowRadius, y: 0))
        shadowPath.addLine(to: CGPoint(x: width - shadowRadius, y: 0))
        
        // the bottom-right edge of our shadow should overshoot by the size of our curve
        shadowPath.addLine(to: CGPoint(x: width - shadowRadius, y: height + curveAmount))
        
        // the bottom-left edge also overshoots by the size of our curve, but is added with a curve back up towards the view
        shadowPath.addCurve(to: CGPoint(x: shadowRadius, y: height + curveAmount), controlPoint1: CGPoint(x: width, y: height - shadowRadius), controlPoint2: CGPoint(x: 0, y: height - shadowRadius))
        card.layer.shadowPath = shadowPath.cgPath
        self.worldDeathsLabel?.textColor = .white
        card.addSubview(worldDeathsLabel)
        card.center = self.worldDeathsLabel.center
        
    }
    
    func addCardRecovered(){
        let width: CGFloat = 350
        let height: CGFloat = 60
        
        let card = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        //vw.image = UIImage(named: "YourPictureHere")
        card.center = view.center
        view.addSubview(card)
        card.backgroundColor = UIColor(red: 0.43, green: 0.08, blue: 0.14, alpha: 1.00)
        card.layer.shadowOpacity = 1
        card.layer.cornerRadius = 10
        card.layer.shadowColor = UIColor.red.cgColor
        
        let shadowRadius: CGFloat = 20
        card.layer.shadowRadius = shadowRadius
        card.layer.shadowOffset = CGSize(width: 0, height: 20)
        card.layer.shadowOpacity = 0.5
        
        // how strong to make the curling effect
        let curveAmount: CGFloat = 20
        let shadowPath = UIBezierPath()
        
        // the top left and right edges match our view, indented by the shadow radius
        shadowPath.move(to: CGPoint(x: shadowRadius, y: 0))
        shadowPath.addLine(to: CGPoint(x: width - shadowRadius, y: 0))
        
        // the bottom-right edge of our shadow should overshoot by the size of our curve
        shadowPath.addLine(to: CGPoint(x: width - shadowRadius, y: height + curveAmount))
        
        // the bottom-left edge also overshoots by the size of our curve, but is added with a curve back up towards the view
        shadowPath.addCurve(to: CGPoint(x: shadowRadius, y: height + curveAmount), controlPoint1: CGPoint(x: width, y: height - shadowRadius), controlPoint2: CGPoint(x: 0, y: height - shadowRadius))
        card.layer.shadowPath = shadowPath.cgPath
        self.worldRecoveredLabel?.textColor = .white
        card.addSubview(worldRecoveredLabel)
        card.center = self.worldRecoveredLabel.center
        
    }
    
    
    
    
    
    func addCardActive(){
        let width: CGFloat = 350
        let height: CGFloat = 60
        
        let card = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        //vw.image = UIImage(named: "YourPictureHere")
        card.center = view.center
        view.addSubview(card)
        card.backgroundColor = UIColor(red: 0.39, green: 0.07, blue: 0.13, alpha: 1.00)
        card.layer.shadowOpacity = 1
        card.layer.cornerRadius = 10
        card.layer.shadowColor = UIColor.red.cgColor
        
        
        let shadowRadius: CGFloat = 20
        card.layer.shadowRadius = shadowRadius
        card.layer.shadowOffset = CGSize(width: 0, height: 20)
        card.layer.shadowOpacity = 0.5
        
        // how strong to make the curling effect
        let curveAmount: CGFloat = 20
        let shadowPath = UIBezierPath()
        
        // the top left and right edges match our view, indented by the shadow radius
        shadowPath.move(to: CGPoint(x: shadowRadius, y: 0))
        shadowPath.addLine(to: CGPoint(x: width - shadowRadius, y: 0))
        
        // the bottom-right edge of our shadow should overshoot by the size of our curve
        shadowPath.addLine(to: CGPoint(x: width - shadowRadius, y: height + curveAmount))
        
        // the bottom-left edge also overshoots by the size of our curve, but is added with a curve back up towards the view
        shadowPath.addCurve(to: CGPoint(x: shadowRadius, y: height + curveAmount), controlPoint1: CGPoint(x: width, y: height - shadowRadius), controlPoint2: CGPoint(x: 0, y: height - shadowRadius))
        card.layer.shadowPath = shadowPath.cgPath
        self.worldActiveLabel?.textColor = .white
        card.addSubview(worldActiveLabel)
        card.center = self.worldActiveLabel.center
    }
    
    
    func makeAlert(alertTitle: String, alertMessage: String){
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            (UIAlertAction) in print("OK button clicked")
        }
        
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func getLastSevenDayData(country: String){
        let request = AF.request("\(endpoint)\(country)", requestModifier: { $0.timeoutInterval = 5 }).validate()
        request.responseJSON { (data) in
            // print(data)
        }
        
        request.responseDecodable(of: [CountryModel].self) { (response) in
            switch response.result {
            case .success(let models):
                if models.count > 0 {
                    let count =  models.count
                    for index in (count - 7)...(count - 1){
                        self.worldSevenDeathsVariable.append(models[index].deaths)
                        print(self.worldSevenDeathsVariable)
                    }
                }
            case .failure(let error):
                do {
                    self.makeAlert(alertTitle: "We are sorry...", alertMessage: "Something went wrong!")
                    //print(error)
                    
                }
            }
            
        }
    }
    
    @IBAction func worldGraphButton(_ sender: UIButton) {
        // getLastSevenDayData(country: chosenCountry)
        self.performSegue(withIdentifier: "fromWorldDetail", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromWorldDetail" {
            let graphVC = segue.destination as! MapViewController
            graphVC.fromSevenDeathsVariable = worldSevenDeathsVariable
        }
    }
    
    
}




