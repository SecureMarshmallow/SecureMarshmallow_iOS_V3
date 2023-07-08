import Foundation

// MARK: Global variables

var clocks: [Clock] = []
var subUrl: URL?
var cells: [ClockCell] = []

class StartViewModel {
    let fm = FileManager.default
    let mainUrl: URL? = Bundle.main.url(forResource: "Clocks", withExtension: "json")

    init() {
        getData()
    }
        
    func itemAt(_ index: Int) -> Clock? {
        guard let item = clocks.safeRef(index) else { return nil }
        return item
    }

    private func loadFile(mainPath: URL, subPath: URL){
        if fm.fileExists(atPath: subPath.path){
            decodeData(pathName: subPath)
        }else{
            decodeData(pathName: mainPath)
        }
    }

    private func decodeData(pathName: URL){
           do{
               let jsonData = try Data(contentsOf: pathName)
               let decoder = JSONDecoder()
               clocks = try decoder.decode([Clock].self, from: jsonData)
           } catch {}
       }

    private func getData() {
        do {
            print("json file gets read")
            let documentDirectory = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            subUrl = documentDirectory.appendingPathComponent("Clocks.json")
            loadFile(mainPath: mainUrl!, subPath: subUrl!)
        } catch {
            print(error)
        }
    }
}
