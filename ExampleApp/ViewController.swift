import UIKit
import CubicEquationSolver

private func round(_ target: Float, quality: CGFloat) -> CGFloat {
    return round(CGFloat(target) * quality) / quality
}

final class ViewController: UIViewController {

    @IBOutlet private var graphView: GraphView!
    @IBOutlet private var rootsLabel: UILabel!
    @IBOutlet private var scaleSlider: UISlider!
    @IBOutlet private var scaleTextField: UITextField!
    @IBOutlet private var aSlider: UISlider!
    @IBOutlet private var aTextField: UITextField!
    @IBOutlet private var bSlider: UISlider!
    @IBOutlet private var bTextField: UITextField!
    @IBOutlet private var cSlider: UISlider!
    @IBOutlet private var cTextField: UITextField!
    @IBOutlet private var dSlider: UISlider!
    @IBOutlet private var dTextField: UITextField!

    private var cubicPolynomialFromSliderValues: CubicPolynomial {
        return CubicPolynomial(a: Double(aSlider?.value ?? 0.0), b: Double(bSlider?.value ?? 0.0), c: Double(cSlider?.value ?? 0.0), d: Double(dSlider?.value ?? 0.0))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        scaleSlider.value = Float(graphView.scale)
        scaleTextField.text = String(format: "%.2f", graphView.scale)

        updateRootsLabel()
        updateControls(for: graphView.cubicPolynomial)
    }

    private func updateRootsLabel() {
        var string = "roots: ["
        for root in graphView.cubicPolynomial.roots {
            string += String(format: "%.2f", root)
            string += ", "
        }
        string.removeLast(2)
        string += "]"
        rootsLabel.text = string
    }

    private func updateControls(for cubicPolynomial: CubicPolynomial) {
        aSlider.value = Float(cubicPolynomial.a)
        bSlider.value = Float(cubicPolynomial.b)
        cSlider.value = Float(cubicPolynomial.c)
        dSlider.value = Float(cubicPolynomial.d)
        aTextField.text = String(format: "%.2f", cubicPolynomial.a)
        bTextField.text = String(format: "%.2f", cubicPolynomial.b)
        cTextField.text = String(format: "%.2f", cubicPolynomial.c)
        dTextField.text = String(format: "%.2f", cubicPolynomial.d)
    }

    @IBAction private func valueChangedAnySlider(_ sender: UISlider) {
        switch sender {
        case scaleSlider:
            let value = round(sender.value, quality: 1000.0)
            let string = String(format: "%.2f", value)
            scaleTextField.text = string
            graphView.scale = value
        case aSlider, bSlider, cSlider, dSlider:
            updateControls(for: cubicPolynomialFromSliderValues)
            graphView.cubicPolynomial = cubicPolynomialFromSliderValues
            updateRootsLabel()
        default:
            break
        }
    }

    @IBAction private func editingDidChangeAnyTextField(_ sender: UITextField) {
        switch sender {
        case scaleTextField:
            let minValue = scaleSlider.minimumValue
            let maxValue = scaleSlider.maximumValue
            let value = min(maxValue, max(minValue, Float(sender.text ?? "0.0") ?? 0.0))
            scaleSlider.value = value
            graphView.scale = CGFloat(value)
        case aTextField:
            let minValue = aSlider.minimumValue
            let maxValue = aSlider.maximumValue
            aSlider.value = min(maxValue, max(minValue, Float(sender.text ?? "0.0") ?? 0.0))
            graphView.cubicPolynomial = cubicPolynomialFromSliderValues
            updateRootsLabel()
        case bTextField:
            let minValue = bSlider.minimumValue
            let maxValue = bSlider.maximumValue
            bSlider.value = min(maxValue, max(minValue, Float(sender.text ?? "0.0") ?? 0.0))
            graphView.cubicPolynomial = cubicPolynomialFromSliderValues
            updateRootsLabel()
        case cTextField:
            let minValue = cSlider.minimumValue
            let maxValue = cSlider.maximumValue
            cSlider.value = min(maxValue, max(minValue, Float(sender.text ?? "0.0") ?? 0.0))
            graphView.cubicPolynomial = cubicPolynomialFromSliderValues
            updateRootsLabel()
        case dTextField:
            let minValue = dSlider.minimumValue
            let maxValue = dSlider.maximumValue
            dSlider.value = min(maxValue, max(minValue, Float(sender.text ?? "0.0") ?? 0.0))
            graphView.cubicPolynomial = cubicPolynomialFromSliderValues
            updateRootsLabel()
        default:
            break
        }
    }

    @IBAction private func editingDidEndAnyTextField(_ sender: UITextField) {
        scaleTextField.text = String(format: "%.2f", graphView.scale)
        updateControls(for: cubicPolynomialFromSliderValues)
    }

}
