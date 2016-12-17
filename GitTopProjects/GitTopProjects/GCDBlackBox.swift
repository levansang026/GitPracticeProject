//
//  GCDBlackBox.swift
//  GitTopProjects
//
//  Created by bill on 12/15/16.
//  Copyright © 2016 bill. All rights reserved.
//

import Foundation

func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
