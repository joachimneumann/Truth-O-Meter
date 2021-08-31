////
////  DiskViewModel.swift
////  Truth-O-Meter
////
////  Created by Joachim Neumann on 30/08/2021.
////
//
//import SwiftUI
//
//class DiskViewModel: ObservableObject {
//    let callback: (_: Precision) -> Void
//    var isSetting: Bool
//
//    @Published var disksVisible = true
//    @Published var shapeShifterIsGray = false
//    
//
//    var disks = DiskParameters]()
//    
//    func down(_ precision: Precision) {
//        print("DiskViewModel down()")
//        if !isSetting {
//            disksVisible = false
//        }
//    }
//    
//    func up(_ precision: Precision) {
//        print("DiskViewModel up()")
//        callback(precision)
//        if isSetting {
//            switch precision {
//            case .edge:
//                shapeShifterIsGray       = true
//                diskParameters[0].isGray = false
//                diskParameters[1].isGray = false
//                diskParameters[2].isGray = false
//                diskParameters[3].isGray = false
//            case .outer:
//                shapeShifterIsGray       = false
//                diskParameters[0].isGray = true
//                diskParameters[1].isGray = false
//                diskParameters[2].isGray = false
//                diskParameters[3].isGray = false
//            case .middle:
//                shapeShifterIsGray       = false
//                diskParameters[0].isGray = false
//                diskParameters[1].isGray = true
//                diskParameters[2].isGray = false
//                diskParameters[3].isGray = false
//            case .inner:
//                shapeShifterIsGray       = false
//                diskParameters[0].isGray = false
//                diskParameters[1].isGray = false
//                diskParameters[2].isGray = true
//                diskParameters[3].isGray = false
//            case .bullsEye:
//                shapeShifterIsGray       = false
//                diskParameters[0].isGray = false
//                diskParameters[1].isGray = false
//                diskParameters[2].isGray = false
//                diskParameters[3].isGray = true
//            }
//        }
//    }
//    
//    init(callback: @escaping (_: Precision) -> Void, isSetting: Bool) {
//        self.isSetting = isSetting
//        self.callback = callback
//        diskParameters.append(DiskParameters(.outer))
//        diskParameters.append(DiskParameters(.middle))
//        diskParameters.append(DiskParameters(.inner))
//        diskParameters.append(DiskParameters(.bullsEye))
//    }
//}
