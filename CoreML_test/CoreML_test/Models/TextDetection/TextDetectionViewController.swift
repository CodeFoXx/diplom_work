//
//  TextDetectionViewController.swift
//  CoreML_test
//
//  Created Осина П.М. on 20.03.18.
//  Copyright © 2018 Осина П.М.. All rights reserved.
//

import UIKit
import AVFoundation
import Vision
import TesseractOCR

//class TextDetectionViewController: UIViewController {
//
//    @IBOutlet weak var cameraImageView: UIImageView!
//    @IBOutlet weak var datectedTextLabel: UILabel!
//
//    var session = AVCaptureSession()
//    var request = [VNRequest]()
//    private var tesseract = G8Tesseract(language: "eng", engineMode: .tesseractOnly)
//    private var textObservation = [VNTextObservation]()
//
//    var presenter: TextDetectionPresenter!
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        startLiveVideo()
//        startTextDetection()
//
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
////        startLiveVideo()
////        startTextDetection()
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        self.navigationController?.navigationBar.isHidden = true
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//
//    override func viewDidLayoutSubviews() {
//        cameraImageView.layer.sublayers?[0].frame = cameraImageView.bounds
//    }
//
//    func startLiveVideo(){
//        session.sessionPreset = AVCaptureSession.Preset.photo
//        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
//
//        let deviceInput = try! AVCaptureDeviceInput(device: captureDevice!)
//        let deviceOutput = AVCaptureVideoDataOutput()
//        deviceOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
//        deviceOutput.setSampleBufferDelegate(self, queue: DispatchQueue.global(qos: DispatchQoS.QoSClass.default))
//        session.addInput(deviceInput)
//        session.addOutput(deviceOutput)
//
//        let imageLayer = AVCaptureVideoPreviewLayer(session: session)
//        imageLayer.frame = cameraImageView.bounds
//        cameraImageView.layer.addSublayer(imageLayer)
//
//        session.startRunning()
//    }
//
//    func startTextDetection(){
//        let textRequest = VNDetectTextRectanglesRequest(completionHandler: self.detectTextHandler)
//        textRequest.reportCharacterBoxes = true
//        self.request = [textRequest]
//    }
//
//    func detectTextHandler(request: VNRequest, error: Error?){
//
//        guard let observation = request.results else {
//            print("no result")
//            return
//        }
//
//        let result = observation.map({$0 as? VNTextObservation})
//        textObservation = result as! [VNTextObservation]
//
//        DispatchQueue.main.async() {
//
//            guard let sublayers = self.view.layer.sublayers else {
//                return
//            }
//            for layer in sublayers[1...]{
//                if (layer as? CATextLayer) == nil {
//                    layer.removeFromSuperlayer()
//                }
//            }
//
//            self.cameraImageView.layer.sublayers?.removeSubrange(1...)
//            for region in result {
//                guard let rg = region else {
//                    continue
//                }
//
//                self.highlightWord(box: rg)
//
////                if let boxes = region?.characterBoxes{
////                    for characterBox in boxes{
////                        self.highlightLetters(box: characterBox)
////                    }
////                }
//
//            }
//        }
//    }
//
//    func highlightWord(box: VNTextObservation){
//        guard let boxes = box.characterBoxes else {
//            return
//        }
//
//        var maxX: CGFloat = 9999.0
//        var minX: CGFloat = 0.0
//        var maxY: CGFloat = 9999.0
//        var minY: CGFloat = 0.0
//
//
//        for char in boxes {
//            if char.bottomLeft.x < maxX{
//                maxX = char.bottomLeft.x
//            }
//            if char.bottomRight.x > minX {
//                minX = char.bottomRight.x
//            }
//            if char.bottomRight.y < maxY{
//                maxY = char.bottomRight.y
//            }
//            if char.topRight.y > minY {
//                minY = char.topRight.y
//            }
//        }
//
//        let xCord = maxX * cameraImageView.frame.size.width
//        let yCord = (1 - minY) * cameraImageView.frame.size.height
//        let width = (minX - maxX) * cameraImageView.frame.size.width
//        let height =  (minY - maxY) * cameraImageView.frame.size.width
//
//        let outline = CALayer()
//
//        outline.frame = CGRect(x: xCord, y: yCord, width: width, height: height)
//        outline.borderWidth = 2.0
//        outline.borderColor = UIColor.red.cgColor
//
//        cameraImageView.layer.addSublayer(outline)
//
//    }
//
//
//    func highlightLetters(box: VNRectangleObservation) {
//        let xCord = box.topLeft.x * cameraImageView.frame.size.width
//        let yCord = (1 - box.topLeft.y) * cameraImageView.frame.size.height
//        let width = (box.topRight.x - box.bottomLeft.x) * cameraImageView.frame.size.width
//        let height = (box.topLeft.y - box.bottomLeft.y) * cameraImageView.frame.size.height
//
//        let outline = CALayer()
//        outline.frame = CGRect(x: xCord, y: yCord, width: width, height: height)
//        outline.borderWidth = 1.0
//        outline.borderColor = UIColor.blue.cgColor
//
//        cameraImageView.layer.addSublayer(outline)
//    }
//
//
//}
//
//extension TextDetectionViewController: TextDetectionView, AVCaptureVideoDataOutputSampleBufferDelegate {
//
//    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
//        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
//            return
//        }
//
//        var requestOptions:[VNImageOption : Any] = [:]
//
//        if let camData = CMGetAttachment(sampleBuffer, kCMSampleBufferAttachmentKey_CameraIntrinsicMatrix, nil) {
//            requestOptions = [.cameraIntrinsics:camData]
//        }
//
//        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: CGImagePropertyOrientation(rawValue: 6)!, options: requestOptions)
//
//        do {
//            try imageRequestHandler.perform(self.request)
//        } catch {
//            print(error)
//        }
//    }
//}


