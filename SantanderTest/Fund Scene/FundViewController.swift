//
//  FundViewController.swift
//  SantanderTest
//
//  Created by Lucas Pelinzon on 24/09/19.
//  Copyright (c) 2019 Lucas Pelinzon. All rights reserved.
//

import UIKit
import SafariServices

protocol FundDisplayLogic: class {
    func updateView(with data: FundModel)
}

class FundViewController: UIViewController, FundDisplayLogic {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var viewTitle: UILabel!
    @IBOutlet weak var fundName: UILabel!
    @IBOutlet weak var whatIs: UILabel!
    @IBOutlet weak var fundDescription: UILabel!
    @IBOutlet weak var riskTitle: UILabel!

    @IBOutlet weak var veryLowRiskArrow: UIImageView!
    @IBOutlet weak var lowRiskArrow: UIImageView!
    @IBOutlet weak var mediumRiskArrow: UIImageView!
    @IBOutlet weak var highRiskArrow: UIImageView!
    @IBOutlet weak var veryHighRiskArrow: UIImageView!

    @IBOutlet weak var veryLowRisk: UIView!
    @IBOutlet weak var lowRisk: UIView!
    @IBOutlet weak var mediumRisk: UIView!
    @IBOutlet weak var highRisk: UIView!
    @IBOutlet weak var veryHighRisk: UIView!

    @IBOutlet weak var veryLowRiskHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lowRiskHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var mediumRiskHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var highRiskHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var veryHighRiskHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var moreInfo: UILabel!

    @IBOutlet weak var fundMonthlyEarnings: UILabel!
    @IBOutlet weak var fundYearlyEarnings: UILabel!
    @IBOutlet weak var fundTwelveMonthsEarnings: UILabel!

    @IBOutlet weak var cdiMonthlyEarnings: UILabel!
    @IBOutlet weak var cdiYearlyEarnings: UILabel!
    @IBOutlet weak var cdiTwelveMonthsEarnings: UILabel!

    @IBOutlet weak var adminFeeName: UILabel!
    @IBOutlet weak var initialApplicationName: UILabel!
    @IBOutlet weak var minimumMovingAmountName: UILabel!
    @IBOutlet weak var minimumBalanceName: UILabel!
    @IBOutlet weak var withdrawDateName: UILabel!
    @IBOutlet weak var quotaDateName: UILabel!
    @IBOutlet weak var paymentDateName: UILabel!
    @IBOutlet weak var essentialsName: UILabel!
    @IBOutlet weak var performanceName: UILabel!
    @IBOutlet weak var complementsName: UILabel!
    @IBOutlet weak var regulationName: UILabel!
    @IBOutlet weak var consentTermName: UILabel!

    @IBOutlet weak var adminFeeValue: UILabel!
    @IBOutlet weak var initialApplicationValue: UILabel!
    @IBOutlet weak var minimumMovingAmountValue: UILabel!
    @IBOutlet weak var minimumBalanceValue: UILabel!
    @IBOutlet weak var withdrawDateValue: UILabel!
    @IBOutlet weak var quotaDateValue: UILabel!
    @IBOutlet weak var paymentDateValue: UILabel!

    @IBOutlet weak var investButton: UIButton!

    @IBAction func downloadInfo(_ sender: UIButton) {
        let url = URL(string: "https://www.google.com")!
        present(SFSafariViewController(url: url), animated: true)
    }

    @IBAction func investButtonPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.25, animations: {
            sender.alpha = 0.6
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }, completion: {_ in
            UIView.animate(withDuration: 0.25, animations: {
                sender.alpha = 1
                sender.transform = .identity
            })
        })
    }

    var interactor = FundInteractor()
    var presenter = FundPresenter()

    func updateView(with data: FundModel) {
        viewTitle.text = data.screen.title
        fundName.text = data.screen.fundName
        whatIs.text = data.screen.whatIs
        fundDescription.text = data.screen.definition
        riskTitle.text = data.screen.riskTitle

        switch data.screen.risk {
        case 1:
            veryLowRiskArrow.alpha = 1
        case 2:
            lowRiskArrow.alpha = 1
        case 3:
            mediumRiskArrow.alpha = 1
        case 4:
            highRiskArrow.alpha = 1
            highRiskHeightConstraint.constant = 10
        case 5:
            veryHighRiskArrow.alpha = 1
        default:
            print("Invalid Risk")
        }

        moreInfo.text = data.screen.infoTitle

        fundMonthlyEarnings.text = "\(data.screen.moreInfo.month.fund)%"
        fundYearlyEarnings.text = "\(data.screen.moreInfo.year.fund)%"
        fundTwelveMonthsEarnings.text = "\(data.screen.moreInfo.last12Months.fund)%"

        cdiMonthlyEarnings.text = "\(data.screen.moreInfo.month.CDI)%"
        cdiYearlyEarnings.text = "\(data.screen.moreInfo.year.CDI)%"
        cdiTwelveMonthsEarnings.text = "\(data.screen.moreInfo.last12Months.CDI)%"

        adminFeeName.text = data.screen.info[0].name
        adminFeeValue.text = data.screen.info[0].data

        initialApplicationName.text = data.screen.info[1].name
        initialApplicationValue.text = data.screen.info[1].data

        minimumMovingAmountName.text = data.screen.info[2].name
        minimumMovingAmountValue.text = data.screen.info[2].data

        minimumBalanceName.text = data.screen.info[3].name
        minimumBalanceValue.text = data.screen.info[3].data

        withdrawDateName.text = data.screen.info[4].name
        withdrawDateValue.text = data.screen.info[4].data

        quotaDateName.text = data.screen.info[5].name
        quotaDateValue.text = data.screen.info[5].data

        paymentDateName.text = data.screen.info[6].name
        paymentDateValue.text = data.screen.info[6].data

        essentialsName.text = data.screen.downInfo[0].name
        performanceName.text = data.screen.downInfo[1].name
        complementsName.text = data.screen.downInfo[2].name
        regulationName.text = data.screen.downInfo[3].name
        consentTermName.text = data.screen.downInfo[4].name
    }

    // MARK: View Lifecycle
    override func viewDidLoad() {
        presenter.viewController = self
        interactor.presenter = presenter
        investButton.layer.cornerRadius = 25
        veryLowRisk.round(corners: [.bottomLeft, .topLeft], radius: 3)
        veryHighRisk.round(corners: [.bottomRight, .topRight], radius: 3)
    }

    override func viewWillAppear(_ animated: Bool) {
        interactor.refreshData()
    }
}

