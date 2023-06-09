import OMNTools
import Foundation

@objc public class OMNPresetsDirectoryScanner: NSObject {
    public var directoryScanner: OMNDirectoryScanner?
    @objc public var presetFilesOrderedBySection = [String:[PresetFile]]()
    public var singleSectionMode = true
    fileprivate(set) var rootURL: URL

    //  func indexOfSection(named: String) -> Int {
    //    for (index,arrayPreset) in self.presetFilesOrderedBySection.enumerated() {
    //      if arrayPreset.count > 0, arrayPreset[0].section == named {
    //        return index
    //      }
    //    }
    //    return -1
    //  }

    @objc public init?(rootURL: URL) {
        self.rootURL = rootURL
        directoryScanner = OMNDirectoryScanner(rootURL: rootURL)
    }

    public func numberOfSections() -> Int {
        if self.singleSectionMode {
            return 1
        }

        return self.presetFilesOrderedBySection.keys.count
    }

    public func numberOfItemsInSection(_ section: Int) -> Int {
        if let presets = self.presetsAtIndex(section) {
            return presets.count
        }

        return 0
    }

    public func presetsAtIndex(_ section: Int) -> [PresetFile]? {
        let keys = self.presetFilesOrderedBySection.keys
        let sections = Array(keys).sorted()

        if sections.count > section {
            let sectionName = sections[section]
            if let presets = self.presetFilesOrderedBySection[sectionName] {
                return presets
            }
        }
        return nil
    }

    public func presetFileAtIndexPath(indexPath: IndexPath) -> PresetFile? {
        let section = indexPath.section
        let row = indexPath.item

        if let presets = self.presetsAtIndex(section), presets.count > row {
            let presetFile = presets[row]
            return presetFile
        }

        return nil
    }

    @objc public func populateArrayPreset() {
        guard let scanner = directoryScanner else {
            print("self.presetFilesOrderedBySection = \(self.presetFilesOrderedBySection)")

            return
        }
        if scanner.scanFolder() {
            for (_,fileUrl) in scanner.files.enumerated() {
                if let presetFile = PresetFile(url: fileUrl), let presetDict = presetFile.dictionary, presetDict["group"] != nil {
                    let section = presetDict["group"] as! String
                    if var sectionsArray = self.presetFilesOrderedBySection[section] {
                        sectionsArray.append(presetFile)
                        self.presetFilesOrderedBySection[section] = sectionsArray
                    } else {
                        var array =  [PresetFile]()
                        array.append(presetFile)
                        self.presetFilesOrderedBySection[section] = array
                    }
                }
            }
        }
        print("self.presetFilesOrderedBySection = \(self.presetFilesOrderedBySection)")
    }
}
