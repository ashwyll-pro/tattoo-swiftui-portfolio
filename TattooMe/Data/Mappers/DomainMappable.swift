//
//  MyTattooDTOtoDomain.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 09/07/2025.
//

protocol DomainMappable{
    associatedtype DomainMappable
    func toDomain()->DomainMappable
}
