import Foundation
import UIKit
import MobileCoreServices
import AVFoundation
import Intents

public struct DcUtils {

    public static func getInitials(inputName: String) -> String {
        if let firstLetter = inputName.first {
            return firstLetter.uppercased()
        } else {
            return ""
        }
    }

    public static func donateSendMessageIntent(context: DcContext, chatId: Int, chatAvatar: UIImage?) {
        if #available(iOS 13.0, *) {
            let chat = context.getChat(chatId: chatId)
            let groupName = INSpeakableString(spokenPhrase: chat.name)

            let sendMessageIntent = INSendMessageIntent(recipients: nil,
                                                        content: nil,
                                                        speakableGroupName: groupName,
                                                        conversationIdentifier: "\(context.id).\(chatId)",
                                                        serviceName: nil,
                                                        sender: nil)

            // Add the user's avatar to the intent.
            if let imageData = chat.profileImage?.pngData() {
                let image = INImage(imageData: imageData)
                sendMessageIntent.setImage(image, forParameterNamed: \.speakableGroupName)
            } else if let imageData = chatAvatar?.pngData() {
                let image = INImage(imageData: imageData)
                sendMessageIntent.setImage(image, forParameterNamed: \.speakableGroupName)
            }

            // Donate the intent.
            let interaction = INInteraction(intent: sendMessageIntent, response: nil)
            interaction.groupIdentifier = "\(context.id)"
            interaction.donate(completion: { error in
                if error != nil {
                    context.logger?.error(error.debugDescription)
                }
            })
        }
    }

    static func copyAndFreeArray(inputArray: OpaquePointer?) -> [Int] {
        var acc: [Int] = []
        let len = dc_array_get_cnt(inputArray)
        for i in 0 ..< len {
            let e = dc_array_get_id(inputArray, i)
            acc.append(Int(e))
        }
        dc_array_unref(inputArray)

        return acc
    }

    static func copyAndFreeArrayWithLen(inputArray: OpaquePointer?, len: Int = 0) -> [Int] {
        var acc: [Int] = []
        let arrayLen = dc_array_get_cnt(inputArray)
        let start = max(0, arrayLen - len)
        for i in start ..< arrayLen {
            let e = dc_array_get_id(inputArray, i)
            acc.append(Int(e))
        }
        dc_array_unref(inputArray)

        return acc
    }

    static func copyAndFreeArrayWithOffset(inputArray: OpaquePointer?, len: Int? = 0, from: Int = 0, skipEnd: Int = 0) -> [Int] {
        let lenArray = dc_array_get_cnt(inputArray)
        let length = len ?? lenArray
        if lenArray <= skipEnd || lenArray == 0 {
            dc_array_unref(inputArray)
            return []
        }

        let start = lenArray - 1 - skipEnd
        let end = max(0, start - length)
        let finalLen = start - end + (length > 0 ? 0 : 1)
        var acc: [Int] = [Int](repeating: 0, count: finalLen)

        for i in stride(from: start, to: end, by: -1) {
            let index = finalLen - (start - i) - 1
            acc[index] = Int(dc_array_get_id(inputArray, i))
        }

        dc_array_unref(inputArray)
        print("got: \(from) \(length) \(lenArray) - \(acc)")

        return acc
    }

    public static func getMimeTypeForPath(path: String) -> String {
        let url = NSURL(fileURLWithPath: path)
        let pathExtension = url.pathExtension

        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension! as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream"
    }

    public static func generateThumbnailFromVideo(url: URL?) -> UIImage? {
		guard let url = url else {
			return nil
		}
		do {
			let asset = AVURLAsset(url: url)
			let imageGenerator = AVAssetImageGenerator(asset: asset)
			imageGenerator.appliesPreferredTrackTransform = true
			let cgImage = try imageGenerator.copyCGImage(at: .zero, actualTime: nil)
			return UIImage(cgImage: cgImage)
		} catch {
			print(error.localizedDescription)
			return nil
		}
	}

	public static func thumbnailFromPdf(withUrl url: URL, pageNumber: Int = 1, width: CGFloat = 240) -> UIImage? {
		guard let pdf = CGPDFDocument(url as CFURL),
			let page = pdf.page(at: pageNumber)
			else {
				return nil
		}

		var pageRect = page.getBoxRect(.mediaBox)
		let pdfScale = width / pageRect.size.width
		pageRect.size = CGSize(width: pageRect.size.width*pdfScale, height: pageRect.size.height*pdfScale)
		pageRect.origin = .zero

		UIGraphicsBeginImageContext(pageRect.size)
		let context = UIGraphicsGetCurrentContext()!

		// White BG
		context.setFillColor(UIColor.white.cgColor)
		context.fill(pageRect)
		context.saveGState()

		// Next 3 lines makes the rotations so that the page look in the right direction
		context.translateBy(x: 0.0, y: pageRect.size.height)
		context.scaleBy(x: 1.0, y: -1.0)
		context.concatenate(page.getDrawingTransform(.mediaBox, rect: pageRect, rotate: 0, preserveAspectRatio: true))

		context.drawPDFPage(page)
		context.restoreGState()

		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return image
	}

    public static func getConnectivityString(dcContext: DcContext, connectedString: String) -> String {
        let connectivity = dcContext.getConnectivity()
        if connectivity >= DC_CONNECTIVITY_CONNECTED {
            return connectedString
        } else if connectivity >= DC_CONNECTIVITY_WORKING {
            return String.localized("connectivity_updating")
        } else if connectivity >= DC_CONNECTIVITY_CONNECTING {
          return String.localized("connectivity_connecting")
        } else {
          return String.localized("connectivity_not_connected")
        }
    }
}
