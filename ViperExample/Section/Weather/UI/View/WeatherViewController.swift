//
//  WeatherViewController.swift
//  ViperExample
//
//  Created by Mariana Ramos on 28/09/22.
//  

import UIKit

protocol WeatherViewControllerProtocol: AnyObject {
    
    
}

class WeatherViewController: UIViewController,UITextFieldDelegate, WeatherDataManagerProtocol {
    
    var climaManager = WeatherDataManager()
    var Climas: Principal?
    
    @IBOutlet weak var ciudadTF: UITextField!
    @IBOutlet weak var condicionClimaImg: UIImageView!
    @IBOutlet weak var temperaturaLabel: UILabel!
    @IBOutlet weak var cuidadLabel: UILabel!
  
    
    @IBOutlet weak var DataTable: UITableView!
    
    @IBOutlet weak var TablaDatos: UITableViewCell!
    
    private let presenter: WeatherPresenterProtocol
    
    init(presenter: WeatherPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: String(describing: WeatherViewController.self), bundle: Bundle.main)
        self.presenter.setViewProtocol(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    
        
        DataTable.register(UINib(nibName: "WeatherCellTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        climaManager.delegado = self
        ciudadTF.delegate = self
        DataTable.dataSource = self
        DataTable.delegate = self
    }
    @IBAction func buscarB(_ sender: UIButton)
    {
        ciudadTF.endEditing(true)
    }
    //MARK: - metodos del delegado
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        //ocultar el teclado
        ciudadTF.endEditing(true)
        //MARK: - Acer bsuqueda en Api
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        if ciudadTF.text != ""
        {
            return true
        }else{
            ciudadTF.placeholder = "Escribe algo.."
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        climaManager.buscarClima(ciudad: ciudadTF.text!)
        cuidadLabel.text = ciudadTF.text
        //limpia el textField
        ciudadTF.text = ""
    }
    private func configureView() {
        
    }
}

extension WeatherViewController: WeatherViewControllerProtocol {
    func actualizarClima(clima: Principal) {
        Climas = clima
         DispatchQueue.main.async {
             
             let x:Principal = clima
             x.data.forEach{ obj in
           self.temperaturaLabel.text = obj.tempString
            self.cuidadLabel.text = clima.data[0].city_name
                 self.condicionClimaImg.image = UIImage(systemName: clima.data[0].weather.condicionClima)
             }
             
         }
    }
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Climas?.minutely.count ?? 1
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = DataTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        as! WeatherCellTableViewCell
        
        celda.timeTemp.text = "\(Climas?.minutely[indexPath.row].timestamp_utc ?? "")"
        celda.ts.text = "\(Climas?.minutely[indexPath.row].tsString ?? "")"
        return celda

    

}
}
