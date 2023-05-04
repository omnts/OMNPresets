//
//  PresetFile.swift
//
//  Created by Omar M on 07/02/2019.
//  Copyright © 2019 All rights reserved.
//

import Cocoa

open class PresetFile: NSObject {
  fileprivate(set) var thumbnail: NSImage?
  fileprivate(set) var title: String
  public fileprivate(set) var section: String
  public fileprivate(set) var fileName: String
  fileprivate(set) var url: URL
  public fileprivate(set) var dictionary: NSDictionary?

  @objc public init?(url: URL) {
    self.url = url
    self.fileName = url.lastPathComponent
    self.thumbnail = nil
    self.dictionary = NSDictionary(contentsOf: self.url)
    
    if let dictionary = self.dictionary, let group = dictionary.object(forKey: "group"), group is String{
      self.section = group as? String ?? "None"
    } else {
      self.section = "None"
    }
    
    if let dictionary = self.dictionary, let title = dictionary.object(forKey: "description"), title is String{
      self.title = title as? String ?? "None"
    } else {
      self.title = "None"
    }
  }
}