protocol TextDetectionVCDelegate {
    
    func stopDetection(controller: String)
}

class TextDetectionViewController: UIViewController {
    
    @IBOutlet weak var preview: Preview!
    var presenter: TextDetectionPresenter!
    
    private var textDetectionRequest: VNDetectTextRectanglesRequest?
    private let session = AVCaptureSession()
    private var textObservations = [VNTextObservation]()
    private var tesseract = G8Tesseract(language: "eng", engineMode: .tesseractOnly)
    var detectedTextArray = [String]()
    var delegateVC: TextDetectionVCDelegate?
    
    
    //    private var preview: Preview {
    //        return view as! Preview
    //    }
    
    @IBAction func stopCamera(_ sender: Any) {
        session.stopRunning()
        presenter.textFromTextDetectionVC(textArray: detectedTextArray)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tesseract?.pageSegmentationMode = .sparseText
        tesseract?.charWhitelist = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890()-+*!/?.,@#$%&"
        
        if isAuthorized() {
            configureTextDetection()
            configureCamera()
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private func configureTextDetection() {
        textDetectionRequest = VNDetectTextRectanglesRequest(completionHandler: handleDetection)
        textDetectionRequest!.reportCharacterBoxes = true
    }
    
    private func configureCamera() {
        
        
        preview.session = session
        
        let cameraDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)
        var cameraDevice: AVCaptureDevice?
        for device in cameraDevices.devices {
            if device.position == .back {
                cameraDevice = device
                break
            }
        }
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: cameraDevice!)
            if session.canAddInput(captureDeviceInput) {
                session.addInput(captureDeviceInput)
            }
        }
        catch {
            print("Error occured \(error)")
            return
        }
        session.sessionPreset = .high
        let videoDataOutput = AVCaptureVideoDataOutput()
        videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "Buffer Queue", qos: .userInteractive, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil))
        if session.canAddOutput(videoDataOutput) {
            session.addOutput(videoDataOutput)
        }
        preview.videoPreviewLayer.videoGravity = .resize
        
        session.startRunning()
    }
    private func handleDetection(request: VNRequest, error: Error?) {
        
        guard let detectionResults = request.results else {
            print("No detection results")
            return
        }
        let textResults = detectionResults.map() {
            return $0 as? VNTextObservation
        }
        if textResults.isEmpty {
            return
        }
        textObservations = textResults as! [VNTextObservation]
        DispatchQueue.main.async {
            
            guard let sublayers = self.preview.layer.sublayers else {
                return
            }
            for layer in sublayers[1...] {
                if (layer as? CATextLayer) == nil {
                    layer.removeFromSuperlayer()
                }
            }
            let viewWidth = self.preview.frame.size.width
            let viewHeight = self.preview.frame.size.height
            for result in textResults {
                
                if let textResult = result {
                    
                    let layer = CALayer()
                    var rect = textResult.boundingBox
                    rect.origin.x *= viewWidth
                    rect.size.height *= viewHeight
                    rect.origin.y = ((1 - rect.origin.y) * viewHeight) - rect.size.height
                    rect.size.width *= viewWidth
                    
                    layer.frame = rect
                    layer.borderWidth = 2
                    layer.borderColor = UIColor.red.cgColor
                    self.preview.layer.addSublayer(layer)
                }
            }
        }
    }
    
    private func isAuthorized() -> Bool {
        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authorizationStatus {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video,
                                          completionHandler: { (granted:Bool) -> Void in
                                            if granted {
                                                DispatchQueue.main.async {
                                                    self.configureTextDetection()
                                                    self.configureCamera()
                                                }
                                            }
            })
            return true
        case .authorized:
            return true
        case .denied, .restricted: return false
        }
    }
}

