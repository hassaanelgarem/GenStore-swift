# GenStoreSwift

GenStoreSwift is a lightweight swift code generator for your resources. GenStoreSwift can create classes for your images, colors and localized strings.

Using String-based APIs to access your resources has many drawbacks. There's always the risk of typos, as well as using resources that are no longer there. Auto generating code from resources and using it ensures that all the drawbacks from using String-based APIs will simply cease to exist as they will be automatically caught while compiling. You will also have the benefit of auto-completion which is always cool.

## Installation

### Using [Mint](https://github.com/yonaskolb/Mint)

```shell
$ mint install hassaanelgarem/swift-store-generator
```

### From Source

```shell
Update after implementing
```

## Usage

```shell
$ gen-store --type <type> --source <source> --output <output>
```

Options:

- **--type**: Type of the store being generated. Accepted values: [`colors`, `images`, `strings`]
- **--source**: Path of the source used to generate the store
- **--output:** Path of the output file

All three options are required for the command to run.
For more details use: `gen-store --help`

<details>
  <summary><strong>Strings Store Example</strong></summary>
  <br>
  To generate a swift class from a .strings file use the following command:

```shell
$ gen-store --type strings --source Localizable.strings --output StringsStore.swift
```

Given the following `Localizable.strings` file:

```
"jim" = "Bears. Beets. Battlestar Galactica.";
"dwight" = "Identity theft is not a joke, Jim!";
```

The generated code will look like this:

```swift
class StringsStore {

	static let jim = "jim".localized
	static let dwight = "dwight".localized

}

fileprivate extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
```

And now you can use it this way in your code:

```swift
let message = StringsStore.jim
let reply = StringsStore.dwight
```
  
  ---
</details>

<details>
  <summary><strong>Colors Store Example</strong></summary>
  <br>
To generate a swift class represting your colors from an xcassets file use the following command:

```shell
$ gen-store --type colors --source Colors.xcasseets --output ColorsStore.swift
```

Given the following `Colors.xcasseets` file:

![Screen Shot 2021-09-29 at 4.31.30 AM.png](Store%20Generator%20README%2028f55e72b08a41008b04962059316f74/Screen_Shot_2021-09-29_at_4.31.30_AM.png)

The generated code will look like this:

```swift
class ColorsStore {

	static let dijonMustard: UIColor = Self.unwrappedColor(named: "dijonMustard")
	static let spicyBrown: UIColor = Self.unwrappedColor(named: "spicyBrown")
	static let yellowMustard: UIColor = Self.unwrappedColor(named: "yellowMustard")

    static func unwrappedColor(named name: String) -> UIColor {
        guard let color = UIColor(named: name) else {
            print("[ERROR] - Color with name (\"\(name)\") not found in assets cataloug")
            return UIColor.white
        }
        return color
    }
}
```

And now you can use it this way in your code:

```swift
let shirtColor = ColorsStore.spicyBrown
```
  
  ---
</details>

<details>
  <summary><strong>Images Store Example</strong></summary>
  <br>
To generate a swift class represting your images from an xcassets file use the following command:

```shell
$ gen-store --type images --source Images.xcasseets --output ImagesStore.swift
```

Given the following `Images.xcasseets` file:

![Screen Shot 2021-09-29 at 4.36.33 AM.png](Store%20Generator%20README%2028f55e72b08a41008b04962059316f74/Screen_Shot_2021-09-29_at_4.36.33_AM.png)

The generated code will look like this:

```swift
class ImagesStore {

	static var babiesPoster: UIImage? {
		return UIImage(named: "babiesPoster")
	}

	static var chairModel: UIImage? {
		return UIImage(named: "chairModel")
	}
}
```

And now you can use it this way in your code:

```swift
let theOne = ImagesStore.chairModel
```
  
  ---
</details>

## Xcode Integration

To make the best out of GenStoreSwift, you should integrate it in your Xcode project by adding it as a "Run Script Build Phase". By doing so, this will generate your classes every time you build your project, which will make sure that your generated classes are always up to date.

Adding a new script phase:

1. Open project file form inside Xcode by selecting it from the project navigator on the left
2. Select your app target
3. Select "Build Phases" tab
4. Click on the "+" button to add a new phase then select "New Run Script Phase"
5. Name the new phase whatever you want
6. Fill in the script the same way you would use GenStoreSwift in the terminal. You can make use of environment variables to make the script work on any machine. Your script can look something like this:
    
    ```shell
    gen-store -t strings -s $SRCROOT/Example/Storyboards/en.lproj/Localizable.strings -o $SRCROOT/Example/Stores/StringsStore.swift
    gen-store -t images -s $SRCROOT/Example/Resources/Assets.xcassets -o $SRCROOT/Example/Stores/ImagesStore.swift
    gen-store -t colors -s $SRCROOT/Example/Resources/Assets.xcassets -o $SRCROOT/Example/Stores/ColorsStore.swift
    ```
    

## Alternatives

If GenStoreSwift doesn't meet your needs try [SwiftGen](https://github.com/SwiftGen/SwiftGen) which is a great alternative.

## License

GenStoreSwift is licensed under the MIT license. See LICENSE for more info.
