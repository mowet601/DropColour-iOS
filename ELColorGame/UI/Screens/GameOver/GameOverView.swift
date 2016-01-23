//
// Created by Mateusz Szklarek on 23/01/16.
// Copyright (c) 2016 EL Passion. All rights reserved.
//

import UIKit

protocol GameOverViewDelegate: class {

    func gameOverViewDidTapRetry(gameOverView: GameOverView)
    func gameOverViewDidTapShowLeaders(gameOverView: GameOverView)
    func gameOverViewDidTapQuit(gameOverView: GameOverView)

}

class GameOverView: UIView {

    let score: Int

    private weak var delegate: GameOverViewDelegate?

    init(score: Int, delegate: GameOverViewDelegate?) {
        self.score = score
        self.delegate = delegate
        super.init(frame: CGRectZero)
        addSubviews()
        setupLayout()
        configureButtonActions()
        updateScore()
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func updateScore() {
        scoreNumberLabel.text = "\(score)"
    }

    // MARK: Subviews

    private func addSubviews() {
        addSubview(blurEffectView)
        addSubview(scoreView)
        scoreView.addSubview(scoreNumberLabel)
        scoreView.addSubview(scoreTextLabel)
        addSubview(retryButton)
        addSubview(topPlayersButton)
        addSubview(quitButton)
    }

    private let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Dark))
    private let scoreView = UIView(frame: CGRectZero)
    private let retryButton = Button(title: "RETRY", color: UIColor(red:0.38, green:0.87, blue:0.1, alpha:1))
    private let topPlayersButton = Button(title: "TOP PLAYERS", color: UIColor(red:0.33, green:0.78, blue:0.78, alpha:1))
    private let quitButton = Button(title: "QUIT", color: UIColor(red:0.91, green:0.15, blue:0.33, alpha:1))

    private let scoreNumberLabel: UILabel = {
        let label = UILabel(frame: CGRectZero)
        label.font = UIFont(name: BebasNeueBold, size: 60)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = UIColor(red:1, green:1, blue:1, alpha:1)
        return label
    }()

    private let scoreTextLabel: UILabel = {
        let label = UILabel(frame: CGRectZero)
        label.text = "YOUR SCORE"
        label.font = UIFont(name: BebasNeueBold, size: 20)
        label.textColor = UIColor(red:1, green:1, blue:1, alpha:1)
        return label
    }()

    // MARK: Layout

    private func setupLayout() {
        blurEffectView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(0)
        }
        scoreView.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(0).offset(-110)
            make.centerX.equalTo(0)
        }
        scoreNumberLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.centerX.equalTo(0)
            make.left.greaterThanOrEqualTo(0)
            make.right.lessThanOrEqualTo(0)
        }
        scoreTextLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(scoreNumberLabel.snp_bottom)
            make.centerX.equalTo(0)
            make.left.greaterThanOrEqualTo(0)
            make.right.lessThanOrEqualTo(0)
            make.bottom.equalTo(0)
        }
        retryButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(scoreTextLabel.snp_bottom).offset(40)
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.centerX.equalTo(0)
        }
        topPlayersButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(retryButton.snp_bottom).offset(15)
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.centerX.equalTo(0)
        }
        quitButton.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.centerX.equalTo(0)
            make.bottom.equalTo(-40)
        }
    }
    
    // MARK: Button actions

    private func configureButtonActions() {
        retryButton.buttonActionClosure = { [weak self] in
            guard let _self = self else { return }
            _self.delegate?.gameOverViewDidTapRetry(_self)
        }
        topPlayersButton.buttonActionClosure = { [weak self] in
            guard let _self = self else { return }
            _self.delegate?.gameOverViewDidTapShowLeaders(_self)
        }
        quitButton.buttonActionClosure = { [weak self] in
            guard let _self = self else { return }
            _self.delegate?.gameOverViewDidTapQuit(_self)
        }
    }

}