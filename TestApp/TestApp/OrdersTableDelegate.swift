//
//  OrdersTableDelegate.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 30.01.2023.
//

import UIKit

class OrdersTableDelegate: NSObject, UITableViewDelegate {
    var orders: [Order] = []
    var coordinator: OrdersCoordinator?
    
    var headerView: HeaderView?
    var headerViewHeightConstraint: NSLayoutConstraint?
    let maxHeaderHeight: CGFloat = UIScreen.main.bounds.size.height/3
    let minHeaderHeight: CGFloat = Constants.Layout.headerViewMinHeight
    var previousScrollOffset: CGFloat = 0
    
    struct Layout {
        public static let headerAnimationDuration = 0.3
        public static let headerAnimationDampingRatio = 0.7
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        coordinator?.didSelectDetailFor(orders[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let headerViewHeightConstr = self.headerViewHeightConstraint else { return }

        let scrollDiff = (scrollView.contentOffset.y - previousScrollOffset)
        let isScrollingDown = scrollDiff > 0
        let isScrollingUp = scrollDiff < 0
        var newHeight = headerViewHeightConstr.constant
        if isScrollingDown {
            newHeight = max(minHeaderHeight, headerViewHeightConstr.constant - abs(scrollDiff))
        } else if isScrollingUp {
            newHeight = min(maxHeaderHeight, headerViewHeightConstr.constant + abs(scrollDiff))
        }
        if newHeight != headerViewHeightConstr.constant {
            headerViewHeightConstr.constant = newHeight
            setPosition(scrollView: scrollView)
            previousScrollOffset = scrollView.contentOffset.y
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard !decelerate, let _ = self.headerViewHeightConstraint?.constant else {
            return
        }
        
        animateHeader(scrollView: scrollView)
    }
}

private extension OrdersTableDelegate {
    func canAnimateHeader (_ scrollView: UIScrollView) -> Bool {
        guard let headerViewHeight = self.headerViewHeightConstraint else { return false }
            let scrollViewMaxHeight = scrollView.frame.height + headerViewHeight.constant - minHeaderHeight
            return scrollView.contentSize.height > scrollViewMaxHeight
        }
    func setPosition(scrollView: UIScrollView) {
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
    
    func animateHeader(scrollView: UIScrollView) {
        let animator = UIViewPropertyAnimator(duration: Layout.headerAnimationDuration, dampingRatio: Layout.headerAnimationDampingRatio)
            animator.addAnimations { [weak self, weak scrollView] in
                guard let self = self else { return }
                self.headerViewHeightConstraint?.constant = self.minHeaderHeight
                scrollView?.superview?.layoutIfNeeded()
            }
            animator.startAnimation()
        }

    func determineAlpha(_ scrollView: UIScrollView) {
        guard let headerHeightConstraint = headerViewHeightConstraint?.constant else { return }
        let percentage = headerHeightConstraint / self.minHeaderHeight
        headerView?.changeAlpha(2.0 - percentage)
    }
}
