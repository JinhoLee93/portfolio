import UIKit

protocol RecordButtonDelegate: AnyObject {
    func actionStartRecording(isRecording: Bool)
}

@IBDesignable class RecordButton: UIView {
    private var isRecording = false
    private var sideOfSquare: CGFloat?
    private var gradientLayer: CAGradientLayer?
    
    weak var delegate: RecordButtonDelegate?
    
    override open func prepareForInterfaceBuilder() {
        self.backgroundColor = .clear
        drawButton()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        drawButton()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .clear
        drawButton()
    }
    
    func drawButton() {
        let width = self.bounds.width, height = self.bounds.height
        drawOuterCircle(width: width, height: height)
        drawInnerSquare(width: width, height: height)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(startRecordingButtonTapped(_:))))
    }
    
    private func drawOuterCircle(width: CGFloat, height: CGFloat) {
        let outerCircleLayer = CAShapeLayer()
        let radius = min(width, height)/2
        let lineWidth = radius/10
        outerCircleLayer.path = UIBezierPath(arcCenter: CGPoint(x: width/2,
                                                                y: height/2),
                                        radius: radius,
                                        startAngle: 0,
                                        endAngle: CGFloat(Float.pi * 2),
                                        clockwise: true).cgPath
        outerCircleLayer.lineWidth = lineWidth
        outerCircleLayer.fillColor = UIColor.clear.cgColor
        outerCircleLayer.strokeColor = UIColor.white.cgColor
        
        self.layer.addSublayer(outerCircleLayer)
    }
    
    private func drawInnerSquare(width: CGFloat, height: CGFloat) {
        sideOfSquare = min(width, height) * 0.8
        guard let sideOfSquare = self.sideOfSquare else { return }
        
        let squareFrame = CGRect(x: width/2-sideOfSquare/2,
                                 y: height/2-sideOfSquare/2,
                                 width: sideOfSquare,
                                 height: sideOfSquare)
        
        addGradientsAnimated(frame: squareFrame)
    }
    
    private func addGradientsAnimated(frame: CGRect) {
        guard let sideOfSquare = self.sideOfSquare else { return }
        
        let fromColors = [UIColor.cyan, UIColor.blue]
        let toColors = [UIColor.purple, UIColor.systemPink]
        
        gradientLayer = CAGradientLayer()
        gradientLayer?.colors = fromColors.map { $0.cgColor }
        gradientLayer?.startPoint = CGPoint(x: 0.2, y: 0.6)
        gradientLayer?.endPoint = CGPoint(x: 0.6, y: 0.2)
        gradientLayer?.frame = frame
        gradientLayer?.cornerRadius = sideOfSquare/2
        
        let gradientsAnimated = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.colors))
        gradientsAnimated.fromValue = gradientLayer?.colors
        gradientsAnimated.toValue = toColors.map { $0.cgColor }
        gradientsAnimated.duration = 4.0
        gradientsAnimated.repeatCount = .infinity
        gradientsAnimated.isRemovedOnCompletion = false
        gradientsAnimated.timingFunction = CAMediaTimingFunction(name: .linear)
        gradientsAnimated.autoreverses = true
        
        gradientLayer?.add(gradientsAnimated, forKey: "colors")
        
        guard let gradientLayer = self.gradientLayer else { return }

        self.layer.addSublayer(gradientLayer)
    }
    
    private func animateRecordButtonWhenTapped() -> CAAnimationGroup {
        guard let sideOfSquare = self.sideOfSquare else { return CAAnimationGroup() }
        
        let transformToStopButton = CABasicAnimation(keyPath: "cornerRadius")
        transformToStopButton.fromValue = !isRecording ? sideOfSquare/2 : 10
        transformToStopButton.toValue = !isRecording ? 10 : sideOfSquare/2
        
        let toSmallCircle = CABasicAnimation(keyPath: "transform.scale")
        toSmallCircle.fromValue = !isRecording ? 1 : 0.5
        toSmallCircle.toValue = !isRecording ? 0.5 : 1
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [transformToStopButton, toSmallCircle]
        animationGroup.duration = 0.2
        animationGroup.fillMode = .both
        animationGroup.isRemovedOnCompletion = false
        
        return animationGroup
    }
    
    private func startRecording(isRecording: Bool) {
        self.isRecording = !isRecording
    }
    
    public func stopRecording() {
        gradientLayer?.add(animateRecordButtonWhenTapped(), forKey: "")
        isRecording = !isRecording
    }
    
    @objc func startRecordingButtonTapped(_ sender: UITapGestureRecognizer) {
        gradientLayer?.add(animateRecordButtonWhenTapped(), forKey: "")
        isRecording = !isRecording
        delegate?.actionStartRecording(isRecording: isRecording)
    }
}
