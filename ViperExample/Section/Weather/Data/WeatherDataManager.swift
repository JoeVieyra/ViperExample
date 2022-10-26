//
//  WeatherDataManager.swift
//  ViperExample
//
//  Created by Mariana Ramos on 28/09/22.
//  

import Foundation

protocol WeatherDataManagerProtocol {
    func actualizarClima(clima: Principal)
    
}

class WeatherDataManager {
    let climaURL = "https://api.weatherbit.io/v2.0/current?key=83ccdaa1354942d5af5fe30f29c906ff&include=minutely&lang=es"
    var delegado: WeatherDataManagerProtocol?
    func buscarClima(ciudad: String)
    {
        let urlString = "\(climaURL)&city=\(ciudad)"
        realizarBusqueda(urlString: urlString)
    }
    
    func realizarBusqueda(urlString: String)
    {
        //crear URL
        if let url = URL(string: urlString){
            //crear una sesion
            let sesion = URLSession(configuration: .default)
            //asignar tarea
            let tarea = sesion.dataTask(with: url) {(datos, respuesta, error) in
                
                if error != nil {
                    print("error al obtener datos: \(error!)")
                    return
                }
                if let datosSeguros = datos {
                    //parsear JSON
                    if let objClima = self.parsearJSON(datosClima: datosSeguros)
                    {
                       print(objClima)
                        self.delegado?.actualizarClima(clima: objClima)
                    }
                }
            }
            //iniciar la tarea
            tarea.resume()
        }
    }
    func parsearJSON(datosClima: Data) -> Principal?{
        //crear un decodificador JSON
        let decodificador = JSONDecoder()
        do{
            let datosDecodificados = try
            decodificador.decode(Principal.self, from: datosClima)
            return datosDecodificados
        }
        catch {
            print("Error al decodificar \(error.localizedDescription)")
            return nil
        }
    }
}

extension WeatherDataManager: WeatherDataManagerProtocol {
    func actualizarClima(clima: Principal) {
        
    }
}
