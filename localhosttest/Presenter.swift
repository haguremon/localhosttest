//
//  Presenter.swift
//  localhosttest
//
//  Created by IwasakIYuta on 2021/08/28.
//

import Foundation

protocol APIDelegate: AnyObject {
    
    func didsetPatient(patient: [Patient])
    
}
 
class TestLocalHost {
    
    weak var delegate: APIDelegate?
    
    func getApi(url: String) {
        guard let url = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let data = data ,
//                  let response = response as? HTTPURLResponse,
//                  response.statusCode == 200,
                 
                  error == nil else { return }
            
            do {
               
                let patient = try JSONDecoder().decode([Patient].self, from: data)
                self?.delegate?.didsetPatient(patient: patient)
           print(patient)
            } catch {
                
                print(error)
           
            }
           
        }
        
        task.resume()
        
    }
    func get(){
         
         getApi(url: "http://localhost:3000/patients")
         
     }
    
    
}
