import UIKit

final class GraphView: UIView {

    var cubicPolynomial = CubicPolynomial(a: 2.0, b: 0.0, c: -2.0, d: 0.0) { didSet { setNeedsDisplay() } }

    // var p: Double = 0.0 { didSet { setNeedsDisplay() } }
    var origin: CGPoint = .zero { didSet { setNeedsDisplay() } }
    var scale: CGFloat = 0.5 { didSet { setNeedsDisplay() } }
    var resolution: Int = 1000 { didSet { setNeedsDisplay() } }

    var lineColor: UIColor = .black { didSet { setNeedsDisplay() } }
    var lineWidth: CGFloat = 2.0 { didSet { setNeedsDisplay() } }
    var pointColor: UIColor = .red { didSet { setNeedsDisplay() } }
    var pointRadius: CGFloat = 0.03 { didSet { setNeedsDisplay() } }
    var coordinateLineColor: UIColor = .lightGray { didSet { setNeedsDisplay() } }
    var coordinateLineWidth: CGFloat = 1.0 { didSet { setNeedsDisplay() } }

    private func updateOrigin(location: CGPoint) {
        let x = (location.x / bounds.width - 0.5) * 2.0
        let y = (1.0 - location.y / bounds.height - 0.5) * 2.0
        origin = CGPoint(x: x, y: y)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: self) {
            updateOrigin(location: location)
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: self) {
            updateOrigin(location: location)
        }
    }

    private func transform(for rect: CGRect) -> CGAffineTransform {
        return CGAffineTransform(a: rect.width / 2.0, b: 0.0, c: 0.0, d: -rect.height / 2.0, tx: rect.width / 2.0, ty: rect.height / 2.0)
    }

    override func draw(_ rect: CGRect) {
        let t = transform(for: rect)

        // Top
        coordinateLineColor.setStroke()
        let topLine = UIBezierPath()
        topLine.lineWidth = coordinateLineWidth
        topLine.move(to: CGPoint(x: -1.0, y: 1.0))
        topLine.addLine(to: CGPoint(x: 1.0, y: 1.0))
        topLine.apply(t)
        topLine.stroke()

        // Bottom
        coordinateLineColor.setStroke()
        let bottomLine = UIBezierPath()
        bottomLine.lineWidth = coordinateLineWidth
        bottomLine.move(to: CGPoint(x: -1.0, y: -1.0))
        bottomLine.addLine(to: CGPoint(x: 1.0, y: -1.0))
        bottomLine.apply(t)
        bottomLine.stroke()

        // Left
        coordinateLineColor.setStroke()
        let leftLine = UIBezierPath()
        leftLine.lineWidth = coordinateLineWidth
        leftLine.move(to: CGPoint(x: -1.0, y: -1.0))
        leftLine.addLine(to: CGPoint(x: -1.0, y: 1.0))
        leftLine.apply(t)
        leftLine.stroke()

        // Right
        coordinateLineColor.setStroke()
        let rightLine = UIBezierPath()
        rightLine.lineWidth = lineWidth
        rightLine.move(to: CGPoint(x: 1.0, y: -1.0))
        rightLine.addLine(to: CGPoint(x: 1.0, y: 1.0))
        rightLine.apply(t)
        rightLine.stroke()

        // y = 0.0, x axis
        coordinateLineColor.setStroke()
        let xAxisLine = UIBezierPath()
        xAxisLine.lineWidth = coordinateLineWidth
        xAxisLine.move(to: CGPoint(x: -1.0, y: origin.y))
        xAxisLine.addLine(to: CGPoint(x: 1.0, y: origin.y))
        xAxisLine.apply(t)
        xAxisLine.stroke()

        // x = 0.0, y axis
        coordinateLineColor.setStroke()
        let yAxisLine = UIBezierPath()
        yAxisLine.lineWidth = coordinateLineWidth
        yAxisLine.move(to: CGPoint(x: origin.x, y: -1.0))
        yAxisLine.addLine(to: CGPoint(x: origin.x, y: 1.0))
        yAxisLine.apply(t)
        yAxisLine.stroke()

        // Graph
        let minX = (1.0 / scale) * (-1.0 - origin.x)
        let maxX = (1.0 / scale) * (1.0 - origin.x)
        lineColor.setStroke()
        let path = UIBezierPath()
        path.lineWidth = lineWidth
        path.move(to: cubicPolynomial.point(for: minX))
        Array(0...resolution).forEach {
            let x = CGFloat($0) / CGFloat(resolution) * (maxX - minX) + minX
            let p = cubicPolynomial.point(for: x)
            path.addLine(to: p)
        }
        path.apply(CGAffineTransform(scaleX: scale, y: scale))
        path.apply(CGAffineTransform(translationX: origin.x, y: origin.y))
        path.apply(t)
        path.stroke()

        for root in cubicPolynomial.roots {
            pointColor.setFill()
            let pointCircle = UIBezierPath(arcCenter: CGPoint(x: root, y: 0.0), radius: pointRadius / scale, startAngle: 0.0, endAngle: 2.0 * CGFloat.pi, clockwise: false)
            pointCircle.lineWidth = lineWidth
            pointCircle.close()
            pointCircle.apply(CGAffineTransform(scaleX: scale, y: scale))
            pointCircle.apply(CGAffineTransform(translationX: origin.x, y: origin.y))
            pointCircle.apply(t)
            pointCircle.fill()
        }
    }

}
