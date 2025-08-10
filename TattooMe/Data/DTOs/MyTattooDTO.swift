//
//  MyTattooResultsDTO.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 05/07/2025.
//

struct MyTattooDTO: Codable, DomainMappable{
    var imageUrl: String
    
    func toDomain() -> MyTattoo {
          MyTattoo(MyTattooName: "my tattoo", MyTattooUrl: imageUrl)
      }
}
