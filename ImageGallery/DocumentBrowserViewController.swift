//
//  DocumentBrowserViewController.swift
//  ImageGallery
//
//  Created by Samuel Germain on 2019-12-15.
//  Copyright © 2019 Sam G. All rights reserved.
//

import UIKit


class DocumentBrowserViewController: UIDocumentBrowserViewController, UIDocumentBrowserViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        allowsDocumentCreation = false
        allowsPickingMultipleItems = false
        
        if UIDevice.current.userInterfaceIdiom == .pad{
            template = try? FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("Untitled.imageGallery")
            if template != nil {
                allowsDocumentCreation = FileManager.default.createFile(atPath: template!.path, contents: Data())
            }
        }
    }
    
    var template: URL?
    
    // MARK: UIDocumentBrowserViewControllerDelegate
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didRequestDocumentCreationWithHandler importHandler: @escaping (URL?, UIDocumentBrowserViewController.ImportMode) -> Void) {
        
        let alert = UIAlertController(title: "Name", message: "Name the Gallery", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {_ in
            alert.textFields![0].placeholder = "Untitled"
        })
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
            let fileName = alert.textFields![0].text! + ".imageGallery"
            let newGal = try? FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask,   appropriateFor: nil, create: true).appendingPathComponent(fileName)
            FileManager.default.createFile(atPath: newGal!.path, contents: Data())
            importHandler(newGal, .copy)
        }))
        alert.addAction(UIAlertAction(title:"Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didPickDocumentsAt documentURLs: [URL]) {
        guard let sourceURL = documentURLs.first else { return }
        
        // Present the Document View Controller for the first document that was picked.
        // If you support picking multiple items, make sure you handle them all.
        presentDocument(at: sourceURL)
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didImportDocumentAt sourceURL: URL, toDestinationURL destinationURL: URL) {
        // Present the Document View Controller for the new newly created document
        presentDocument(at: destinationURL)
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, failedToImportDocumentAt documentURL: URL, error: Error?) {
        //Put up alert
    }
    
    // MARK: Document Presentation
    
    func presentDocument(at documentURL: URL) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let documentVC = storyBoard.instantiateViewController(withIdentifier: "DocumentVC")
        if let imageGalleryVC = documentVC.contents as? ImageGalleryViewController{
            imageGalleryVC.document = ImageGalleryDocument(fileURL: documentURL)
        }
        present(documentVC, animated: true)
    }
}

