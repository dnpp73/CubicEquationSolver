import UIKit
import CubicEquationSolver

private func round(_ target: Float, quality: CGFloat) -> CGFloat {
    return round(CGFloat(target) * quality) / quality
}

final class ViewController: UIViewController {

    @IBOutlet private var graphView: GraphView!
    @IBOutlet private var rootsLabel: UILabel!
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
        updateRootsLabel()
        updateControls(for: graphView.cubicPolynomial)
    }

    private func updateRootsLabel() {
        let roots = graphView.cubicPolynomial.roots
        if roots.count == 0 {
            rootsLabel.text = "no roots found"
            return
        }
        var string = "roots: ["
        for root in roots.sorted() {
            if round(root * 10000.0) / 10000.0 == 0.0 {
                string += "0.0"
            } else {
                string += String(format: "%.6f", root)
            }
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
        updateControls(for: cubicPolynomialFromSliderValues)
        graphView.cubicPolynomial = cubicPolynomialFromSliderValues
        updateRootsLabel()
    }

    @IBAction private func editingDidChangeAnyTextField(_ sender: UITextField) {
        let slider: UISlider
        switch sender {
        case aTextField:
            slider = aSlider
        case bTextField:
            slider = bSlider
        case cTextField:
            slider = cSlider
        case dTextField:
            slider = dSlider
        default:
            return
        }
        let minValue = slider.minimumValue
        let maxValue = slider.maximumValue
        slider.value = min(maxValue, max(minValue, Float(sender.text ?? "0.0") ?? 0.0))
        graphView.cubicPolynomial = cubicPolynomialFromSliderValues
        updateRootsLabel()
    }

    @IBAction private func editingDidEndAnyTextField(_ sender: UITextField) {
        updateControls(for: cubicPolynomialFromSliderValues)
    }

}