extension TextDetectionViewController: TextDetectionView, AVCaptureVideoDataOutputSampleBufferDelegate {
    // MARK: - Camera Delegate and Setup
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        var imageRequestOptions = [VNImageOption: Any]()
        if let cameraData = CMGetAttachment(sampleBuffer, kCMSampleBufferAttachmentKey_CameraIntrinsicMatrix, nil) {
            imageRequestOptions[.cameraIntrinsics] = cameraData
        }
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: CGImagePropertyOrientation(rawValue: 6)!, options: imageRequestOptions)
        do {
            try imageRequestHandler.perform([textDetectionRequest!])
        }
        catch {
            print("Error occured \(error)")
        }
        var ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        let transform = ciImage.orientationTransform(for: CGImagePropertyOrientation(rawValue: 6)!)
        ciImage = ciImage.transformed(by: transform)
        let size = ciImage.extent.size
        var recognizedTextPositionTuples = [(rect: CGRect, text: String)]()
        for textObservation in textObservations {
            guard let rects = textObservation.characterBoxes else {
                continue
            }
            var xMin = CGFloat.greatestFiniteMagnitude
            var xMax: CGFloat = 0
            var yMin = CGFloat.greatestFiniteMagnitude
            var yMax: CGFloat = 0
            for rect in rects {
                
                xMin = min(xMin, rect.bottomLeft.x)
                xMax = max(xMax, rect.bottomRight.x)
                yMin = min(yMin, rect.bottomRight.y)
                yMax = max(yMax, rect.topRight.y)
            }
            let imageRect = CGRect(x: xMin * size.width, y: yMin * size.height, width: (xMax - xMin) * size.width, height: (yMax - yMin) * size.height)
            let context = CIContext(options: nil)
            guard let cgImage = context.createCGImage(ciImage, from: imageRect) else {
                continue
            }
            let uiImage = UIImage(cgImage: cgImage)
            tesseract?.image = uiImage
            tesseract?.recognize()
            guard var text = tesseract?.recognizedText else {
                continue
            }
            text = text.trimmingCharacters(in: CharacterSet.newlines)
            if !text.isEmpty {
                let x = xMin
                let y = 1 - yMax
                let width = xMax - xMin
                let height = yMax - yMin
                recognizedTextPositionTuples.append((rect: CGRect(x: x, y: y, width: width, height: height), text: text))
            }
        }
        textObservations.removeAll()
        DispatchQueue.main.async {
            let viewWidth = self.preview.frame.size.width
            let viewHeight = self.preview.frame.size.height
            guard let sublayers = self.preview.layer.sublayers else {
                return
            }
            for layer in sublayers[1...] {
                
                if let _ = layer as? CATextLayer {
                    layer.removeFromSuperlayer()
                }
            }
            self.detectedTextArray.removeAll()
            for tuple in recognizedTextPositionTuples {
                let textLayer = CATextLayer()
                textLayer.backgroundColor = UIColor.clear.cgColor
                var rect = tuple.rect
                
                rect.origin.x *= viewWidth
                rect.size.width *= viewWidth
                rect.origin.y *= viewHeight
                rect.size.height *= viewHeight
                
                textLayer.frame = rect
                textLayer.string = tuple.text
                textLayer.fontSize = rect.size.height
                textLayer.foregroundColor = UIColor.green.cgColor
                self.preview.layer.addSublayer(textLayer)
                self.detectedTextArray.append(tuple.text)
            }
        }
    }
}
