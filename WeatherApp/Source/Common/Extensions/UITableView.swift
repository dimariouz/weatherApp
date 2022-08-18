//
//  UITableView.swift
//  WeatherApp
//
//  Created by Dmitry Doroshchuk on 17.08.2022.
//

import UIKit

extension UITableView {
    
    func register(nibs: [UITableViewCell.Type]) {
        for cell in nibs {
            let nib = UINib(nibName: cell.reuseIdentifier, bundle: nil)
            self.register(nib, forCellReuseIdentifier: cell.reuseIdentifier)
        }
    }
    
    func register(cells: [UITableViewCell.Type]) {
        for cell in cells {
            self.register(cell, forCellReuseIdentifier: cell.reuseIdentifier)
        }
    }
    
    func dequeue<T: UITableViewCell>(cellClass: T.Type,
                                          forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: cellClass.reuseIdentifier, for: indexPath) as? T else {
            fatalError(
                "Error: cell with id: \(cellClass.reuseIdentifier) for indexPath: \(indexPath) is not \(T.self)")
        }
        return cell
    }
}
