//
//  LocationViewController.swift
//  CoronavirusStats

import UIKit
import Alamofire
import Lottie

class LocationViewController: UIViewController{
    
    let locale = Locale.current
    
    let endpoint = URL(string: "https://api.covid19api.com/country/")!
    
    @IBOutlet weak var countryNameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var confirmedLabel: UILabel!
    
    @IBOutlet weak var deathsLabel: UILabel!
    
    @IBOutlet weak var recoveredLabel: UILabel!
    
    @IBOutlet weak var activeLabel: UILabel!
    
    var worldDataDetailViewController = WorldDataDetailViewController()
    
    var updatedData = false
    
    var sevenDeathsVariable = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.faceMaskAnimation()

      //  getData(country: locale.regionCode!)
        getData(country: "TR")
        
        getLastSevenDayData(country: "TR")

        self.view.backgroundColor = .lightGray
        
        self.tabBarController?.tabBar.barTintColor = UIColor(red: 0.47, green: 0.00, blue: 0.09, alpha: 1.00)
        UITabBar.appearance().tintColor = .white
        addCardCountry()
        addCardConfirmed()
        addCardDate()
        addCardDeaths()
        addCardRecovered()
        addCardActive()

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.faceMaskAnimation()
    }

    
    func getData(country: String){

        let request = AF.request("\(endpoint)\(country)", requestModifier: { $0.timeoutInterval = 5 }).validate()
        request.responseJSON { (data) in
            // print(data)
        }
        
        request.responseDecodable(of: [CountryModel].self) { (response) in
            switch response.result {
            case .success(let model):
                if model.count > 0 {
                    
                    self.countryNameLabel.text = "Country: \(model.last!.country)"
                    print("Country: \(model.last!.country)")
                    
                    self.dateLabel.text = "Date: \(model.last!.date)"
                    print("Date: \(model.last!.date)")
                    
                    self.confirmedLabel.text = "Confirmed: \(model.last!.confirmed)"
                    print("Confirmed: \(model.last!.confirmed)")
                    
                    
                    self.deathsLabel.text = "Deaths: \(model.last!.deaths)"
                    print("Deaths: \(model.last!.deaths)")
                    
                    self.recoveredLabel.text = "Recovered: \(model.last!.recovered)"
                    print("Recovered: \(model.last!.recovered)")
                    
                    
                    self.activeLabel.text = "Active: \(model.last!.active)"
                    print("Active: \(model.last!.active)")
                    
                    self.updatedData = true
                    
                } else {
                    self.worldDataDetailViewController.makeAlert(alertTitle: "We are sorry...", alertMessage: "We do not have data for this country")
                }
                
            case .failure(let error):
                do {
                    self.worldDataDetailViewController.makeAlert(alertTitle: "We are sorry...", alertMessage: "Something went wrong!")
                    //print(error)
                    
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
        
        self.countryNameLabel.textColor = .white
        
        card.addSubview(countryNameLabel)
        card.center = self.countryNameLabel.center
        
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
        
        self.dateLabel.textColor = .white
        
        card.addSubview(dateLabel)
        card.center = self.dateLabel.center
        
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
        
        self.confirmedLabel.textColor = .white
        
        card.addSubview(confirmedLabel)
        card.center = self.confirmedLabel.center
        
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
        
        self.deathsLabel.textColor = .white
        
        card.addSubview(deathsLabel)
        card.center = self.deathsLabel.center
        
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
        
        self.recoveredLabel.textColor = .white
        
        card.addSubview(recoveredLabel)
        card.center = self.recoveredLabel.center
        
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
        
        self.activeLabel.textColor = .white
        
        card.addSubview(activeLabel)
        card.center = self.activeLabel.center
        
    }
    
    func faceMaskAnimation(){
        let jsonName = "faceMask"
        let animation = Animation.named(jsonName)
        let width = view.frame.width
        let height = view.frame.height
        
        // Load animation to AnimationView
        let animationView = AnimationView(animation: animation)
        animationView.frame = CGRect(x: width / 2 - 75 , y: height - 265, width: 150, height: 150)
        
        // Add animationView as subview
        view.addSubview(animationView)
        
        // Play the animation
        animationView.loopMode = .loop
        animationView.play()
        
        
        
        
        
        //
        
        
        
        // animasyon üst üste biniyor
        // https://cocoacasts.com/what-is-a-singleton-and-how-to-create-one-in-swift
        // private olması gibi tek sefer oluşturmaya bak !!!
        
        
       
    }
    
    func getLastSevenDayData(country: String){
        let request = AF.request("\(endpoint)\(country)", requestModifier: { $0.timeoutInterval = 5 }).validate()
        request.responseJSON { (data) in
            // print(data)
        }
        
        request.responseDecodable(of: [CountryModel].self) { (response) in
            switch response.result {
            case .success(let models):
                let count =  models.count
                for index in (count - 7)...(count - 1){
                    self.sevenDeathsVariable.append(models[index].deaths)
                    print(self.sevenDeathsVariable)
                }

            case .failure(let error):
                do {
                    self.worldDataDetailViewController.makeAlert(alertTitle: "We are sorry...", alertMessage: "Something went wrong!")
                    //print(error)
                    
                }
            }
            
        }
        
    
    }
    
    @IBAction func locationGraphButton(_ sender: UIButton) {
        if updatedData {
            getLastSevenDayData(country: "Turkey")
        } else {
            worldDataDetailViewController.makeAlert(alertTitle: "You can get the graph :(", alertMessage: "You selected unreachable country")
            self.performSegue(withIdentifier: "fromLocalCountry", sender: nil)
        }
    }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "fromLocalCountry" {
                let graphVC = segue.destination as! MapViewController
                graphVC.fromSevenDeathsVariable = sevenDeathsVariable
            }
        }
    
    
}





